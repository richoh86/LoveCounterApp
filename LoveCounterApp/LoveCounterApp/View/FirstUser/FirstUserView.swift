//
//  firstUserView.swift
//  LoveCounterApp
//
//  Created by richard oh on 08/03/2019.
//  Copyright © 2019 richard oh. All rights reserved.
//

import UIKit
import SnapKit


// textView 모두 UILabel로 변경할 것
class FirstUserView: UIView {
    
    let imageView = UIImageView()
    let titleOnTop = UITextView()
    
    let shapeLayer = CAShapeLayer()
    let textLb = UILabel()
    
    let dateBoxView = UIView()
    let dateSelectButton = UIButton()
    let dateImageView = UIImageView()
    let dateTextLb = UILabel()
    
    let nextButton = UIButton()
    
    let dateSpinnerUIbox = UIView()
    let dateText = UILabel()
    let cancelBtn = UIButton()
    let dateSpinner = UIDatePicker()
    
    let completeBtnContainer = UIView()
    let completeBtn = UIButton()
    let btnNameLb = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        
        createTopTitleView()
        createTextInShapeLayer()
        createButton()
        createDateBtnBox()
        
        updateAutoLayout()
        
    }
    
    func createTopTitleView(){
        
        titleOnTop.textAlignment = .center
//        titleOnTop.text = "연인이 된 날을 입력해주세요!"
        titleOnTop.text = "choose date\nthat became a couple!"
        titleOnTop.textColor = UIColor.white
        titleOnTop.backgroundColor = .none
        titleOnTop.font = UIFont.systemFont(ofSize: 20)
        titleOnTop.isEditable = false
        addSubview(titleOnTop)
        
        imageView.frame = CGRect(x: 10 , y: 10, width: 20, height: 20)
        imageView.image = UIImage(named: "icons8-love-filled-100")
        titleOnTop.addSubview(imageView)
        imageView.isHidden = true
        
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
        
//        textLb.text = "1일"
        textLb.text = "1 D"
        textLb.textColor = UIColor.white
        textLb.textAlignment = .center
        textLb.font = UIFont.boldSystemFont(ofSize: 50)
        
        addSubview(textLb)
    }
    
    func createDateBtnBox(){
        
        dateBoxView.backgroundColor = .none
        dateBoxView.layer.cornerRadius = 5.0
        dateBoxView.layer.borderColor = UIColor.white.cgColor
        dateBoxView.layer.borderWidth = 2
    
        dateSelectButton.backgroundColor = .none

        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let currentDate = formatter.string(from: date)
        
        dateTextLb.textColor = .white
        dateTextLb.text = currentDate
        dateTextLb.textAlignment = .justified
        dateTextLb.font = UIFont.systemFont(ofSize: 30)
        
        dateImageView.image = UIImage(named: "icons8-expand-arrow-filled-100")
        
        dateBoxView.addSubview(dateTextLb)
        dateBoxView.addSubview(dateImageView)
        
        // UIView 위에 textView와 dateImageView를 올리고 해당 UIView에 다시 dateSelectButton을 올린다
        addSubview(dateBoxView)
        dateBoxView.addSubview(dateSelectButton)
        
    }
    
    func createButton(){
        
//        nextButton.setTitle("다음", for: .normal)
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(UIColor.white, for: .normal)
        nextButton.backgroundColor = #colorLiteral(red: 0.9943013787, green: 0.4424599409, blue: 0.4413398504, alpha: 1)
        nextButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        
        addSubview(nextButton)
    }
    
    func showDateSpinnerUIBox() {
        
        dateSpinnerUIbox.frame = CGRect(x: 0, y: self.bounds.height, width: self.bounds.width, height: 320 ) //  self.bounds.height*(3/5)
        dateSpinnerUIbox.backgroundColor = .white
        
        addSubview(dateSpinnerUIbox)
  
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let currentDate = formatter.string(from: date)
        
        dateText.text = currentDate
        dateText.textColor = .black
        dateText.font = UIFont.systemFont(ofSize: 25)
        
        dateSpinnerUIbox.addSubview(dateText)
        
        dateText.snp.makeConstraints { make in
            make.top.equalTo(dateSpinnerUIbox).inset(10)
            make.centerX.equalTo(dateSpinnerUIbox)
            make.height.equalTo(45)
        }
        
//        cancelBtn.setTitle("취소", for: .normal)
        cancelBtn.setTitle("Cancel", for: .normal)
        cancelBtn.setTitleColor(#colorLiteral(red: 0.9943013787, green: 0.4424599409, blue: 0.4413398504, alpha: 1), for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 19)
        
        dateSpinnerUIbox.addSubview(cancelBtn)
        
        cancelBtn.snp.makeConstraints { make in
            make.centerY.equalTo(dateText.snp.centerY)
            make.right.equalTo(dateSpinnerUIbox).inset(15)
        }
        
//        let locale = Locale(identifier: "ko_KR")
        let locale = Locale(identifier: "en_US")
        dateSpinner.datePickerMode = .date
        dateSpinner.locale = locale
        
        dateSpinnerUIbox.addSubview(dateSpinner)
        
        dateSpinner.snp.makeConstraints { make in
            make.top.equalTo(dateText.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(200)
        }

        completeBtn.setTitleColor(#colorLiteral(red: 0.9943013787, green: 0.4424599409, blue: 0.4413398504, alpha: 1), for: UIControl.State.normal)
//        completeBtn.setTitle("완료", for: .normal)
        completeBtn.setTitle("Complete", for: .normal)
        completeBtn.titleLabel?.textAlignment = .center
        completeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
        dateSpinnerUIbox.addSubview(completeBtn)
        
        completeBtn.snp.makeConstraints { make in
            make.top.equalTo(dateSpinner.snp.bottom)
            make.left.equalTo(dateSpinnerUIbox.snp.left)
            make.right.equalTo(dateSpinnerUIbox.snp.right)
//            make.height.equalTo(75)
            make.height.greaterThanOrEqualTo(55)
//            make.bottom.equalTo(dateSpinnerUIbox.snp.bottom)
//            make.bottom.greaterThanOrEqualToSuperview()
//            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func updateAutoLayout(){
        
        titleOnTop.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
//            make.topMargin.equalTo(130)
            make.top.equalTo(self.snp.top).offset(80)
        }
        
        textLb.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(100)
            make.height.equalTo(87)
            make.centerX.equalToSuperview()
//            make.top.equalTo(titleOnTop).offset(135)
            make.centerY.equalToSuperview().offset(-70)
        }
        
        dateBoxView.snp.makeConstraints { make in
            make.width.equalTo(220)
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
            make.top.equalTo(textLb).offset(250)
        }
        
        dateTextLb.snp.makeConstraints { make in
            make.edges.left.equalTo(dateBoxView).inset(15)
            make.edges.top.equalTo(dateBoxView).inset(15)
            make.edges.bottom.equalTo(dateBoxView).inset(15)
        }
        
        dateImageView.snp.makeConstraints { make in
            make.width.equalTo(25)
            make.height.equalTo(20)
            make.left.equalTo(dateTextLb.snp.right).inset(25)
            make.right.equalTo(dateBoxView).inset(15)
            make.centerY.equalTo(dateBoxView)
        }
        
        dateSelectButton.snp.makeConstraints { make in
            make.width.equalTo(220)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(textLb).offset(250)
        }
        
        // iphone7 기기에서 아래 버튼 영역이 다 보이지 않는 현상... 수정 필요
        nextButton.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(95)
            make.bottom.equalToSuperview()
        }
    }
}
