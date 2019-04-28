//
//  TodayViewController.swift
//  LoveCounterWidget
//
//  Created by richard oh on 25/04/2019.
//  Copyright © 2019 richard oh. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var textLb: UILabel!
    
    @IBOutlet weak var name1: UILabel!
    @IBOutlet weak var name2: UILabel!
    
    @IBOutlet weak var profileView1: UIView!
    @IBOutlet weak var profileView2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
    }
    
    @IBAction func tapWidgetAction(_ sender: Any) {
        
        extensionContext?.open(URL(string: "LoveCounter://")!, completionHandler: { success in
            print("\(success): 호출 성공!")
        })
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        print("widgetPerformUpdate")
        // 날짜 계산
        guard let widgetUd = UserDefaults(suiteName: "group.LoveCounter.widget") else {return}
        
        textLb.text = "1일처럼!"
        
        if let selDate = widgetUd.value(forKey: "selDate") as? Date {
            
            let curDate = Date()
            
            let calendar = Calendar.current
            let date1 = calendar.startOfDay(for: selDate)
            let date2 = calendar.startOfDay(for: curDate)
            
            var components = calendar.dateComponents([.day, .hour, .minute, .second], from: date1, to: date2)
            
            // 하루 차이는 계산되지 않음.....ㅜㅜㅜ hours를 00:00으로 설정하는법을 찾을 것
            // 위 startOfDay(for: Date)가 시작 시간으로 만들어줌
            var days = 0
            if let day = components.day {
                days = day + 1
            }
            self.textLb.text = "\(days)일"
            self.textLb.font = UIFont.boldSystemFont(ofSize: 40)
            self.textLb.textColor = .white
            self.textLb.textAlignment = .center
        }
        
        // 프로필 이미지 대신 이름 텍스트로 대체!
        // 2019.04.28 OHWS
        name1.textAlignment = .center
        name1.textColor = .white
        name1.font = UIFont.systemFont(ofSize: 25)
        name1.text = "본인"
        
        name2.textAlignment = .center
        name2.textColor = .white
        name2.font = UIFont.systemFont(ofSize: 25)
        name2.text = "내꺼"
        
        if let name1FromUserDefault = widgetUd.value(forKey: "name1") as? String,
            let name2FromUserDefault = widgetUd.value(forKey: "name2") as? String {
            name1.text = name1FromUserDefault
            name2.text = name2FromUserDefault
        }
        
        // 프로필 이미지 보여주기
        // 이미지 용량 처리 문제로 추후 Crop 기능 추가시 연결 할 것
//        if let fileURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.LoveCounter.widget") {
//
//            // 프로필을 보여주는 뷰 수정
//            profileView1.layer.borderColor = UIColor.white.cgColor
//            profileView1.layer.borderWidth = 3.0
//            profileView1.backgroundColor = .clear
//            profileView1.clipsToBounds = true
//            profileView1.layer.cornerRadius = 25
//
//            profileView2.layer.borderColor = UIColor.white.cgColor
//            profileView2.layer.borderWidth = 3.0
//            profileView2.backgroundColor = .clear
//            profileView2.clipsToBounds = true
//            profileView2.layer.cornerRadius = 25
//
//            // 프로필 1번
//            let imageURL1 = fileURL.appendingPathComponent("profileImg1.png")
//            if let image1 = UIImage(contentsOfFile: imageURL1.path){
//                profile1.image = nil
//                profile1.image = image1
//            }
//
//            // 프로필 2번
//            let imageURL2 = fileURL.appendingPathComponent("profileImg2.png")
//            if let image2 = UIImage(contentsOfFile: imageURL2.path){
//                profile2.image = nil
//                profile2.image = image2
//            }
//        }
        
        
        completionHandler(NCUpdateResult.newData)
    }
}
