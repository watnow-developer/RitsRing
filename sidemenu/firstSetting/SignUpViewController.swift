//
//  SignUpViewController.swift
//  sidemenu
//
//  Created by 瀧頭　直斗 on 2019/08/21.
//  Copyright © 2019 yu. All rights reserved.
//

import UIKit

class SignUpViewController:UIViewController, UITextFieldDelegate{
    
    var screenwidth:CGFloat = UIScreen.main.bounds.width
    
    var maillabel:UILabel = {
        var label = UILabel(frame: CGRect(x: 50, y: UIScreen.main.bounds.height/3-95, width: 200, height: 30))
        label.text = "メールアドレス"
        label.textColor = UIColor.black
        return label
    }()
    
    var passlabel:UILabel = {
        var label = UILabel(frame: CGRect(x: 50, y: UIScreen.main.bounds.height/3-20, width: 200, height: 30))
        label.text = "パスワード"
        label.textColor = UIColor.black
        return label
    }()
    
    var signupMailTextField:UITextField = {
        var textfield = UITextField(frame: CGRect(x: 50, y: UIScreen.main.bounds.height/3-60, width: 300, height:40))
        return textfield
    }()
    
    var signupPassTextField:UITextField = {
        var textfield = UITextField(frame: CGRect(x: 50, y: UIScreen.main.bounds.height/3+10, width: 300, height:40))
        return textfield
    }()
    
    var signUpButton:UIButton = {
        var button = UIButton(frame: CGRect(x: 100, y: UIScreen.main.bounds.height/3+200, width: 200, height: 50))
        button.backgroundColor = UIColor(red: 230/255, green: 124/255, blue: 115/255, alpha: 1)
        button.setTitle("ログイン", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(SignUpViewController.gogoNext(_:)), for: .touchUpInside)
        return button
    }()
    
    var NewButton:UIButton = {
        var button = UIButton(frame: CGRect(x: 100, y: UIScreen.main.bounds.height/3*2, width: 200, height: 50))
        button.backgroundColor = UIColor(red: 230/255, green: 124/255, blue: 115/255, alpha: 1)
        button.setTitle("新規登録", for: .normal)
        button.setTitleColor(.white, for: .normal)
       // button.addTarget(self, action: #selector(SignUpViewController.goNext(_:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(SignUpViewController.didTapNewButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private func showErrorIFNeeded(_ errorOrNil: Error?){
        //guard文は条件が偽の場合{}内の処理が行われる
        //エラーがない場合はreturnで関数を抜け出す
        guard errorOrNil != nil else {return}
        let messages = "エラーが起きました"
        let alert = UIAlertController(title: nil, message: messages, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true ,completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.signupMailTextField.delegate = self
        self.signupPassTextField.delegate = self
        view.addSubview(maillabel)
        self.signupPassTextField.borderStyle = .roundedRect
        view.addSubview(signupPassTextField)
        self.signupMailTextField.borderStyle = .roundedRect
        view.addSubview(signupMailTextField)
        view.addSubview(signUpButton)
        view.addSubview(NewButton)
        view.addSubview(passlabel)
        
    }
    
    
    @objc func didTapNewButton(_ sender:UIButton){
        let email = signupMailTextField ?? ""
        
    }
    
    
    /*
     確認コードの画面に映る前に確認
    @objc func goNext(_ sender:UIButton){
        let nextvc = NextViewController()
        nextvc.view.backgroundColor = .white
        self.present(nextvc, animated: true, completion: nil)
        
    }
    */
    @objc func gogoNext(_ sender:UIButton){
        let nextvc = genderSelectController()
        nextvc.view.backgroundColor = UIColor.white
        self.present(nextvc,animated: true, completion:  nil)
    }
    
    
}
