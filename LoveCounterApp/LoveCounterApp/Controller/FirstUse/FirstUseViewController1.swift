//
//  ViewController.swift
//  LoveCounterApp
//
//  Created by richard oh on 07/03/2019.
//  Copyright © 2019 richard oh. All rights reserved.
//

import UIKit
import SnapKit

/// 연인이 된 날짜를 입력하는 페이지
class FirstUseViewController1: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var blackBackGroundView: UIView!
    
    let firstUserView = FirstUserView()
    var strDateForSpinnerUIBox: String?
    var strSelectedDayForCount: String?
    
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
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "FirstUseViewController2") else {return}
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func selectDateSelectionBtn(){
        
        firstUserView.cancelBtn.addTarget(self, action: #selector(cancelBtnAction), for: .touchUpInside)
        
        if let unwrappedStrDate = strDateForSpinnerUIBox {
            firstUserView.dateText.text = unwrappedStrDate
        }
        
        showDateViewWithAnimation()
    }
    
    @objc func completeSelectDate(){
        
        // 선택된 날짜 (연인이 된 날짜)
        let selectedDate = firstUserView.dateSpinner.date
        // Date 포맷은 yyyy.MM.dd
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy.MM.dd"
        // 선택된 시간 String 값을 변환
        strDateForSpinnerUIBox = dateFormatter1.string(from: selectedDate)
        // spinnerUIBox안에 보여주는 날짜 표기
        firstUserView.dateTextLb.text = strDateForSpinnerUIBox
        
        // 현재 날짜
        let currentDate = Date()
        
        // UserDefault 저장
        UserDefaults.standard.set(selectedDate, forKey: "selDate")
        
        let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: selectedDate)
        let date2 = calendar.startOfDay(for: currentDate)
        let components = calendar.dateComponents([.day], from: date1, to: date2)

        guard let days = components.day else {return}
        
        if days >= 0 {
            firstUserView.textLb.text = "\(days + 1)일"
        }else{
//            firstUserView.textLb.text = "\(-days + 1)일"
            let action1 = UIAlertAction(title: "예", style: .default) { (action) in
                
                // Spinner의 선택 날짜를 현재 날짜로 변경
                let currentDate = Date()
                self.firstUserView.dateSpinner.setDate(currentDate, animated: true)
                
                // 선택된 시간 String 값 변환
                let strCurrentDate = dateFormatter1.string(from: currentDate)
                self.strDateForSpinnerUIBox = strCurrentDate
                
                // Spinner UI Box 안에 보여주는 날짜 현재 날짜로 변경
                self.firstUserView.dateTextLb.text = strCurrentDate
                
            }
            let alertVC = UIAlertController(title: "날짜확인", message: "오늘 날짜 이후로는 설정할 수 없습니다!", preferredStyle: UIAlertController.Style.alert)
            
            alertVC.addAction(action1)
            self.present(alertVC, animated: true, completion: nil)

        }
        hideDateViewWithAnimation()
        
    }
    
    @objc func cancelBtnAction(){
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            
            self.firstUserView.dateSpinnerUIbox.frame = CGRect(x: 0, y: self.firstUserView.bounds.height, width: self.firstUserView.bounds.width, height: self.firstUserView.bounds.height*(3/5))
            
        })
    }
    
    private func showDateViewWithAnimation(){
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.firstUserView.dateSpinnerUIbox.backgroundColor = .white
            self.firstUserView.dateSpinnerUIbox.frame =
//                CGRect(x: 0, y: self.firstUserView.bounds.height*(3/5), width: self.firstUserView.bounds.width, height: self.firstUserView.bounds.height*(3/5))
            CGRect(x: 0, y: self.firstUserView.bounds.height - 320, width: self.firstUserView.bounds.width, height: 320)
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
        firstUserView.shapeLayer.position.x = self.view.center.x
        firstUserView.shapeLayer.position.y = self.view.center.y - 70
        self.view.layer.addSublayer(shapeLayer)
    }
    
    // status bar -> white color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

