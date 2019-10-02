//
//  SignInViewController.swift
//  sidemenu
//
//  Created by 瀧頭　直斗 on 2019/08/26.
//  Copyright © 2019 yu. All rights reserved.
//
import UIKit
import Firebase

class SignInViewController:UIViewController, UITextFieldDelegate{
    
    var screenwidth:CGFloat = UIScreen.main.bounds.width
    
    var maillabel:UILabel = {
        var label = UILabel(frame: CGRect(x: 50, y: UIScreen.main.bounds.height/3-95, width: 400, height: 30))
        label.text = "メールアドレス(RAINBOWIDのみ）"
        label.textColor = UIColor.black
        return label
    }()
    
    var passlabel:UILabel = {
        var label = UILabel(frame: CGRect(x: 50, y: UIScreen.main.bounds.height/3-20, width: 200, height: 30))
        label.text = "パスワード"
        label.textColor = UIColor.black
        return label
    }()
    
    var signInMailTextField:UITextField = {
        var textfield = UITextField(frame: CGRect(x: 50, y: UIScreen.main.bounds.height/3-60, width: 300, height:40))
        textfield.placeholder = "@ed.ritsumei.ac.jp"
        return textfield
    }()
    
    var signInPassTextField:UITextField = {
        var textfield = UITextField(frame: CGRect(x: 50, y: UIScreen.main.bounds.height/3+10, width: 300, height:40))
        return textfield
    }()
    
    var signInButton:UIButton = {
        var button = UIButton(frame: CGRect(x: 100, y: UIScreen.main.bounds.height/3+200, width: 200, height: 50))
        button.backgroundColor = UIColor(red: 230/255, green: 124/255, blue: 115/255, alpha: 1)
        button.setTitle("ログイン", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(SignInViewController.gogoNext(_:)), for: .touchUpInside)
        return button
    }()
    
    var NewButton:UIButton = {
        var button = UIButton(frame: CGRect(x: 100, y: UIScreen.main.bounds.height/3 + 100, width: 200, height: 50))
        button.backgroundColor = UIColor(red: 230/255, green: 124/255, blue: 115/255, alpha: 1)
        button.setTitle("戻る", for: .normal)
        button.setTitleColor(.white, for: .normal)
         button.addTarget(self, action: #selector(SignInViewController.goNext(_:)), for: .touchUpInside)
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
        self.signInMailTextField.delegate = self
        self.signInPassTextField.delegate = self
        view.addSubview(maillabel)
        self.signInPassTextField.borderStyle = .roundedRect
        view.addSubview(signInPassTextField)
        self.signInMailTextField.borderStyle = .roundedRect
        view.addSubview(signInMailTextField)
        view.addSubview(signInButton)
        view.addSubview(NewButton)
        view.addSubview(passlabel)
        
    }
    
    //前の画面に戻る
     @objc func goNext(_ sender:UIButton){
     self.dismiss(animated: true, completion: nil)
    }
    
    @objc func gogoNext(_ sender:UIButton){
       //メールアドレスとパスワードを確認してログインできるようにする
        let email = signInMailTextField.text ?? ""
        let passward = signInPassTextField.text ?? ""
        
        Auth.auth().signIn(withEmail: email + "@ed.ritsumei.ac.jp", password: passward) { [weak self] result, error in
            guard let self = self else {return}
            if (result?.user) != nil && result?.user.isEmailVerified == true {
                let nextvc = pickerProfileViewController()
                self.present(nextvc, animated: true, completion: nil)
            }
            self.showErrorIFNeeded(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let text = textField.text
        self.signInMailTextField.text = text
        self.signInPassTextField.text = text
        
        return true
    }
    
}

