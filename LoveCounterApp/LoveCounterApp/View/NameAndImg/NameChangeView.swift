//
//  NameChangeView.swift
//  LoveCounterApp
//
//  Created by richard oh on 18/03/2019.
//  Copyright © 2019 richard oh. All rights reserved.
//

import Foundation
import SnapKit

class NameChangeView: UIView {
    
    let textLabel: UILabel = {
        let textLb = UILabel()
        textLb.text = "이름을 입력해주세요!"
        textLb.textColor = .white
        textLb.textAlignment = .center
        textLb.font = UIFont.systemFont(ofSize: 20)
        return textLb
    }()
    
    let textFieldForName: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.textColor = .black
        tf.textAlignment = .center
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.layer.cornerRadius = 10
        return tf
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        autoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        addSubviews()
    }
    
    private func addSubviews(){
        addSubview(textLabel)
        addSubview(textFieldForName)
    }
    
    private func autoLayout() {
        
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.centerX.equalToSuperview()
            make.width.greaterThanOrEqualTo(200)
            make.height.equalTo(60)
        }
        
        textFieldForName.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(320)
            make.height.equalTo(70)
        }
        
    }
    
    
}
