//
//  SettingsViewController.swift
//  LoveCounterApp
//
//  Created by richard oh on 20/03/2019.
//  Copyright © 2019 richard oh. All rights reserved.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {

    let settingsView = SettingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.clear
        
        settingsView.exitBtn.addTarget(self, action: #selector(exitBtnAction), for: .touchUpInside)
        self.view.addSubview(settingsView)
        
        updateAutoLayout()
    }
    
    @objc func exitBtnAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    private func updateAutoLayout(){
        
        settingsView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
        }
    }

}
