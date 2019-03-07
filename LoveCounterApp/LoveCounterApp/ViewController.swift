//
//  ViewController.swift
//  LoveCounterApp
//
//  Created by richard oh on 07/03/2019.
//  Copyright © 2019 richard oh. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var blackBackGroundView: UIView!
    
    let shapeLayer = CAShapeLayer()
    let textView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        blackBackGroundView.alpha = 0.4
        
        let center = view.center
        let circlarPathB = UIBezierPath(arcCenter: .zero, radius: 120, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        shapeLayer.path = circlarPathB.cgPath
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = .none
        shapeLayer.position = center
        
        textView.center = center
        textView.bounds.size = CGSize(width: 100, height: 87)
        textView.text = "1일"
        textView.textColor = UIColor.white
        textView.textAlignment = .center
        textView.backgroundColor = .none
        textView.font = UIFont.boldSystemFont(ofSize: 50)
        
        view.layer.addSublayer(shapeLayer)
        view.addSubview(textView)
        
    }
    
    // status bar -> white color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

