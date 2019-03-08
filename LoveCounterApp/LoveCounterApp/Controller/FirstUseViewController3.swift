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
        firstUserView.textView.text = "내꺼"
        firstUserView.nextButton.setTitle("완료", for: .normal)
    
        self.view.addSubview(firstUserView)
    }
    
    override func viewDidLayoutSubviews() {
        
        let shapeLayer = firstUserView.createShapeLayer()
        self.view.layer.addSublayer(shapeLayer)
        
    }
    
    // status bar -> white color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

