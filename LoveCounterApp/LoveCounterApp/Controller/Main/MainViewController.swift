//
//  MainViewController.swift
//  LoveCounterApp
//
//  Created by richard oh on 13/03/2019.
//  Copyright © 2019 richard oh. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var backgroundImg: UIImageView!
    
    let mainView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        getProfileImgFileFromDocumentDirectory()
        imageChangeObserver()
        nameChangeObserver()
        createUI()
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
    
    func imageChangeObserver(){
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "imageChange"), object: nil, queue: nil) { (noti) in
            
            if let image1 = noti.userInfo?["image1"] as? UIImage{
                print("image1 호출",image1)
                self.mainView.circleViewForPic1.image = image1
            }
            
            if let image2 = noti.userInfo?["image2"] as? UIImage{
                print("image2 호출", image2)
                self.mainView.circleViewForPic2.image = image2
            }
        }
        
    }
    
    func nameChangeObserver(){
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "nameChange"), object: nil, queue: nil) { (noti) in
            if let name1 = noti.userInfo?["name1"] as? String{
                print(name1)
                self.mainView.name1.text = name1
            }
            if let name2 = noti.userInfo?["name2"] as? String{
                print(name2)
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
        
        print("아래 화살표 버튼 pushed!!")
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let calendarVC = storyBoard.instantiateViewController(withIdentifier: "CalendarViewController")
        calendarVC.modalPresentationStyle = .overFullScreen
        self.present(calendarVC, animated: true)
    }
    
    @objc func settingBtnAction(){
        print("setting button pushed!!")
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
            // Date 포맷은 yyyy.MM.dd
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "yyyy.MM.dd"
            // 선택된 시간 String 값을 변환
            let strSelectedDate = dateFormatter1.string(from: selectedDate)
            // 현재 날짜
            let currentDate = Date()
            // 현재 날짜 String으로 가져오기
            let strCurDate = dateFormatter1.string(from: currentDate)
            // 현재 날짜 다시 포맷에 맞게 date 로 타입 변환
            let curDate = dateFormatter1.date(from: strCurDate)!
            // 연인이 된 날짜 String -> Date
            let selDate = dateFormatter1.date(from: strSelectedDate)!
            // 연인이 된 날짜로 부터 현재 날짜까지 차이 계산
            let interval = selDate.timeIntervalSince(curDate)
            // 연인이 된 날짜와 현재 날짜의 차이 계산 값
            let days = Int(interval / 86400)
            print("\(days) 차이.")
            
            // 연인이 된 날짜 첫날은 1일로 보기 때문에 차이 값에서 1을 더 해준다
            if days > 0 {
                mainView.textLb.text = "+\(days + 1)일"
            }else{
                mainView.textLb.text = "\(-(days - 1))일"
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
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "imageChange"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "nameChange"), object: nil)
    }
    
}
