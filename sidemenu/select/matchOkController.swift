//
//  matchOkController.swift
//  sidemenu
//
//  Created by yu on 2019/08/10.
//  Copyright © 2019 yu. All rights reserved.
//

import UIKit

class matchOkController : UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(red: 230/255, green: 124/255, blue: 115/255, alpha: 1)
        navigationItem.title = "もう少しでお友達増えるよ！！o(^▽^)o"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 255/255, green: 0/255, blue: 85/255, alpha: 1)]
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let matchAlert : UIAlertController = UIAlertController(title: "マッチしました", message: "トークをはじめますか？", preferredStyle: UIAlertController.Style.alert)
        
        let yesAction : UIAlertAction = UIAlertAction(title: "はい", style: UIAlertAction.Style.default){
            action in
            let ChatController = chatController()
            self.present(UINavigationController(rootViewController: ChatController),animated: true , completion: nil)
        }
        
        let noAction : UIAlertAction = UIAlertAction(title: "いいえ", style: UIAlertAction.Style.cancel){
            action in
            let noController = HomeController()
            self.present(UINavigationController(rootViewController: noController), animated: true, completion: nil)
        }
        
        matchAlert.addAction(yesAction)
        matchAlert.addAction(noAction)
        present(matchAlert, animated:true, completion: nil)
        
        
    }
    
}
