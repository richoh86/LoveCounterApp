//
//  ViewController.swift
//  LoveCounterApp
//
//  Created by richard oh on 07/03/2019.
//  Copyright © 2019 richard oh. All rights reserved.
//

import UIKit
import SnapKit

/// 내꺼의 생일을 입력하는 페이지
class FirstUseViewController3: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var blackBackGroundView: UIView!
    
    let firstUserView = FirstUserView()
    var strDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createUI()
    }
    
    private func createUI(){
        
        // 검은색 뷰의 opacity 값 40% 설정
        blackBackGroundView.alpha = 0.4
        
        // 유저가 처음 앱을 사용할 때 보여주는 뷰 생성
        firstUserView.frame =
            CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height )
        
        // 입력 페이지에 따라서 변경 (내꺼 생일 입력 페이지)
        firstUserView.titleOnTop.text = "내꺼의 생일을 입력해주세요!"
        firstUserView.imageView.image = UIImage(named: "icons8-confetti-filled-100")
        firstUserView.textLb.text = "내꺼"
        firstUserView.nextButton.setTitle("완료", for: .normal)
    
        // 다음 VC로 넘겨주는 버튼 액션
        firstUserView.nextButton.addTarget(self, action: #selector(nextBtnAction), for: .touchUpInside)
        // 날짜를 선택하는 뷰 만들어 보여주기!
        firstUserView.dateSelectButton.addTarget(self, action: #selector(selectDateSelectionBtn), for: .touchUpInside)
        // 날짜 선택 완료시 날짜를 가져올 수 있도록 설정
        firstUserView.completeBtn.addTarget(self, action: #selector(completeSelectDate), for: .touchUpInside)
        // 날짜 선택 박스 UI 생성
        firstUserView.showDateSpinnerUIBox()
        // 모든 UI 구성이 끝나면 마지막에 subView
        self.view.addSubview(firstUserView)
        
    }
    
    @objc func nextBtnAction(){

        print("완료")
//        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "FirstUseViewController3") else {return}
//        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func selectDateSelectionBtn(){
        
        firstUserView.cancelBtn.addTarget(self, action: #selector(cancelBtnAction), for: .touchUpInside)
        
        if let unwrappedStrDate = strDate {
            firstUserView.dateText.text = unwrappedStrDate
        }
        
        showDateViewWithAnimation()
    }
    
    @objc func completeSelectDate(){
        
        let date = firstUserView.dateSpinner.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        strDate = dateFormatter.string(from: date)
        
        firstUserView.dateTextLb.text = strDate
        
        hideDateViewWithAnimation()
        
    }
    
    @objc func cancelBtnAction(){
        print("취소")
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            
            self.firstUserView.dateSpinnerUIbox.frame = CGRect(x: 0, y: self.firstUserView.bounds.height, width: self.firstUserView.bounds.width, height: self.firstUserView.bounds.height*(3/5))
            
        })
    }
    
    private func showDateViewWithAnimation(){
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.firstUserView.dateSpinnerUIbox.backgroundColor = .white
            self.firstUserView.dateSpinnerUIbox.frame = CGRect(x: 0, y: self.firstUserView.bounds.height*(3/5), width: self.firstUserView.bounds.width, height: self.firstUserView.bounds.height*(3/5))
        })
    }
    
    private func hideDateViewWithAnimation(){
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            
            self.firstUserView.dateSpinnerUIbox.frame = CGRect(x: 0, y: self.firstUserView.bounds.height, width: self.firstUserView.bounds.width, height: self.firstUserView.bounds.height*(3/5))
            
        })
    }
    
    override func viewDidLayoutSubviews() {
        // shapeLayer 생성 및 layer에 추가
        let shapeLayer = firstUserView.createShapeLayer()
        self.view.layer.addSublayer(shapeLayer)
    }
    
    // status bar -> white color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
//    @objc func selectDateAction(){
//
//        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
//
//            self.firstUserView.dateSpinnerUIbox.backgroundColor = .white
//            self.firstUserView.dateSpinnerUIbox.frame = CGRect(x: 0, y: self.firstUserView.bounds.height*(3/5), width: self.firstUserView.bounds.width, height: self.firstUserView.bounds.height*(3/5))
//
//        })
//
//    }
//
//    override func viewDidLayoutSubviews() {
//
//        let shapeLayer = firstUserView.createShapeLayer()
//        self.view.layer.addSublayer(shapeLayer)
//
//        firstUserView.showDateSpinnerUIBox()
//
//        firstUserView.cancelBtn.addTarget(self, action: #selector(cancelBtnAction), for: .touchUpInside)
//    }
//
//    @objc func cancelBtnAction(){
//        print("취소")
//
//        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
//
//            self.firstUserView.dateSpinnerUIbox.frame = CGRect(x: 0, y: self.firstUserView.bounds.height, width: self.firstUserView.bounds.width, height: self.firstUserView.bounds.height*(3/5))
//
//        }) { _ in
//            self.firstUserView.dateSpinnerUIbox.removeFromSuperview()
//        }
//
//    }
//
//    // status bar -> white color
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
}

