//
//  ViewController.swift
//  addriri
//
//  Created by 瀧頭　直斗 on 2019/07/09.
//  Copyright © 2019 瀧頭　直斗. All rights reserved.
//

import UIKit


class CreateProfileViewController: UIViewController {
    
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let profilelabel:UILabel = UILabel(frame:CGRect(x: 10, y: 200, width: 200, height: 100))
        profilelabel.textAlignment = .center
        profilelabel.center.x = self.view.center.x
        profilelabel.font = .systemFont(ofSize: 40)
        profilelabel.textColor = .init(red: 255/255, green: 100/255, blue: 100/255, alpha: 1)
        profilelabel.text = "Profile"
        self.view.addSubview(profilelabel)
        
        
        let UserView:UIImageView = UIImageView(image: UIImage(named: "profile"))
        UserView.frame = CGRect(x: 100, y: 300, width:200, height: 200)
        UserView.center.x = self.view.center.x
        UserView.layer.cornerRadius = 20
        UserView.clipsToBounds = true
        self.view.addSubview(UserView)
        
        
        let tapview = UITapGestureRecognizer(target: self, action:#selector(imageTapped))
        //headerview.isUserInteractionEnabled = true
        //headerview.addGestureRecognizer(tapview)
        
        
        
        let Namelabel:UILabel = UILabel(frame: CGRect(x: 10, y: 500, width: 100, height: 200))
        Namelabel.font = .systemFont(ofSize: 25)
        Namelabel.textColor = .init(red: 255/255, green: 100/255, blue: 100/255, alpha: 1)
        Namelabel.text = "Name:"
        self.view.addSubview(Namelabel)
        
        
        let NameTextField:UITextField = UITextField(frame: CGRect(x:0, y: 620, width: self.view.frame.width, height: 70))
        NameTextField.font = .systemFont(ofSize: 30)
        NameTextField.backgroundColor = .init(red: 1, green: 230/255, blue: 230/255, alpha: 1)
        NameTextField.placeholder = "名前を入力してください"
        self.view.addSubview(NameTextField)
        
        
        let gobutton:UIButton = UIButton(frame: CGRect(x: 0, y: 700, width: 80, height: 50))
        gobutton.backgroundColor = UIColor(red: 230/255, green: 124/255, blue: 115/255, alpha: 1)
        gobutton.center.x = self.view.center.x
        gobutton.setTitle("GO", for: .normal)
        gobutton.setTitleColor(.white, for: .normal)
        gobutton.layer.cornerRadius = 20
        self.view.addSubview(gobutton)
        
        
        let warninglabel:UILabel = UILabel(frame:CGRect(x: 0, y: 800, width: self.view.frame.width, height: 50))
        warninglabel.text = "※フレンドにのみ表示されます"
        warninglabel.textAlignment = .center
        self.view.addSubview(warninglabel)
        
        // Do any additional setup after loading the view.
}


@objc func goNext(_ sender:UIButton){
    let CFcontroller = pickerProfileViewController()
    self.present(UINavigationController(rootViewController: CFcontroller), animated: true ,completion: nil)
    
}
    
    @objc fileprivate func imageTapped(){
        // アルバム(Photo liblary)の閲覧権限の確認
        checkPermission()
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            print("present Start")
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func checkPermission(){
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationStatus {
        case .authorized:
            print("auth")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                }
            })
            print("not Determined")
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        @unknown default:
            break
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}


