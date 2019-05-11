//
//  NameAndImgChangeViewController.swift
//  LoveCounterApp
//
//  Created by richard oh on 18/03/2019.
//  Copyright © 2019 richard oh. All rights reserved.
//

import UIKit
import Photos
import DeviceKit

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
    
    /// 이름 변경 액션
    @objc func changeNameAction(){
        
        if let tag = btnTag {
            print("이름변경",tag)    
            let nameChangeVC = NameChangeViewController(btnTag: tag)
            nameChangeVC.modalPresentationStyle = .overCurrentContext
            nameChangeVC.modalTransitionStyle = .coverVertical
            self.present(nameChangeVC, animated: true, completion: nil)
        }
    }
    
    /// 프로필 사진 변경 액션
    @objc func changeImgAction(){
        
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            
            DispatchQueue.main.async {
                PHPhotoLibrary.requestAuthorization { (status) in
                    if status == .authorized {
                        if let tag = self.btnTag {
                            print(tag)
                            let imagePickerController = UIImagePickerController()
                            imagePickerController.delegate = self
                            imagePickerController.sourceType = .photoLibrary
                            self.present(imagePickerController, animated: true, completion: nil)
                        }
                    }else{
//                        let alertVC = UIAlertController(title: "권한요청확인", message: "앨범 접근권한이 없으면\n프로필 사진 변경을 할 수 없습니다", preferredStyle: UIAlertController.Style.alert)
                        let alertVC = UIAlertController(title: "AuthorizationCheck", message: "With no authorization to access photo library,\nyou can't change your profile picture", preferredStyle: UIAlertController.Style.alert)
//                        let action1 = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { (action1) in})
                        let action1 = UIAlertAction(title: "Confirm", style: UIAlertAction.Style.default, handler: { (action1) in})
                        alertVC.addAction(action1)
                        self.present(alertVC, animated: true, completion: nil)
                    }
                }
            }
            
        }else{
            if let tag = self.btnTag {
                print(tag)
                let imagePickerController = UIImagePickerController()
                imagePickerController.delegate = self
                imagePickerController.sourceType = .photoLibrary
                DispatchQueue.main.async {
                    self.present(imagePickerController, animated: true, completion: nil)
                }
            }
        }
    }
    
    /// 돌아가기 액션
    @objc func cancelAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateAutoLayout(){
        
            nameAndImgChangeView.snp.makeConstraints { make in
                make.width.equalTo(220)
                make.height.equalTo(240)
                make.center.equalToSuperview()
            }
    }
}

// MARK: - UIImagePickerControllerDelegate
extension NameAndImgChangeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /// Get DocumentDirectory Path
    ///
    /// - Returns: URL(Path)
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {return}
        
        if let tag = self.btnTag {
            
            // 첫번째 이미지일 경우
            if tag == 1{
                let userInfo = [ "image1": image ]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "imageChange"), object: nil, userInfo: userInfo)
                
                // documentDirectory에 이미지 파일 쓰기
                // 위젯용 디렉토리에도 파일쓰기 추가 2019.04.26 OHWS
                if let data = image.pngData() {
                    
                    // 1.원래 디렉토리에 파일 쓰기
                    let fileName = getDocumentsDirectory().appendingPathComponent("profileImg1.png")
                    try? data.write(to: fileName)
                    
                    // 2.위젯을 위한 디렉토리에 파일 쓰기 추가 2019.04.26 OHWS
                    let fileURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.LoveCounter.widget")
                    if let imageURL1 = fileURL?.appendingPathComponent("profileImg1.png"){
                        
                        let image1 = UIImage(data: data)
                        if let image1Compressed = image1?.jpegData(compressionQuality: 0.1){
                            try? image1Compressed.write(to: imageURL1)
                        }
                    }
                    
                }
                self.dismiss(animated: true, completion: nil)
                
                // 두번째 이미지일 경우
            }else if tag == 2 {
                let userInfo = [ "image2": image ]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "imageChange"), object: nil, userInfo: userInfo)
                
                // documentDirectory에 이미지 파일 쓰기
                if let data = image.pngData() {
                    
                    // 1.원래 디렉토리에 파일 쓰기
                    let fileName = getDocumentsDirectory().appendingPathComponent("profileImg2.png")
                    try? data.write(to: fileName)
                    
                    // 2.위젯을 위한 디렉토리에 파일 쓰기 추가 2019.04.26 OHWS
                    let fileURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.LoveCounter.widget")
                    if let imageURL2 = fileURL?.appendingPathComponent("profileImg2.png"){
                        
                        let image2 = UIImage(data: data)
                        if let image2Compressed = image2?.jpegData(compressionQuality: 0.1){
                            try? image2Compressed.write(to: imageURL2)
                        }
                    }
                }
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

