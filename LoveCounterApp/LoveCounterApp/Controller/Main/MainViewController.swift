//
//  MainViewController.swift
//  LoveCounterApp
//
//  Created by richard oh on 13/03/2019.
//  Copyright © 2019 richard oh. All rights reserved.
//

import UIKit
import UserNotifications

class MainViewController: UIViewController, UNUserNotificationCenterDelegate {

    @IBOutlet weak var backgroundImg: UIImageView!
    
    let mainView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfileImgFileFromDocumentDirectory()
        countedDayAndDateTextChangeObserver()
        imageChangeObserver()
        nameChangeObserver()
        createUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Push Alarm 권한 요청 및 설정
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.sound, .alert]
        
        center.requestAuthorization(options: options) { (granted, error) in
            if let err = error {
                print(err.localizedDescription)
            }else{
                print(granted)
                // 권한 요청 허용시 알림 설정을 모두 켜준다
                UserDefaults.standard.set(granted, forKey: "pushAlarm")
                UserDefaults.standard.set(granted, forKey: "pushAlarmForBirthAndAnniBool")
            }
        }
        center.delegate = self
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
    
    private func getProfileImgFileFromDocumentDirectory() {
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        
        if let dirPath = paths.first {
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("profileImg1.png")
            let image = UIImage(contentsOfFile: imageURL.path)
            self.mainView.circleViewForPic1.image = nil
            self.mainView.circleViewForPic1.image = image
        }else{
            self.mainView.circleViewForPic1.image = nil
        }
        
        if let dirPath = paths.first {
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("profileImg2.png")
            let image = UIImage(contentsOfFile: imageURL.path)
            self.mainView.circleViewForPic2.image = nil
            self.mainView.circleViewForPic2.image = image
        }else{
            self.mainView.circleViewForPic2.image = nil
        }
    }
    
    func countedDayAndDateTextChangeObserver(){
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "countDayAndDateTextChange"), object: nil, queue: nil) { noti in
            
            if let dateText = noti.userInfo?["dateText"] as? String {
                self.mainView.topTitle.text =
                "\(dateText)!\n우리의 사랑은 시작되었다."
            }
            
            if let countedDay = noti.userInfo?["countedDay"] as? Int {
                print(countedDay)
                if countedDay >= 0 {
                    
                    // 1,2,3.. 주년의 경우 텍스트를 바꿔서 보여준다
                    if countedDay % 366 == 0{
                        self.mainView.textLb.text = "\(countedDay / 366)주년"
                    }else{
                        self.mainView.textLb.text = "\(countedDay)일"
                    }
                }
            }
        }
    }
    
    func imageChangeObserver(){
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "imageChange"), object: nil, queue: nil) { (noti) in
            
            if let image1 = noti.userInfo?["image1"] as? UIImage{
                self.mainView.circleViewForPic1.image = image1
            }
            
            if let image2 = noti.userInfo?["image2"] as? UIImage{
                self.mainView.circleViewForPic2.image = image2
            }
        }
        
    }
    
    func nameChangeObserver(){
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "nameChange"), object: nil, queue: nil) { (noti) in
            if let name1 = noti.userInfo?["name1"] as? String{
                self.mainView.name1.text = name1
            }
            if let name2 = noti.userInfo?["name2"] as? String{
                self.mainView.name2.text = name2
            }
        }
    }
    
    private func createUI(){
        
        mainView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        
        mainView.settingBtn.addTarget(self, action: #selector(settingBtnAction), for: .touchUpInside)
        mainView.arrowBtn.addTarget(self, action: #selector(arrowBtnAction), for: .touchUpInside)
        
        mainView.btnForChangeNameImg1.addTarget(self, action: #selector(changeNameOrImgAction), for: .touchUpInside)
        mainView.btnForChangeNameImg2.addTarget(self, action: #selector(changeNameOrImgAction), for: .touchUpInside)
        
        // 계산된 날짜 가져오기 (만나지 얼마나 됐는지)
        self.calDateText()
        self.view.addSubview(mainView)
    }
    
    /// 이름 또는 프로필 사진 변경 팝업 VC 버튼 Action
    /// ChangeNameAndImg VC 이동
    @objc func changeNameOrImgAction(sender: UIButton){

        print(sender.tag)
        let nameAndImgVC = NameAndImgChangeViewController(btnTag: sender.tag)
        nameAndImgVC.modalPresentationStyle = .overCurrentContext
        nameAndImgVC.modalTransitionStyle = .crossDissolve
        self.present(nameAndImgVC, animated: true, completion: nil)
        
    }

    /// CalenderVC 이동
    @objc func arrowBtnAction(){
    
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let calendarVC = storyBoard.instantiateViewController(withIdentifier: "CalendarViewController")
        calendarVC.modalPresentationStyle = .overFullScreen
        self.present(calendarVC, animated: true)
    }
    
    @objc func settingBtnAction(){
        // 설정 페이지 넘어가는 부분
        
        let settingVC = SettingsViewController()
        settingVC.modalPresentationStyle = .overFullScreen
        settingVC.modalTransitionStyle = .crossDissolve
        self.present(settingVC, animated: true, completion: nil)
        
    }
    
    /// 유저가 입력한 연인이된날(선택날짜)을 기준으로 현재까지 날짜를 계산하여 화면에 보여주는 함수
    func calDateText(){
        
        // 선택된 날짜 (연인이 된 날짜) 앱 처음 실행시 입력값 UserDefault에서 가져온다
        if let selectedDate = UserDefaults.standard.value(forKey: "selDate") as? Date {
            
            // 현재 날짜
            let currentDate = Date()
            let calendar = NSCalendar.current
            let date1 = calendar.startOfDay(for: selectedDate)
            let date2 = calendar.startOfDay(for: currentDate)
            let components = calendar.dateComponents([.day], from: date1, to: date2)
            
            if let numberOfDay = components.day {
                
                let days = numberOfDay + 1
                if days % 366 == 0 {
                    mainView.textLb.text = "\(days / 366)주년"
                }else{
                    // 연인이 된 날짜도 1일로 카운트하기 때문에 날짜 차이값에서 1을 더해준다
                    mainView.textLb.text = "\(numberOfDay + 1)일"
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        let shapeLayer = mainView.createShapeLayer()
        mainView.shapeLayer.position.x = self.view.center.x
        mainView.shapeLayer.position.y = self.view.center.y - 70
//        mainView.shapeLayer.borderColor = #colorLiteral(red: 0.9943013787, green: 0.4424599409, blue: 0.4413398504, alpha: 1)
        self.view.layer.addSublayer(shapeLayer)
    }
    
    // status bar -> white color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "countDayAndDateTextChange"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "imageChange"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "nameChange"), object: nil)
    }
    
}
