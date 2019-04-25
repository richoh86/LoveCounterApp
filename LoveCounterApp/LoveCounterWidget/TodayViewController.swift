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
    @IBOutlet weak var profile1: UIImageView!
    @IBOutlet weak var profile2: UIImageView!
    
    @IBOutlet weak var profileView1: UIView!
    @IBOutlet weak var profileView2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("viewDidLoad")
       
        
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
        
        // 프로필 이미지 보여주기
        if let fileURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.LoveCounter.widget") {
            
            // 프로필을 보여주는 뷰 수정
            profileView1.layer.borderColor = UIColor.white.cgColor
            profileView1.layer.borderWidth = 3.0
            profileView1.backgroundColor = .clear
            profileView1.clipsToBounds = true
            profileView1.layer.cornerRadius = 25
            
            profileView2.layer.borderColor = UIColor.white.cgColor
            profileView2.layer.borderWidth = 3.0
            profileView2.backgroundColor = .clear
            profileView2.clipsToBounds = true
            profileView2.layer.cornerRadius = 25
            
            // 프로필 1번
            let imageURL1 = fileURL.appendingPathComponent("profileImg1.png")
            if let image1 = UIImage(contentsOfFile: imageURL1.path){
                profile1.image = nil
                profile1.image = image1
            }
            
            // 프로필 2번
            let imageURL2 = fileURL.appendingPathComponent("profileImg2.png")
            if let image2 = UIImage(contentsOfFile: imageURL2.path){
                profile2.image = nil
                profile2.image = image2
            }
        }
        
        
        completionHandler(NCUpdateResult.newData)
    }
}
