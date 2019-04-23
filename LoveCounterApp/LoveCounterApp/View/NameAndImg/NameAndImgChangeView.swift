//
//  NameAndImgChangeView.swift
//  LoveCounterApp
//
//  Created by richard oh on 18/03/2019.
//  Copyright © 2019 richard oh. All rights reserved.
//

import UIKit
import SnapKit
import DeviceKit

class NameAndImgChangeView: UIView {
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillEqually
        view.axis = .vertical
        return view
    }()
    
    let view1: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let textLb1: UILabel = {
        let text = UILabel()
        text.text = "이름 변경"
        text.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        text.textAlignment = .center
        return text
    }()
    
    let view2: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let textLb2: UILabel = {
        let text = UILabel()
        text.text = "프로필사진 변경"
        text.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        text.textAlignment = .center
        return text
    }()
    
    let view3: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let textLb3: UILabel = {
        let text = UILabel()
        text.text = "돌아가기"
        text.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        text.textAlignment = .center
        return text
    }()
    
    let option1: UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    let option2: UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    let option3: UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit(){
        createDialogBox()
        updateAutoLayout()
    }
    
    private func createDialogBox(){
        
        view1.addSubview(textLb1)
        view2.addSubview(textLb2)
        view3.addSubview(textLb3)
        
        view1.addSubview(option1)
        view2.addSubview(option2)
        view3.addSubview(option3)
        
        stackView.addArrangedSubview(view1)
        stackView.addArrangedSubview(view2)
        stackView.addArrangedSubview(view3)
        
        containerView.addSubview(stackView)
        addSubview(containerView)
    }
    
    private func updateAutoLayout() {
        
        let device = UIDevice.current
        
        // 이름, 이미지 변경 UI 박스 깨지는 기기들만 수정 분기
        // 가로 세로 길이를 정해주고 뷰 컨트롤러 가운데 위치하도록 수정
        if device.name == "iPhone 6"
            || device.name == "iPhone 6s" || device.name == "iPhone 6 Plus"
            || device.name == "iPhone 6s Plus" || device.name == "iPhone 7" || device.name == "iPhone 7" || device.name == "iPhone 7 Plus" || device.name == "iPhone 8" || device.name == "iPhone 8 Plus" || device.name == "iPhone SE" {
            
            containerView.snp.makeConstraints { (make) in
                
                make.width.equalTo(220)
                make.height.equalTo(240)
                make.center.equalToSuperview()
            }
            
        }else{
            
            containerView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        textLb1.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        textLb2.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        textLb3.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        option1.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        option2.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        option3.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
