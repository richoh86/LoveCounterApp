//
//  SettingsViewController.swift
//  LoveCounterApp
//
//  Created by richard oh on 20/03/2019.
//  Copyright © 2019 richard oh. All rights reserved.
//

import UIKit
import SnapKit
import MessageUI
import StoreKit
import UserNotifications

class SettingsViewController: UIViewController, MFMailComposeViewControllerDelegate {

    let settingsView = SettingView()
    var datePickerView: DatePickerView?
    var mailVC: MFMailComposeViewController?
    
    let center = UNUserNotificationCenter.current()
    var pushAlarmBool: Bool?
    var pushAlarmForBirthAndAnniBool: Bool?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func commonInit(){
        self.view.backgroundColor = UIColor.clear
        
        settingsView.exitBtn.addTarget(self, action: #selector(exitBtnAction), for: .touchUpInside)
        
        // "기본 설정" 버튼 액션 설정
        settingsView.btnForTitle1ViewInSection1.addTarget(self, action: #selector(coupleDateChangeBtn), for: .touchUpInside)
        settingsView.btnForTitle2ViewInSection1.addTarget(self, action: #selector(yourBirthDayChangeBtn), for: .touchUpInside)
        settingsView.btnForTitle3ViewInSection1.addTarget(self, action: #selector(myBirthDayChangeBtn), for: .touchUpInside)
        
        // "알람 설정" 버튼 액션 설정
        settingsView.btnForTitle1ViewInSection2.addTarget(self, action: #selector(pushAlarmStateChangeBtn), for: .touchUpInside)
        settingsView.btnForTitle2ViewInSection2.addTarget(self, action: #selector(pushAlarmForBirthDayAndAnniversaryDayChangeBtn), for: .touchUpInside)
        
        // 푸쉬알람 설정 후 앱 종료한 후에 다시 들어가서 확인해보면 셋팅한 상태대로 화면에 보이지 않음
        // 확인필요!!
        
        // 여기서는 저장된 값이 나오지 않음
        let pushAlarmBool = UserDefaults.standard.bool(forKey: "pushAlarm")
        let pushAlarmForBirthAndAnniBool = UserDefaults.standard.bool(forKey: "pushAlarmForBirthAndAnniBool")
        
            print(pushAlarmBool, "pushAlarm UserDefault")
            print(pushAlarmForBirthAndAnniBool, "bAAlarmBool UserDefault")
        
            if pushAlarmBool { // true
                settingsView.indicatorImg1ForSection2.alpha = 1.0
            }else{ // false
                settingsView.indicatorImg1ForSection2.alpha = 0.3
            }
        
            if pushAlarmForBirthAndAnniBool { // true
                settingsView.indicatorImg2ForSection2.alpha = 1.0
            }else{ // false
                settingsView.indicatorImg2ForSection2.alpha = 0.3
            }
        
        self.pushAlarmBool = pushAlarmBool
        self.pushAlarmForBirthAndAnniBool = pushAlarmForBirthAndAnniBool
        
        // "LoveCounter" 버튼 설정
        settingsView.btnForTitle1ViewInSection3.addTarget(self, action: #selector(askActionBtn), for: .touchUpInside)
        settingsView.btnForTitle2ViewInSection3.addTarget(self, action: #selector(reviewActionBtn), for: .touchUpInside)
        
        self.view.addSubview(settingsView)
        
        updateAutoLayout()
    }
    
    // 나가기 버튼
    @objc func exitBtnAction(){
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // 기본 설정
    @objc func coupleDateChangeBtn(sender: UIButton){
        
        print(sender.tag)
        datePickerView = DatePickerView(btnTag: sender.tag)
        if let date = UserDefaults.standard.value(forKey: "selDate") as? Date{
            datePickerView?.datePickerView.date = date
        }
        
        // datePickerView 완료 버튼 설정
        datePickerView?.completeBtn.addTarget(self, action: #selector(removeDatePickerViewAndSaveDate), for: .touchUpInside)
        guard let view = datePickerView else {return}
        self.view.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func yourBirthDayChangeBtn(sender: UIButton){
        print(sender.tag)
        datePickerView = DatePickerView(btnTag: sender.tag)
        if let date = UserDefaults.standard.value(forKey: "LoveBirthDay") as? Date{
            datePickerView?.datePickerView.date = date
        }
        // datePickerView 완료 버튼 설정
        datePickerView?.completeBtn.addTarget(self, action: #selector(removeDatePickerViewAndSaveDate), for: .touchUpInside)
        guard let view = datePickerView else {return}
        self.view.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func myBirthDayChangeBtn(sender: UIButton){
        datePickerView = DatePickerView(btnTag: sender.tag)
        if let date = UserDefaults.standard.value(forKey: "myBirthDay") as? Date{
            datePickerView?.datePickerView.date = date
        }
        // datePickerView 완료 버튼 설정
        datePickerView?.completeBtn.addTarget(self, action: #selector(removeDatePickerViewAndSaveDate), for: .touchUpInside)
        guard let view = datePickerView else {return}
        self.view.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // picker view 없애고 날짜 UserDefault에 저장하기
    @objc func removeDatePickerViewAndSaveDate(){
        
        guard let selDate = datePickerView?.datePickerView.date else {return}
        guard let btnTag = datePickerView?.btnTag else {return}
        
        // 위젯 설정용 날짜 저장
        // 2019.04.25 OHWS
        let widgetUd = UserDefaults(suiteName: "group.LoveCounter.widget")
        widgetUd?.set(selDate, forKey: "selDate")
        
        let curDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        // 연인이 된 날짜 변경 로직 (버튼 태그: 101)
        if btnTag == 101 {
            
            let strSelDate = dateFormatter.string(from: selDate)
            
            let calendar = Calendar.current
            let date1 = calendar.startOfDay(for: selDate)
            let date2 = calendar.startOfDay(for: curDate)
            
            print(date1)
            print(date2)
            
            var components = calendar.dateComponents([.day, .hour, .minute, .second], from: date1, to: date2)
            
            // 하루 차이는 계산되지 않음.....ㅜㅜㅜ hours를 00:00으로 설정하는법을 찾을 것
            // 위 startOfDay(for: Date)가 시작 시간으로 만들어줌
            var days = 0
            if let day = components.day {
                days = day + 1
            }
            
            // 날짜 차이가 0보다 작은 경우 메세지를 띄어준다
            if days <= 0 {
                let action1 = UIAlertAction(title: "예", style: UIAlertAction.Style.default)
                let alertVC = UIAlertController(title: "날짜확인", message: "오늘 날짜 이후로는 설정할 수 없습니다!", preferredStyle: UIAlertController.Style.alert)
                alertVC.addAction(action1)
                self.present(alertVC, animated: true, completion: nil)
            
            // 날짜 차이가 0보다 크거나 0인 경우 날짜를 저장하고 옵저버를 작동시킨다
            }else{
                UserDefaults.standard.set(selDate, forKey: "selDate")
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "countDayAndDateTextChange"), object: nil, userInfo: ["dateText": strSelDate])
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "countDayAndDateTextChange"), object: nil, userInfo: ["countedDay": days])
            }

        // 내꺼 생일 날짜 변경
        }else if btnTag == 102 {
            UserDefaults.standard.set(selDate, forKey: "LoveBirthDay")
        
        // 본인 생일 날짜 변경
        }else if btnTag == 103 {
            UserDefaults.standard.set(selDate, forKey: "myBirthDay")
        }

        self.datePickerView?.removeFromSuperview()
    }
    
    // 푸쉬 알림 설정
    @objc func pushAlarmStateChangeBtn() {
        
        self.pushAlarmBool = !self.pushAlarmBool!
        
        if self.pushAlarmBool! { // 알람 설정 ON: True
            // 알람설정 권한 상태가 허용된 상태인지 확인하고 요청하는 화면을 보여준다...
            let options: UNAuthorizationOptions = [.sound, .alert, .badge]
            center.requestAuthorization(options: options) { (granted, error) in
                if let err = error {
                    print(err.localizedDescription)
                }else{
                    print(granted)
                    
                    if granted == false {
                        
                        let alertVC = UIAlertController(title: "알림설정", message: "설정 -> 알림 -> 러브카운터 -> 알림허용 스위치를 On으로 변경해주세요!", preferredStyle: UIAlertController.Style.alert)
                        let action1 = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { (action) in
                             self.pushAlarmBool = !self.pushAlarmBool!
                        })
                        
                        alertVC.addAction(action1)
                        self.present(alertVC, animated: true, completion: nil)
                    }else{
                        DispatchQueue.main.sync {
//                            self.pushAlarmBool = !self.pushAlarmBool!
                            self.settingsView.indicatorImg1ForSection2.alpha = 1.0
                            print("push alarm ON!!")
                            UserDefaults.standard.set(true, forKey: "pushAlarm")
                        }
                    }
    
                }
            }
    
        }else{ // 알람 설정 OFF: False

            DispatchQueue.main.async {
                // 1. 푸쉬 알람 설정 해제
                self.settingsView.indicatorImg1ForSection2.alpha = 0.3
                print("push alarm OFF!!")
                UserDefaults.standard.set(false, forKey: "pushAlarm")
            }
            
//            let alertVC = UIAlertController(title: "알림설정", message: "푸쉬알람이 설정안되면\n생일 및 기념일 알람도 자동으로 꺼집니다", preferredStyle: UIAlertController.Style.alert)
//            let action1 = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { (action) in
//                DispatchQueue.main.async {
//
//                    // 1. 푸쉬 알람 설정 해제
//                    self.settingsView.indicatorImg1ForSection2.alpha = 0.3
//                    print("push alarm OFF!!")
//                    UserDefaults.standard.set(false, forKey: "pushAlarm")
//
//                    // 2. 생일 및 기념일 알람 해제
//                    self.settingsView.indicatorImg2ForSection2.alpha = 0.3
//                    print("push alarm for Birth and Anni OFF!!")
//                    UserDefaults.standard.set(false, forKey: "pushAlarmForBirthAndAnniBool")
//                    // 2. 생일 및 기념일 알람 해제 불 값도 바꿔준다
//                    self.pushAlarmForBirthAndAnniBool = !self.pushAlarmForBirthAndAnniBool!
//                }
//            }
//
//            alertVC.addAction(action1)
//            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    // 생일 & 기념일 알림 설정
    @objc func pushAlarmForBirthDayAndAnniversaryDayChangeBtn() {
        
        self.pushAlarmForBirthAndAnniBool = !self.pushAlarmForBirthAndAnniBool!
        
        if self.pushAlarmForBirthAndAnniBool! {
//             알람설정 권한 상태가 허용된 상태인지 확인하고 요청하는 화면을 보여준다...
            let options: UNAuthorizationOptions = [.sound, .alert, .badge]
            center.requestAuthorization(options: options) { (granted, error) in
                if let err = error {
                    print(err.localizedDescription)
                }else{
                    print(granted)
                    if granted == false {
                        let alertVC = UIAlertController(title: "알림설정", message: "설정 -> 알림 -> 러브카운터 ->\n알림허용 스위치를 On으로 변경해주세요!", preferredStyle: UIAlertController.Style.alert)
                        let action1 = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { (action) in
                            self.pushAlarmForBirthAndAnniBool = !self.pushAlarmForBirthAndAnniBool!
                        })
                        alertVC.addAction(action1)
                        self.present(alertVC, animated: true, completion: nil)
                        
                    }else{
                        
                        DispatchQueue.main.async {
                            self.settingsView.indicatorImg2ForSection2.alpha = 1.0
                            print("push alarm for Birth and Anni ON!!")
                            // 알림상태가 허용된것으로 확인되면 true값으로 변경해준다
                            UserDefaults.standard.set(true, forKey: "pushAlarmForBirthAndAnniBool")
                        }
                    }
                }
            }

        }else{
            
            DispatchQueue.main.async {
                self.settingsView.indicatorImg2ForSection2.alpha = 0.3
                print("push alarm for Birth and Anni OFF!!")
                UserDefaults.standard.set(false, forKey: "pushAlarmForBirthAndAnniBool")
//                self.pushAlarmForBirthAndAnniBool = !self.pushAlarmForBirthAndAnniBool!
            }
        }
        
//        UserDefaults.standard.set(pushAlarmForBirthAndAnniBool, forKey: "pushAlarmForBirthAndAnniBool")
    }
    
    // LoveCounter 설정
    /// 문의하기
    @objc func askActionBtn(){
        guard MFMailComposeViewController.canSendMail() else {return}
       
        mailVC = MFMailComposeViewController()
        mailVC?.mailComposeDelegate = self
        mailVC?.setToRecipients(["wsoh1986@gmail.com"])
        
        self.present(mailVC!, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        mailVC?.dismiss(animated: true, completion: nil)
    }
    
    /// 리뷰 남기기
    @objc func reviewActionBtn(){
        SKStoreReviewController.requestReview()
    }

    override func viewWillLayoutSubviews() {
        settingsView.scrollView.contentSize = CGSize(width: self.accessibilityFrame.width, height: 900)
    }
    
    /// 레이아웃설정
    private func updateAutoLayout(){
        
        settingsView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
        }
    }

}
    


