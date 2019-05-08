//
//  CalendarView.swift
//  LoveCounterApp
//
//  Created by richard oh on 15/03/2019.
//  Copyright © 2019 richard oh. All rights reserved.
//

import UIKit
import SnapKit

class CalendarView: UIView {

    var topTitleContainerView = UIStackView()
    let calendarImgView = UIImageView()
    let titleLb = UILabel()
    
    let stackViewForTabs: UIStackView = {
       let container = UIStackView()
        container.axis = .horizontal
        container.distribution = .fillEqually
       return container
    }()
    
    let tab1 = UIView()
    
    let textForTab1: UILabel = {
        let tab1 = UILabel()
//        tab1.text = "커플"
        tab1.text = "Couple"
        tab1.font = UIFont.systemFont(ofSize: 17)
        tab1.textColor = .white
        tab1.textAlignment = .center
        return tab1
    }()

    let tab2 = UIView()
    
    let textForTab2: UILabel = {
        let tab2 = UILabel()
//        tab2.text = "생일 + 기념일"
        tab2.text = "B.Day & Anniversary"
        tab2.font = UIFont.systemFont(ofSize: 17)
        tab2.textColor = .white
        tab2.textAlignment = .center
        return tab2
    }()
    
    let bottomLineView1: UIView = {
        let line = UIView()
        line.backgroundColor = #colorLiteral(red: 0.9943013787, green: 0.4424599409, blue: 0.4413398504, alpha: 1)
        return line
    }()
    
    let bottomLineView2: UIView = {
        let line = UIView()
        line.backgroundColor = #colorLiteral(red: 0.9943013787, green: 0.4424599409, blue: 0.4413398504, alpha: 1)
        return line
    }()
    
    let btnForTab1: UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    let btnForTab2: UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    let arrowDown = UIImageView()
    let btnForArrowDown = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func commonInit(){
        createTopTitle()
        createTabs()
        createArrowDownBtn()
        updateAutoLayout()
    }
    
    func createTopTitle() {
    
        calendarImgView.image = #imageLiteral(resourceName: "icons8-planner-filled-100")
        titleLb.text = "LOVE CALENDAR"
        titleLb.textColor = .white
        titleLb.textAlignment = .center
        titleLb.font = UIFont.boldSystemFont(ofSize: 17)
        
//        calendarImgView.frame.size = CGSize(width: 20, height: 20)
//        titleLb.frame.size = CGSize(width: 100, height: 20)
        
        topTitleContainerView = UIStackView(arrangedSubviews: [calendarImgView, titleLb])
        topTitleContainerView.axis = .horizontal
        topTitleContainerView.distribution = .fillProportionally
//        topTitleContainerView.spacing = 3.0
        
        addSubview(topTitleContainerView)
    }
    
    func createTabs() {
        
        tab1.addSubview(textForTab1)
        tab1.addSubview(bottomLineView1)
        tab1.addSubview(btnForTab1)
        
        tab2.addSubview(textForTab2)
        tab2.addSubview(bottomLineView2)
        tab2.addSubview(btnForTab2)
        
        stackViewForTabs.addArrangedSubview(tab1)
        stackViewForTabs.addArrangedSubview(tab2)
        addSubview(stackViewForTabs)
        
    }
   
    func createArrowDownBtn(){
        arrowDown.image = UIImage(named: "icons8-expand-arrow-filled-100")
        addSubview(arrowDown)
        addSubview(btnForArrowDown)
    }
    
    func updateAutoLayout(){
        
        topTitleContainerView.snp.makeConstraints { make in
            make.width.equalTo(170)
            make.height.equalTo(20)
            make.top.equalTo(self.snp.top).offset(50)
            make.centerX.equalToSuperview()
        }
        
        stackViewForTabs.snp.makeConstraints { make in
            
            make.width.equalToSuperview()
            make.height.equalTo(70)
            make.top.equalTo(topTitleContainerView.snp.bottom)
            
        }
        
        textForTab1.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        textForTab2.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        bottomLineView1.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        bottomLineView2.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        btnForTab1.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        btnForTab2.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        arrowDown.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(20)
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).offset(-50)
        }
        
        btnForArrowDown.snp.makeConstraints { make in
            make.center.equalTo(arrowDown)
            make.width.equalTo(100)
            make.height.equalTo(70)
        }
    }
}
