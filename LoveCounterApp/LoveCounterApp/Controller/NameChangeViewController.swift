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
        print("이름 변경 완료")
        nameChangeView.textFieldForName.resignFirstResponder()
        if let tag = btnTag{
            guard let strName = nameChangeView.textFieldForName.text else {return}
            if tag == 1{
                UserDefaults.standard.set(strName, forKey: "name1")
                let userInfo = [ "name1": strName ]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "nameChange"), object: nil, userInfo: userInfo)
                print("1번 이름 변경 시도")
            }else if tag == 2{
                UserDefaults.standard.set(strName, forKey: "name2")
                let userInfo = [ "name2": strName ]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "nameChange"), object: nil, userInfo: userInfo)
                print("2번 이름 변경 시도")
            }
        }
        // NameAndImgChangeVC를 없애고 MainVC로 돌아갈 수 있도록.. dismiss가 작동하지 않음..ㅜ
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dismissNameAndImgVC"), object: nil)
        self.dismiss(animated: true)
    }
    
//    @objc func cancelWriteName(){
//        nameChangeView.textFieldForName.resignFirstResponder()
//        self.dismiss(animated: true, completion: nil)
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .black
        view.addSubview(nameChangeView)
        btnContainerView.addSubview(completeBtn)
        view.addSubview(btnContainerView)
        
        updateAutoLayout()
        nameChangeView.textFieldForName.becomeFirstResponder()
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            print(keyboardHeight)
            
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