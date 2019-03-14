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
        createUI()
    }
    
    private func createUI(){
        
        mainView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        
        mainView.settingBtn.addTarget(self, action: #selector(settingBtnAction), for: .touchUpInside)
        
        // 계산된 날짜 가져오기 (만나지 얼마나 됐는지)
        self.calDateText()
        self.view.addSubview(mainView)
    }
    
    @objc func settingBtnAction(){
        print("setting button pushed!!")
        // 설정 페이지 넘어가는 부분
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
            
            if days > 0 {
                mainView.textLb.text = "+\(days)일"
            }else{
                mainView.textLb.text = "\(-days)일"
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        let shapeLayer = mainView.createShapeLayer()
        mainView.shapeLayer.position.x = self.view.center.x
        mainView.shapeLayer.position.y = self.view.center.y - 70
        self.view.layer.addSublayer(shapeLayer)
    }
    
    // status bar -> white color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
