//
//  NameAndImgChangeViewController.swift
//  LoveCounterApp
//
//  Created by richard oh on 18/03/2019.
//  Copyright © 2019 richard oh. All rights reserved.
//

import UIKit
import Photos

class NameAndImgChangeViewController: UIViewController{
    
    let nameAndImgChangeView = NameAndImgChangeView()
    
    var btnTag: Int?
    
    // 버튼 tag 값을 넘겨 받아서 버튼 액션이 일어난 이미지 뷰에와 텍스트에 이름을 변경한다
    convenience init(btnTag: Int) {
        self.init()
        self.btnTag = btnTag
        commonInit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        dismissVCReg()
    }
    
    private func dismissVCReg() {
        
//        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "dismissNameAndImgVC"), object: nil, queue: nil) { (noti) in
//            print("수신성공!!!")
//            self.dismiss(animated: false, completion: nil)
//        }
        
//        NotificationCenter.default.addObserver(self, selector: #selector(cancelAction), name: NSNotification.Name(rawValue: "dismissNameAndImgVC"), object: nil)
    }
    
    private func commonInit(){
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
            let nameChangeVC = NameChangeViewController(btnTag: tag)
            nameChangeVC.modalPresentationStyle = .overCurrentContext
            nameChangeVC.modalTransitionStyle = .coverVertical
            self.present(nameChangeVC, animated: true, completion: nil)
            
            
        }
    }
    
    @objc func changeImgAction(){
        
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization { (status) in
                if status == .authorized {
                    if let tag = self.btnTag {
                        print("프로필사진변경",tag)
                        let imagePickerController = UIImagePickerController()
                        imagePickerController.delegate = self
                        imagePickerController.sourceType = .photoLibrary
                        self.present(imagePickerController, animated: true, completion: nil)
                    }
                }else{
                    let alertVC = UIAlertController(title: "권한요청확인", message: "앨범 접근권한이 없으면\n프로필 사진 변경을 할 수 없습니다", preferredStyle: UIAlertController.Style.alert)
                    let action1 = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { (action1) in})
                    alertVC.addAction(action1)
                    self.present(alertVC, animated: true, completion: nil)
                }
            }
        }else{
            if let tag = self.btnTag {
                print("프로필사진변경",tag)
                let imagePickerController = UIImagePickerController()
                imagePickerController.delegate = self
                imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }
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
}

// MARK: - UIImagePickerControllerDelegate
extension NameAndImgChangeViewController: UIImagePickerControllerDelegate {
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        print(info[.originalImage])
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("이미지 선택 취소")
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - UINavigationControllerDelegate
extension NameAndImgChangeViewController: UINavigationControllerDelegate {
   
}

