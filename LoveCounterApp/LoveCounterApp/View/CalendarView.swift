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
   
    func createArrowDownBtn(){
        arrowDown.image = UIImage(named: "icons8-expand-arrow-filled-100")
        addSubview(arrowDown)
        addSubview(btnForArrowDown)
    }
    
    func updateAutoLayout(){
        
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
        
        topTitleContainerView.snp.makeConstraints { make in
            make.width.equalTo(170)
            make.height.equalTo(20)
            make.top.equalTo(self.snp.top).offset(50)
            make.centerX.equalToSuperview()
        }
        
    }
}
