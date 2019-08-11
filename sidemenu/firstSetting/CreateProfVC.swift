//
//  ViewController.swift
//  addriri
//
//  Created by 瀧頭　直斗 on 2019/07/09.
//  Copyright © 2019 瀧頭　直斗. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let profilelabel:UILabel = UILabel(frame:CGRect(x: 10, y: 200, width: 200, height: 100))
        profilelabel.textAlignment = .center
        profilelabel.center.x = self.view.center.x
        profilelabel.font = .systemFont(ofSize: 40)
        profilelabel.textColor = .init(red: 255/255, green: 100/255, blue: 100/255, alpha: 1)
        profilelabel.text = "Profile"
        self.view.addSubview(profilelabel)
        
        
        let UserView:UIImageView = UIImageView(image: UIImage(named: "yjimage"))
        UserView.frame = CGRect(x: 100, y: 300, width:200, height: 200)
        UserView.center.x = self.view.center.x
        UserView.layer.cornerRadius = 20
        UserView.clipsToBounds = true
        self.view.addSubview(UserView)
        
        
        
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
        //gobutton.addTarget(self, action: #selector(ViewController.tapbutton(_ :)), for: .touchUpInside)
      
        
        
        let warninglabel:UILabel = UILabel(frame:CGRect(x: 0, y: 800, width: self.view.frame.width, height: 50))
        warninglabel.text = "※フレンドにのみ表示されます"
        warninglabel.textAlignment = .center
        self.view.addSubview(warninglabel)
        
        // Do any additional setup after loading the view.
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

