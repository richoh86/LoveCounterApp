//
//  SettingView.swift
//  LoveCounterApp
//
//  Created by richard oh on 21/03/2019.
//  Copyright © 2019 richard oh. All rights reserved.
//

import UIKit

class SettingView: UIView {

    var topTitleContainerView: UIStackView = {
        let topTitleContainerView = UIStackView()
        topTitleContainerView.axis = .horizontal
        topTitleContainerView.distribution = .fillProportionally
        return topTitleContainerView
    }()
    
    let settingImgView: UIImageView = {
        let settingImgView = UIImageView()
        settingImgView.image = #imageLiteral(resourceName: "icons8-settings-filled-100")
        return settingImgView
    }()
    
    let titleLb: UILabel = {
        let titleLb = UILabel()
        titleLb.text = "SETTINGS"
        titleLb.textColor = .white
        titleLb.textAlignment = .right
        titleLb.font = UIFont.boldSystemFont(ofSize: 19)
        return titleLb
    }()
    
    let exitBtnImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "icons8-cancel-100")
        return img
    }()
    
    let exitBtn: UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    // MARK: - section 3개를 담을 수 있는 stackView
    let stackViewForAllSection: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillProportionally
        return view
    }()
    
    // MARK: - 기본 설정 뷰
    let section1StackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        return view
    }()
    
    let sectionTitleView: UIView = {
       let view = UIView()
       return view
    }()
    
    let section1Title: UILabel = {
        let title = UILabel()
        title.text = "기본 설정"
        title.textColor = #colorLiteral(red: 0.9943013787, green: 0.4424599409, blue: 0.4413398504, alpha: 1)
        title.font = UIFont.boldSystemFont(ofSize: 19)
        title.textAlignment = .left
        return title
    }()
    
    let title1View: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let title1ForSection1: UILabel = {
        let text = UILabel()
        text.text = "연인이 된 날짜"
        text.textColor = .white
        text.font = UIFont.boldSystemFont(ofSize: 19)
        text.textAlignment = .left
        return text
    }()
    
    let indicatorImg1: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "icons8-forward-filled-100")
        return imgView
    }()
    
    let bottomLineView1: UIView = {
        let line = UIView()
        line.backgroundColor = .white
        return line
    }()
    
    let title2View: UIView = {
        let view = UIView()
        return view
    }()
    
    let title2ForSection1: UILabel = {
        let text = UILabel()
        text.text = "내꺼 생일"
        text.textColor = .white
        text.font = UIFont.boldSystemFont(ofSize: 19)
        text.textAlignment = .left
        return text
    }()
    
    let indicatorImg2: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "icons8-forward-filled-100")
        return imgView
    }()
    
    let bottomLineView2: UIView = {
        let line = UIView()
        line.backgroundColor = .white
        return line
    }()
    
    let title3View: UIView = {
        let view = UIView()
        return view
    }()
    
    let title3ForSection1: UILabel = {
        let text = UILabel()
        text.text = "본인 생일"
        text.textColor = .white
        text.font = UIFont.boldSystemFont(ofSize: 19)
        text.textAlignment = .left
        return text
    }()
    
    let indicatorImg3: UIImageView = {
       let imgView = UIImageView()
       imgView.image = UIImage(named: "icons8-forward-filled-100")
       return imgView
    }()
    
    let bottomLineView3: UIView = {
        let line = UIView()
        line.backgroundColor = .white
        return line
    }()
    
    
    // MARK: - 알림 설정 뷰
    let section2StackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        return view
    }()
    
    // 섹션 타이틀 뷰
    let section2TitleView: UIView = {
        let view = UIView()
        return view
    }()
    
    // 섹션 타이틀 텍스트
    let section2Title: UILabel = {
        let title = UILabel()
        title.text = "알림 설정"
        title.textColor = #colorLiteral(red: 0.9943013787, green: 0.4424599409, blue: 0.4413398504, alpha: 1)
        title.font = UIFont.boldSystemFont(ofSize: 19)
        title.textAlignment = .left
        return title
    }()
    
    // 세부항목 타이틀 뷰
    let title1ViewForSection2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let title1ForSection2: UILabel = {
        let text = UILabel()
        text.text = "푸쉬 알람"
        text.textColor = .white
        text.font = UIFont.boldSystemFont(ofSize: 19)
        text.textAlignment = .left
        return text
    }()
    
    let indicatorImg1ForSection2: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "icons8-love-filled-main")
        return imgView
    }()
    
    let bottomLineView1ForSection2: UIView = {
        let line = UIView()
        line.backgroundColor = .white
        return line
    }()
    
    let title2ViewForSection2: UIView = {
        let view = UIView()
        return view
    }()
    
    let title2ForSection2: UILabel = {
        let text = UILabel()
        text.text = "생일 및 기념일 알람"
        text.textColor = .white
        text.font = UIFont.boldSystemFont(ofSize: 19)
        text.textAlignment = .left
        return text
    }()
    
    let indicatorImg2ForSection2: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "icons8-love-filled-main")
        return imgView
    }()
    
    let bottomLineView2ForSection2: UIView = {
        let line = UIView()
        line.backgroundColor = .white
        return line
    }()
    
    // MARK: - LoveCounter 설정 뷰
    let section3StackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        return view
    }()
    
    let section3TitleView: UIView = {
        let view = UIView()
        return view
    }()
    
    let section3Title: UILabel = {
        let title = UILabel()
        title.text = "Love Counter"
        title.textColor = #colorLiteral(red: 0.9943013787, green: 0.4424599409, blue: 0.4413398504, alpha: 1)
        title.font = UIFont.boldSystemFont(ofSize: 19)
        title.textAlignment = .left
        return title
    }()
    
    let title1ViewForSection3: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let title1ForSection3: UILabel = {
        let text = UILabel()
        text.text = "문의하기"
        text.textColor = .white
        text.font = UIFont.boldSystemFont(ofSize: 19)
        text.textAlignment = .left
        return text
    }()
    
    let indicatorImg1ForSection3: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "icons8-forward-filled-100")
        return imgView
    }()
    
    let bottomLineView1ForSection3: UIView = {
        let line = UIView()
        line.backgroundColor = .white
        return line
    }()
    
    let title2ViewForSection3: UIView = {
        let view = UIView()
        return view
    }()
    
    let title2ForSection3: UILabel = {
        let text = UILabel()
        text.text = "리뷰와 별점주기"
        text.textColor = .white
        text.font = UIFont.boldSystemFont(ofSize: 19)
        text.textAlignment = .left
        return text
    }()
    
    let indicatorImg2ForSection3: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "icons8-forward-filled-100")
        return imgView
    }()
    
    let bottomLineView2ForSection3: UIView = {
        let line = UIView()
        line.backgroundColor = .white
        return line
    }()
    
    let title3ViewForSection3: UIView = {
        let view = UIView()
        return view
    }()
    
    let title3ForSection3: UILabel = {
        let text = UILabel()
        text.text = "버전 정보"
        text.textColor = .white
        text.font = UIFont.boldSystemFont(ofSize: 19)
        text.textAlignment = .left
        return text
    }()
    
    let versionLbForSection3: UILabel = {
        let version = UILabel()
        version.text = "1.0.0" // 버전 관리 plist에서 가져올 것
        version.textColor = .white
        version.font = UIFont.boldSystemFont(ofSize: 19)
        version.textAlignment = .right
        return version
    }()
    
    let bottomLineView3ForSection3: UIView = {
        let line = UIView()
        line.backgroundColor = .white
        return line
    }()
    
    // MARK: - initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI & AutoLayout
    private func commonInit(){
        createUI()
        updateAutoLayout()
    }
    
    private func createUI(){
    
        self.backgroundColor = .black
        self.alpha = 0.8
        
        // 상단 타이틀 + 우측 나가기 버튼 ----------->
        topTitleContainerView.addArrangedSubview(settingImgView)
        topTitleContainerView.addArrangedSubview(titleLb)
        
        addSubview(topTitleContainerView)
        addSubview(exitBtnImg)
        addSubview(exitBtn)
        // <------------ 상단 타이틀 + 우측 나가기 버튼
        
        // 기본 설정 ---------------------------->
        sectionTitleView.addSubview(section1Title)
        
        title1View.addSubview(title1ForSection1)
        title1View.addSubview(indicatorImg1)
        title1View.addSubview(bottomLineView1)
        
        title2View.addSubview(title2ForSection1)
        title2View.addSubview(indicatorImg2)
        title2View.addSubview(bottomLineView2)
        
        title3View.addSubview(title3ForSection1)
        title3View.addSubview(indicatorImg3)
        title3View.addSubview(bottomLineView3)
        
        section1StackView.addArrangedSubview(sectionTitleView)
        section1StackView.addArrangedSubview(title1View)
        section1StackView.addArrangedSubview(title2View)
        section1StackView.addArrangedSubview(title3View)

        addSubview(section1StackView)
        // <----------------------------  기본 설정
        
        // 알림 설정 ---------------------------->
        section2TitleView.addSubview(section2Title)
        
        title1ViewForSection2.addSubview(title1ForSection2)
        title1ViewForSection2.addSubview(indicatorImg1ForSection2)
        title1ViewForSection2.addSubview(bottomLineView1ForSection2)
        
        title2ViewForSection2.addSubview(title2ForSection2)
        title2ViewForSection2.addSubview(indicatorImg2ForSection2)
        title2ViewForSection2.addSubview(bottomLineView2ForSection2)
        
        section2StackView.addArrangedSubview(section2TitleView)
        section2StackView.addArrangedSubview(title1ViewForSection2)
        section2StackView.addArrangedSubview(title2ViewForSection2)
        
        addSubview(section2StackView)
        // <---------------------------- 알림 설정
    
        // Love Counter ----------------------->
        section3TitleView.addSubview(section3Title)
        
        title1ViewForSection3.addSubview(title1ForSection3)
        title1ViewForSection3.addSubview(indicatorImg1ForSection3)
        title1ViewForSection3.addSubview(bottomLineView1ForSection3)
        
        title2ViewForSection3.addSubview(title2ForSection3)
        title2ViewForSection3.addSubview(indicatorImg2ForSection3)
        title2ViewForSection3.addSubview(bottomLineView2ForSection3)
        
        title3ViewForSection3.addSubview(title3ForSection3)
        title3ViewForSection3.addSubview(versionLbForSection3)
        title3ViewForSection3.addSubview(bottomLineView3ForSection3)
        
        section3StackView.addArrangedSubview(section3TitleView)
        section3StackView.addArrangedSubview(title1ViewForSection3)
        section3StackView.addArrangedSubview(title2ViewForSection3)
        section3StackView.addArrangedSubview(title3ViewForSection3)
        
        addSubview(section3StackView)
        //  <----------------------- Love Counter
    }
    
    private func updateAutoLayout(){
        
        topTitleContainerView.snp.makeConstraints { make in
            make.width.equalTo(130)
            make.height.equalTo(30)
            make.centerY.equalTo(exitBtnImg)
            make.centerX.equalToSuperview()
        }
        
        exitBtnImg.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.right.equalToSuperview().inset(10)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        exitBtn.snp.makeConstraints { make in
            make.center.equalTo(exitBtnImg)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
//        stackViewForAllSection.snp.makeConstraints { make in
//            make.top.equalTo(topTitleContainerView).offset(-20)
//            make.width.equalToSuperview()
//            make.bottom.equalToSuperview().offset(-20)
//        }
        
        // 기본 설정 ---------------------------->
        section1Title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.width.greaterThanOrEqualTo(100)
            make.height.equalTo(30)
        }
        
        section1StackView.snp.makeConstraints { make in
            make.top.equalTo(topTitleContainerView.snp.bottom).offset(30)
            make.width.equalToSuperview()
            make.height.equalTo(200)
        }
        
        bottomLineView1.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-20)
            make.height.equalTo(0.5)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        bottomLineView2.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-20)
            make.height.equalTo(0.5)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        bottomLineView3.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-20)
            make.height.equalTo(0.5)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        title1ForSection1.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.width.greaterThanOrEqualTo(100)
            make.height.equalTo(55)
        }
        
        indicatorImg1.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(10)
            make.width.equalTo(15)
            make.height.equalTo(20)
        }
        
        title2ForSection1.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.width.greaterThanOrEqualTo(100)
            make.height.equalTo(55)
        }
    
        
        indicatorImg2.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(10)
            make.width.equalTo(15)
            make.height.equalTo(20)
        }
        
        title3ForSection1.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.width.greaterThanOrEqualTo(100)
            make.height.equalTo(55)
        }
        
        indicatorImg3.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(10)
            make.width.equalTo(15)
            make.height.equalTo(20)
        }
        // <----------------------------  기본 설정
        
        // 알림 설정 ---------------------------->
        section2Title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.width.greaterThanOrEqualTo(100)
            make.height.equalTo(30)
        }
        
        section2StackView.snp.makeConstraints { make in
            make.top.equalTo(section1StackView.snp.bottom).offset(20)
            make.width.equalToSuperview()
            make.height.equalTo(150)
        }
        
        bottomLineView1ForSection2.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-20)
            make.height.equalTo(0.5)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        bottomLineView2ForSection2.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-20)
            make.height.equalTo(0.5)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        title1ForSection2.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.width.greaterThanOrEqualTo(100)
            make.height.equalTo(55)
        }
        
        indicatorImg1ForSection2.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(10)
            make.width.equalTo(22)
            make.height.equalTo(20)
        }
        
        title2ForSection2.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.width.greaterThanOrEqualTo(100)
            make.height.equalTo(55)
        }
        
        indicatorImg2ForSection2.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(10)
            make.width.equalTo(22)
            make.height.equalTo(20)
        }
        // <---------------------------- 알림 설정
        
        // Love Counter ----------------------->
        section3Title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.width.greaterThanOrEqualTo(100)
            make.height.equalTo(30)
        }
        
        section3StackView.snp.makeConstraints { make in
            make.top.equalTo(section2StackView.snp.bottom).offset(20)
            make.width.equalToSuperview()
            make.height.equalTo(200)
        }
        
        bottomLineView1ForSection3.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-20)
            make.height.equalTo(0.5)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        bottomLineView2ForSection3.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-20)
            make.height.equalTo(0.5)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        bottomLineView3ForSection3.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-20)
            make.height.equalTo(0.5)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        title1ForSection3.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.width.greaterThanOrEqualTo(100)
            make.height.equalTo(55)
        }
        
        indicatorImg1ForSection3.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(10)
            make.width.equalTo(15)
            make.height.equalTo(20)
        }
        
        title2ForSection3.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.width.greaterThanOrEqualTo(100)
            make.height.equalTo(55)
        }
        
        indicatorImg2ForSection3.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(10)
            make.width.equalTo(15)
            make.height.equalTo(20)
        }
        
        title3ForSection3.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.width.greaterThanOrEqualTo(100)
            make.height.equalTo(55)
        }
        
        versionLbForSection3.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(10)
            make.width.greaterThanOrEqualTo(100)
            make.height.equalTo(30)
        }
        //  <----------------------- Love Counter
        
    }
}