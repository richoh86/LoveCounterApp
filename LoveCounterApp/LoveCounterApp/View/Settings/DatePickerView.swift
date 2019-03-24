//
//  datePickerView.swift
//  LoveCounterApp
//
//  Created by richard oh on 22/03/2019.
//  Copyright © 2019 richard oh. All rights reserved.
//

import UIKit
import SnapKit

class DatePickerView: UIView {

    let viewBox: UIView = {
        let box = UIView()
        box.backgroundColor = .white
        box.layer.cornerRadius = 15
        box.clipsToBounds = true
        return box
    }()
    
    let datePickerView = UIDatePicker()
    
    let completeBtn: UIButton = {
       let btn = UIButton()
       btn.setTitle("완료", for: .normal)
       btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
       btn.backgroundColor = #colorLiteral(red: 0.9943013787, green: 0.4424599409, blue: 0.4413398504, alpha: 1)
       return btn
    }()
    
    var btnTag: Int?

    convenience init(btnTag: Int){
        self.init()
        self.btnTag = btnTag
        commonInit()
    }
    
    private func commonInit(){
        createUI()
        updateAutoLayout()
    }
    
    private func createUI(){
        
        // 1. date picker view 한국 날짜 타입으로 변경
        let locale = Locale(identifier: "ko_KR")
        datePickerView.datePickerMode = .date
        datePickerView.locale = locale
        
        viewBox.addSubview(datePickerView)
        
        // 2. 버튼 뷰 생성
        viewBox.addSubview(completeBtn)
        
        // 3. dialog box 생성
        addSubview(viewBox)
    }
    
    private func updateAutoLayout(){
        
        viewBox.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.width.equalTo(300)
            make.center.equalToSuperview()
        }
        
        datePickerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(150)
            make.width.equalToSuperview()
        }
        
        completeBtn.snp.makeConstraints { make in
            make.top.equalTo(datePickerView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
}
