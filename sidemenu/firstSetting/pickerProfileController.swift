//
//  pickerProfileController.swift
//  sidemenu
//
//  Created by yu on 2019/08/11.
//  Copyright © 2019 yu. All rights reserved.
//

import UIKit
import Firebase

class pickerProfileViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate{
    
    
    let button = UIButton()
    let textfield_faculty = UITextField()
    let textfield_enroll = UITextField()
    let textfield_gender = UITextField()
    
    
    var ref: DatabaseReference!
    
    
    
    //以下"faculty" を学部、"courses"を学科、"gender"を性別　とする
    
    
    
    let faculty = ["法学部","産業社会学部","国際関係学部","文学部","映像学部","政策科学部","総合心理学部","グローバル教養学部","経済学部","スポーツ健康科学部","食マネジメント学部","理工学部","情報理工学部","生命科学部","薬学部"]
    let  enroll = ["2019年度","2018年度","2017年度","2016年度","2015年度","2014年度","2013年度","その他/教授"]
    let gender = ["女性","男性"]
    
    let myPickerView = UIPickerView()
    
    
    var current_arr : [String] = []
    
    var active_textfield : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //textfield
        
        
        
        //textfield_faculty
        textfield_faculty.keyboardType = .default
        textfield_faculty.borderStyle = .roundedRect
        textfield_faculty.returnKeyType = .done
        self.view.addSubview(textfield_faculty)
        textfield_faculty.delegate = self
        
        
        //textfield_enroll
        textfield_enroll.keyboardType = .default
        textfield_enroll.borderStyle = .roundedRect
        textfield_enroll.returnKeyType = .done
        self.view.addSubview(textfield_enroll)
        textfield_enroll.delegate = self
        
        //textfield_gender
        textfield_gender.keyboardType = .default
        textfield_gender.borderStyle = .roundedRect
        textfield_gender.returnKeyType = .done
        self.view.addSubview(textfield_gender)
        textfield_gender.delegate = self
        
        
        
        //background custom
        
        view.backgroundColor = UIColor.white
        
        
        textfield_faculty.delegate = self
        textfield_enroll.delegate  = self
        textfield_gender.delegate = self
        
        myPickerView.delegate = self
        myPickerView.dataSource = self
        
        textfield_faculty.inputView = myPickerView
        textfield_enroll.inputView  = myPickerView
        textfield_gender.inputView = myPickerView
        
        
        
        
        //color custom
        textfield_gender.backgroundColor = UIColor(red: 255/255, green: 230/255, blue: 230/255, alpha: 0.5)
        textfield_enroll.backgroundColor = UIColor(red: 255/255, green: 230/255, blue: 230/255, alpha: 0.5)
        textfield_faculty.backgroundColor = UIColor(red: 255/255, green: 230/255, blue: 230/255, alpha: 0.5)
        
        // サイズ設定
        textfield_gender.frame.size.width = self.view.frame.width * 2 / 3
        textfield_gender.frame.size.height = 45
        
        textfield_enroll.frame.size.width = self.view.frame.width * 2 / 3
        textfield_enroll.frame.size.height = 45
        
        textfield_faculty.frame.size.width = self.view.frame.width * 2 / 3
        textfield_faculty.frame.size.height = 45
        // 位置設定
        textfield_gender.center.x = self.view.center.x
        textfield_gender.center.y = 320
        
        textfield_faculty.center.x = self.view.center.x
        textfield_faculty.center.y = 180
        
        textfield_enroll.center.x = self.view.center.x
        textfield_enroll.center.y = 250
        
        //初期メッセージ
        textfield_faculty.placeholder = "学部を選択してください"
        textfield_gender.placeholder = "性別を選択してください"
        textfield_enroll.placeholder = "入学年度を選択してください"
        
        
        
        
        //文字色
        textfield_enroll.textColor = UIColor.gray
        textfield_faculty.textColor = UIColor.gray
        textfield_gender.textColor = UIColor.gray
        
        //文字大きさ
        textfield_gender.font = UIFont.systemFont(ofSize: 18)
        textfield_enroll.font = UIFont.systemFont(ofSize: 18)
        textfield_faculty.font = UIFont.systemFont(ofSize: 18)
        
        // 中央寄せ
        textfield_gender.textAlignment = NSTextAlignment.center
        textfield_enroll.textAlignment = NSTextAlignment.center
        textfield_faculty.textAlignment = NSTextAlignment.center
        //完了ボタン
        
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title:"完了",style: .plain, target: self,action:
            #selector(self.dissmissKeyboard))
        toolBar.setItems([doneButton],animated:false)
        toolBar.isUserInteractionEnabled = true
        
        
        textfield_faculty.inputAccessoryView = toolBar
        textfield_gender.inputAccessoryView = toolBar
        textfield_enroll.inputAccessoryView = toolBar
        
        //picker custom
        toolBar.barTintColor = UIColor(red: 230/255, green: 124/255, blue: 115/255, alpha: 1)
        toolBar.tintColor = .white
        
        
        
        
        //next button
        button.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        button.layer.position = CGPoint(x: self.view.frame.width/2, y: 400)
        button.backgroundColor = UIColor(red: 230/255, green: 124/255, blue: 115/255, alpha: 1)
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor.clear.cgColor
        button.addTarget(self, action: #selector(pickerProfileViewController.GONext(_ :)), for: .touchUpInside)
        view.addSubview(button)
        
       ref = Database.database().reference()
        
    }
    //ピッカー設定
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        active_textfield = textField
        
        switch textField {
        case textfield_faculty :
            current_arr = faculty
        case textfield_gender :
            current_arr = gender
        case textfield_enroll :
            current_arr = enroll
        default:
            print("default")
        }
        myPickerView.reloadAllComponents()
        
        return true
    }
    
    
    @objc func GONext(_ sender:UIButton){
        
        /*firebase*/
        

         self.ref.child("user/A").setValue(["faculty": textfield_faculty.text,
                                            "enroll": textfield_enroll.text,
                                            "gender": textfield_gender.text])
        

        
        let GScontroller = genderSelectController()
        self.present(UINavigationController(rootViewController: GScontroller), animated: true ,completion: nil)
      
    }
    
    @objc func dissmissKeyboard()
    {
        view.endEditing(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return current_arr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return current_arr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(current_arr[row])
        active_textfield.text = current_arr[row]
    }
    
}



