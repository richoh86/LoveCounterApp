//
//  NameAndImgChangeView.swift
//  LoveCounterApp
//
//  Created by richard oh on 18/03/2019.
//  Copyright © 2019 richard oh. All rights reserved.
//

import UIKit
import SnapKit

class NameAndImgChangeView: UIView {
    
    let containerView: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
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
//        addSubview(stackView)
    }
    
    private func updateAutoLayout() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
