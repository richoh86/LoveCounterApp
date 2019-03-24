//
//  SettingsViewController.swift
//  LoveCounterApp
//
//  Created by richard oh on 20/03/2019.
//  Copyright © 2019 richard oh. All rights reserved.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {

    let settingsView = SettingView()
    var datePickerView: DatePickerView?
    
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
        
        print("연인이 된 날짜 로우 클릭!!")
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
        print("내꺼 생일 날짜 변경 로우 클릭!!")
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
        print("본인 생일 날짜 변경 로우 클릭!!")
        print(sender.tag)
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
        
        let curDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        // 연인이 된 날짜 변경 로직 (버튼 태그: 101)
        if btnTag == 101 {
            print("101 태그 버튼 확인!!",btnTag)
            
            // 1. UserDefault 저장
            UserDefaults.standard.set(selDate, forKey: "selDate")
            
            // 2. 현재 메인 화면상 날짜 및 카운트 데이 변경 로직 추가 필요
            let strSelDate = dateFormatter.string(from: selDate)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "countDayAndDateTextChange"), object: nil, userInfo: ["dateText": strSelDate])
            
            let intervals = curDate.timeIntervalSince(selDate)
            let days = Int(intervals/86400)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "countDayAndDateTextChange"), object: nil, userInfo: ["countedDay": days])
        
        // 내꺼 생일 날짜 변경
        }else if btnTag == 102 {
            UserDefaults.standard.set(selDate, forKey: "LoveBirthDay")
        
        // 본인 생일 날짜 변경
        }else if btnTag == 103 {
            UserDefaults.standard.set(selDate, forKey: "myBirthDay")
        }

        self.datePickerView?.removeFromSuperview()
    }
    
    // 알림 설정
    @objc func pushAlarmStateChangeBtn() {
        print("push alarm change")
    }
    
    @objc func pushAlarmForBirthDayAndAnniversaryDayChangeBtn() {
        print("push alarm for Birth and Anni change!!")
    }
    
    // LoveCounter 설정
    @objc func askActionBtn(){
        print("문의하기 로우 클릭!!")
    }
    
    @objc func reviewActionBtn(){
        print("리뷰 남기기 클릭!!")
    }

    private func updateAutoLayout(){
        
        settingsView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
        }
    }

}
