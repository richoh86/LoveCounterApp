//
//  NameChangeViewController.swift
//  LoveCounterApp
//
//  Created by richard oh on 18/03/2019.
//  Copyright © 2019 richard oh. All rights reserved.
//

import UIKit
import SnapKit

class NameChangeViewController: UIViewController {
    
    let nameChangeView = NameChangeView()
    var btnTag: Int?
    
    let btnContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9943013787, green: 0.4424599409, blue: 0.4413398504, alpha: 1)
        return view
    }()
    
    let completeBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("완료", for: .normal)
        btn.titleLabel?.textColor = .white
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.addTarget(self, action: #selector(nameWritecompleted), for: .touchUpInside)
        return btn
    }()
    
    convenience init(btnTag: Int) {
        self.init()
        self.btnTag = btnTag
    }
    
    @objc func nameWritecompleted(sender: UIButton) {
        nameChangeView.textFieldForName.resignFirstResponder()
        if let tag = btnTag{
            guard let strName = nameChangeView.textFieldForName.text else {return}
            if tag == 1{
                UserDefaults.standard.set(strName, forKey: "name1")
                let userInfo = [ "name1": strName ]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "nameChange"), object: nil, userInfo: userInfo)
            }else if tag == 2{
                UserDefaults.standard.set(strName, forKey: "name2")
                let userInfo = [ "name2": strName ]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "nameChange"), object: nil, userInfo: userInfo)
            }
        }
        self.dismiss(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserDefaultNameForTextField()
        
        view.backgroundColor = .black
        view.addSubview(nameChangeView)
        btnContainerView.addSubview(completeBtn)
        view.addSubview(btnContainerView)
        
        updateAutoLayout()
        nameChangeView.textFieldForName.becomeFirstResponder()
    }
    
    /// User가 이미 입력한 이름 정보가 있다면 수정시 원래 이름을 텍스트 필드에 보여준다
    private func getUserDefaultNameForTextField() {
        // Do any additional setup after loading the view.
        
        if let tag = self.btnTag {
            if tag == 1{
                guard let name1 = UserDefaults.standard.string(forKey: "name1") else {return}
                self.nameChangeView.textFieldForName.text = name1
            }else{
                guard let name2 = UserDefaults.standard.string(forKey: "name2") else {return}
                self.nameChangeView.textFieldForName.text = name2
            }
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            btnContainerView.snp.makeConstraints { make in
                make.width.equalToSuperview()
                make.height.equalTo(55)
                make.bottom.equalToSuperview().offset(-keyboardHeight)
            }
        }
        
    }
        func updateAutoLayout(){
            
            nameChangeView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            completeBtn.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
        }
}
