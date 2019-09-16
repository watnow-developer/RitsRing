//
//  genderSelectController.swift
//  sidemenu
//
//  Created by yu on 2019/08/10.
//  Copyright © 2019 yu. All rights reserved.


//以下gender selection を gs とする

import UIKit
import Firebase

class genderSelectController : UIViewController{
    
    var Ref = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    var flag:String?
    var count:Int?
   
    let controller = matchOkController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
         navigationController?.navigationBar.barTintColor = UIColor(red: 230/255, green: 124/255, blue: 115/255, alpha: 1)
        //ルームの数を確認
      
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let gs : UIAlertController = UIAlertController(title: "どっちとマッチする？", message:"選択してください" , preferredStyle:UIAlertController.Style.alert)
        
    //女性
        
        let womenAction : UIAlertAction = UIAlertAction(
            title: "女性",
            style: UIAlertAction.Style.default){
                action in
              
                self.present(UINavigationController(rootViewController: self.controller), animated: true, completion: nil)
                
    }
        
   
     
        let menAction : UIAlertAction = UIAlertAction(
            title: "男性",
            style: UIAlertAction.Style.default){
                action in
                
                self.present(UINavigationController(rootViewController: self.controller), animated: true, completion: nil)
        }

        gs.addAction(womenAction)
       gs.addAction(menAction)

        present(gs,animated:true , completion: nil)
        
    }
    
  
 
    
    
}
