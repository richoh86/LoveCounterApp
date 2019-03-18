//
//  NameAndImgChangeViewController.swift
//  LoveCounterApp
//
//  Created by richard oh on 18/03/2019.
//  Copyright © 2019 richard oh. All rights reserved.
//

import UIKit

class NameAndImgChangeViewController: UIViewController {
    
    let nameAndImgChangeView = NameAndImgChangeView()
    
    var btnTag: Int?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(btnTag: Int) {
        self.init()
        self.btnTag = btnTag
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .clear
        self.definesPresentationContext = true
        
        nameAndImgChangeView.option1.addTarget(self, action: #selector(changeNameAction), for: .touchUpInside)
        nameAndImgChangeView.option2.addTarget(self, action: #selector(changeImgAction), for: .touchUpInside)
        nameAndImgChangeView.option3.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        
        view.addSubview(nameAndImgChangeView)
        updateAutoLayout()
    }
    
    @objc func changeNameAction(){
        if let tag = btnTag {
            print("이름변경",tag)
        }
    }
    
    @objc func changeImgAction(){
        if let tag = btnTag {
            print("프로필사진변경",tag)
        }
    }
    
    @objc func cancelAction(){
        print("취소")
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateAutoLayout(){
        
        nameAndImgChangeView.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-100)
            make.height.equalToSuperview().offset(-650)
            make.center.equalToSuperview()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
