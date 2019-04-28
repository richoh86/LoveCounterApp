//
//  MainView.swift
//  LoveCounterApp
//
//  Created by richard oh on 13/03/2019.
//  Copyright © 2019 richard oh. All rights reserved.
//

import Foundation
import SnapKit
import DeviceKit

class MainView: UIView {
    
    let imgSetting = UIImageView()
    let settingBtn = UIButton()
    
    let topTitle = UILabel()
    
    let shapeLayer = CAShapeLayer()
    let textLb = UILabel()
    
    let heart = UIImageView()
    
    let circleViewForPic1: UIImageView = {
        let view = UIImageView()
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 3.0
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.layer.cornerRadius = 50
        view.image = nil
        return view
    }()
    
    let circleViewForPic2: UIImageView = {
        let view = UIImageView()
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 3.0
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.layer.cornerRadius = 50
        view.image = nil
        return view
    }()
    
    let cameraImg1 = UIImageView()
    let cameraImg2 = UIImageView()
    
    let name1 = UILabel()
    let name2 = UILabel()
    
    let btnForChangeNameImg1: UIButton = {
       let btn = UIButton()
        btn.tag = 1
       return btn
    }()
    
    let btnForChangeNameImg2: UIButton = {
        let btn = UIButton()
        btn.tag = 2
        return btn
    }()
    
    let arrowImg = UIImageView()
    let arrowBtn = UIButton()
    
    let device = UIDevice.current
    
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
        
        topTitle.numberOfLines = 2
        topTitle.textColor = UIColor.white
        topTitle.textAlignment = .justified

        if device.name == "iPhone 5s"{
            topTitle.font = UIFont.boldSystemFont(ofSize: 20)
        }else{
            topTitle.font = UIFont.boldSystemFont(ofSize: 25)
        }
        
        topTitle.layer.shadowColor = UIColor.black.cgColor
        topTitle.layer.shadowRadius = 1.0
        topTitle.layer.shadowOpacity = 0.5
        topTitle.layer.shadowOffset = CGSize(width: 2, height: 2)
        topTitle.layer.masksToBounds = false
        
        if let selectedDate = UserDefaults.standard.value(forKey: "selDate") as? Date {
            // Date 포맷은 yyyy.MM.dd
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "yyyy년 MM월 dd일"
            // 선택된 시간 String 값을 변환
            let strSelectedDate = dateFormatter1.string(from: selectedDate)
            topTitle.text = "\(strSelectedDate)!\n우리의 사랑은 시작되었다."
        }else{
            topTitle.numberOfLines = 1
            topTitle.text = "사랑은 위대한 것"
        }
        
        addSubview(topTitle)
    }
    
    func createShapeLayer() -> CAShapeLayer{
        
        let circlarPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        shapeLayer.path = circlarPath.cgPath
        shapeLayer.strokeColor = UIColor.white.cgColor
//        shapeLayer.strokeColor = #colorLiteral(red: 0.9943013787, green: 0.4424599409, blue: 0.4413398504, alpha: 1)
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = .none
        shapeLayer.position = CGPoint(x: self.bounds.width/2, y: 350)
        
        return shapeLayer
    }
    
    func createTextInShapeLayer(){
        
        textLb.text = "1일"
        textLb.textColor = UIColor.white
        textLb.textAlignment = .center
        textLb.font = UIFont.boldSystemFont(ofSize: 45)
        
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
    
        cameraImg1.image = UIImage(named: "icons8-compact-camera-100")
        cameraImg2.image = UIImage(named: "icons8-compact-camera-100")

        addSubview(cameraImg1)
        addSubview(cameraImg2)
        
        addSubview(circleViewForPic1)
        addSubview(circleViewForPic2)
        
        addSubview(btnForChangeNameImg1)
        addSubview(btnForChangeNameImg2)
        
    }
    
    func createNameLb() {
        
        if let name1  = UserDefaults.standard.value(forKey: "name1") as? String{
            self.name1.text = name1
        }else{
            name1.text = "본인이름"
        }
        name1.textAlignment = .center
        name1.textColor = .white
        name1.font = UIFont.systemFont(ofSize: 20)
        
        if let name2  = UserDefaults.standard.value(forKey: "name2") as? String{
            self.name2.text = name2
        }else{
            name2.text = "내꺼이름"
        }
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
            make.right.equalToSuperview().inset(10)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        settingBtn.snp.makeConstraints { make in
            make.center.equalTo(imgSetting)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        // 임시주석처리: 오류나는부분
//        topTitle.snp.makeConstraints { make in
//            make.width.greaterThanOrEqualTo(100)
//            make.height.greaterThanOrEqualTo(100)
//            make.top.equalTo(imgSetting.snp.bottom).offset(15)
//            make.bottom.equalTo(textLb).offset(150)
//        }
        
        if device.name == "iPhone 6"
            || device.name == "iPhone 6s" || device.name == "iPhone 6 Plus"
            || device.name == "iPhone 6s Plus" || device.name == "iPhone 7" || device.name == "iPhone 7" || device.name == "iPhone 7 Plus" || device.name == "iPhone 8" || device.name == "iPhone 8 Plus" {
        
            topTitle.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(50)
                make.left.equalToSuperview().offset(20)
                make.width.greaterThanOrEqualTo(100)
                make.height.greaterThanOrEqualTo(100)
            }
            
        }else if device.name == "iPhone 5s" || device.name == "iPhone SE"{
                
            topTitle.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(25)
                make.left.equalToSuperview().offset(20)
                make.width.greaterThanOrEqualTo(100)
                make.height.greaterThanOrEqualTo(100)
            }
            
        }else{
            topTitle.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(80)
                make.left.equalToSuperview().offset(20)
                make.width.greaterThanOrEqualTo(100)
                make.height.greaterThanOrEqualTo(100)
            }
        }
        
        textLb.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(100)
            make.height.equalTo(87)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-70)
        }
        
        heart.snp.makeConstraints { make in
            make.width.equalTo(45)
            make.height.equalTo(40)
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).offset(170)
        }
        
        circleViewForPic1.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.centerY.equalTo(heart)
            make.centerX.equalTo(heart).offset(-100)
        }
        
        circleViewForPic2.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.centerY.equalTo(heart)
            make.centerX.equalTo(heart).offset(100)
        }
        
        cameraImg1.snp.makeConstraints { make in
            make.width.equalTo(55)
            make.height.equalTo(40)
            make.center.equalTo(circleViewForPic1.snp.center)
        }
        
        cameraImg2.snp.makeConstraints { make in
            make.width.equalTo(55)
            make.height.equalTo(40)
            make.center.equalTo(circleViewForPic2.snp.center)
        }
        
        name1.snp.makeConstraints { make in
            make.centerX.equalTo(circleViewForPic1)
            make.top.equalTo(circleViewForPic1.snp.bottom).offset(10)
        }
        
        name2.snp.makeConstraints { make in
            make.centerX.equalTo(circleViewForPic2)
            make.top.equalTo(circleViewForPic2.snp.bottom).offset(10)
        }
        
        btnForChangeNameImg1.snp.makeConstraints { make in
            
            make.width.equalTo(130)
            make.height.equalTo(150)
            make.center.equalTo(circleViewForPic1.snp.center)
            
        }
        
        btnForChangeNameImg2.snp.makeConstraints { make in
            
            make.width.equalTo(130)
            make.height.equalTo(150)
            make.center.equalTo(circleViewForPic2.snp.center)
            
        }
        
        arrowImg.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(20)
            make.centerX.equalTo(heart.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).offset(-50)
        }
        
        arrowBtn.snp.makeConstraints { make in
            make.center.equalTo(arrowImg)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
    }
}
