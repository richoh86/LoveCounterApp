//
//  MainView.swift
//  LoveCounterApp
//
//  Created by richard oh on 13/03/2019.
//  Copyright © 2019 richard oh. All rights reserved.
//

import Foundation
import SnapKit

class MainView: UIView {
    
    let imgSetting = UIImageView()
    let settingBtn = UIButton()
    
    let topTitle = UILabel()
    
    let shapeLayer = CAShapeLayer()
    let textLb = UILabel()
    
    let heart = UIImageView()
    
    let circleForPic1 = UIImageView()
    let circleForPic2 = UIImageView()
    let cameraImg1 = UIImageView()
    let cameraImg2 = UIImageView()
    
    let name1 = UILabel()
    let name2 = UILabel()
    
    let arrowImg = UIImageView()
    let arrowBtn = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(){
        createSettingBtn()
        
        // 임시주석처리: 오류나는부분
        createTopTitle()
        createTextInShapeLayer()
        
        createHeartImg()
        createProfilePlaceHolder()
    
        createNameLb()
        
        createArrowAndButton()

        updateAutoLayout()
    }

    func createSettingBtn(){

        imgSetting.image = UIImage(named: "icons8-settings-filled-100")
        addSubview(imgSetting)
        addSubview(settingBtn)
    }
    
    func createTopTitle(){
        
        if let selectedDate = UserDefaults.standard.value(forKey: "selDate") as? Date {
            // Date 포맷은 yyyy.MM.dd
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "yyyy년 MM월 dd일"
            // 선택된 시간 String 값을 변환
            let strSelectedDate = dateFormatter1.string(from: selectedDate)
            
            topTitle.text = "\(strSelectedDate)!\n우리의 사랑은 시작되었다."
            topTitle.numberOfLines = 2
            topTitle.textColor = UIColor.white
            topTitle.textAlignment = .justified
            topTitle.font = UIFont.boldSystemFont(ofSize: 25)
            
            addSubview(topTitle)
            
            topTitle.layer.shadowColor = UIColor.black.cgColor
            topTitle.layer.shadowRadius = 1.0
            topTitle.layer.shadowOpacity = 0.5
            topTitle.layer.shadowOffset = CGSize(width: 2, height: 2)
            topTitle.layer.masksToBounds = false
        }
        
    }
    
    func createShapeLayer() -> CAShapeLayer{
        
        let circlarPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        shapeLayer.path = circlarPath.cgPath
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = .none
        shapeLayer.position = CGPoint(x: self.bounds.width/2, y: 350)
        
        return shapeLayer
    }
    
    func createTextInShapeLayer(){
        
        textLb.text = "1일"
        textLb.textColor = UIColor.white
        textLb.textAlignment = .center
        textLb.font = UIFont.boldSystemFont(ofSize: 50)
        
        addSubview(textLb)
        
        textLb.layer.shadowColor = UIColor.black.cgColor
        textLb.layer.shadowRadius = 1.0
        textLb.layer.shadowOpacity = 0.5
        textLb.layer.shadowOffset = CGSize(width: 2, height: 2)
        textLb.layer.masksToBounds = false
    }
    
    func createHeartImg(){
        
        heart.image = UIImage(named: "icons8-love-filled-main")
        addSubview(heart)
        
    }
    
    func createProfilePlaceHolder(){
        
        circleForPic1.image = UIImage(named: "Oval")
        circleForPic2.image = UIImage(named: "Oval")
        cameraImg1.image = UIImage(named: "icons8-compact-camera-100")
        cameraImg2.image = UIImage(named: "icons8-compact-camera-100")
        
        addSubview(circleForPic1)
        addSubview(circleForPic2)
        circleForPic1.addSubview(cameraImg1)
        circleForPic2.addSubview(cameraImg2)
        
    }
    
    func createNameLb() {
        
        name1.text = "이름"
        name1.textAlignment = .center
        name1.textColor = .white
        name1.font = UIFont.systemFont(ofSize: 20)
        
        name2.text = "이름"
        name2.textAlignment = .center
        name2.textColor = .white
        name2.font = UIFont.systemFont(ofSize: 20)
        
        addSubview(name1)
        addSubview(name2)
    }
    
    func createArrowAndButton() {
        
        arrowImg.image = UIImage(named: "icons8-collapse-arrow-filled-100")
        addSubview(arrowImg)
        addSubview(arrowBtn)
        
    }
    
    private func updateAutoLayout(){
    
        imgSetting.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.right.equalToSuperview().inset(15)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }

        settingBtn.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(imgSetting)
        }

        // 임시주석처리: 오류나는부분
        topTitle.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(100)
            make.height.greaterThanOrEqualTo(100)
            make.top.equalTo(imgSetting.snp.bottom).offset(15)
            make.left.equalTo(self.snp.left).offset(20)
        }
        
        textLb.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(100)
            make.height.equalTo(87)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-70)
        }
        
        heart.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(45)
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).offset(170)
        }
        
        circleForPic1.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.centerY.equalTo(heart)
            make.centerX.equalTo(heart).offset(-100)
        }
        
        cameraImg1.snp.makeConstraints { make in
            make.edges.top.bottom.equalTo(circleForPic1).inset(23)
            make.edges.left.right.equalTo(circleForPic1).inset(25)
        }
        
        circleForPic2.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.centerY.equalTo(heart)
            make.centerX.equalTo(heart).offset(100)
        }
        
        cameraImg2.snp.makeConstraints { make in
            make.edges.top.bottom.equalTo(circleForPic2).inset(23)
            make.edges.left.right.equalTo(circleForPic2).inset(25)
        }
        
        name1.snp.makeConstraints { make in
            make.centerX.equalTo(circleForPic1)
            make.top.equalTo(circleForPic1.snp.bottom).offset(10)
        }
        
        name2.snp.makeConstraints { make in
            make.centerX.equalTo(circleForPic2)
            make.top.equalTo(circleForPic2.snp.bottom).offset(10)
        }
        
        arrowImg.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(30)
            make.centerX.equalTo(heart.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).offset(-50)
        }
        
        arrowBtn.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(arrowImg)
        }
    }
}
