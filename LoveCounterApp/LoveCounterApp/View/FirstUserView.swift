//
//  firstUserView.swift
//  LoveCounterApp
//
//  Created by richard oh on 08/03/2019.
//  Copyright © 2019 richard oh. All rights reserved.
//

import UIKit
import SnapKit

class FirstUserView: UIView {
    
    let imageView = UIImageView()
    let titleOnTop = UITextView()
    
    let shapeLayer = CAShapeLayer()
    let textView = UITextView()
    
    let dateSelectButton = UIButton()
    let dateImageView = UIImageView()
    let dateTextView = UITextView()
    
    let nextButton = UIButton()
    
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
        createTextInShapeLayer(text: "1일")
        createButton()
        createDateBtnBox()
        updateAutoLayout()
        
    }
    
    func createTopTitleView(){
        
        titleOnTop.textAlignment = .center
        titleOnTop.text = "연인이 된 날을 입력해주세요!"
        titleOnTop.textColor = UIColor.white
        titleOnTop.backgroundColor = .none
        titleOnTop.font = UIFont.systemFont(ofSize: 20)
        titleOnTop.isEditable = false
        addSubview(titleOnTop)
        
        imageView.frame = CGRect(x: 10 , y: 10, width: 20, height: 20)
        imageView.image = UIImage(named: "icons8-love-filled-100")
        titleOnTop.addSubview(imageView)
        
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
    
    func createTextInShapeLayer(text: String){
        
        textView.text = text
        textView.textColor = UIColor.white
        textView.textAlignment = .center
        textView.backgroundColor = .none
        textView.font = UIFont.boldSystemFont(ofSize: 50)
        textView.isEditable = false
        
        addSubview(textView)
    }
    
    func createDateBtnBox(){
        
        dateSelectButton.backgroundColor = .none
        
        dateSelectButton.layer.cornerRadius = 5.0
        dateSelectButton.layer.borderColor = UIColor.white.cgColor
        dateSelectButton.layer.borderWidth = 2
        
        dateTextView.frame = CGRect(x: 0, y: 0, width: 180, height: 50)
        dateTextView.textColor = .white
        dateTextView.text = "2019.03.12"
        dateTextView.textAlignment = .center
        dateTextView.backgroundColor = .none
        dateTextView.font = UIFont.systemFont(ofSize: 30)
        
        dateImageView.frame = CGRect(x: 182, y: 16, width: 25, height: 20)
        dateImageView.image = UIImage(named: "icons8-expand-arrow-filled-100")
        
        dateSelectButton.addSubview(dateTextView)
        dateSelectButton.addSubview(dateImageView)
        addSubview(dateSelectButton)
        
    }
    
    func createButton(){
        
        nextButton.setTitle("다음", for: .normal)
        nextButton.setTitleColor(UIColor.white, for: .normal)
        nextButton.backgroundColor = #colorLiteral(red: 0.9943013787, green: 0.4424599409, blue: 0.4413398504, alpha: 1)
        nextButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        
        addSubview(nextButton)
 
    }
    
    private func updateAutoLayout(){
        
        titleOnTop.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(130)
        }
        
        textView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(87)
            make.centerX.equalToSuperview()
            make.top.equalTo(titleOnTop).offset(140)
        }
        
        dateSelectButton.snp.makeConstraints { make in
            make.width.equalTo(220)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(textView).offset(300)
        }
        
        nextButton.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(95)
            make.bottom.equalToSuperview()
        }
        
    }
}
