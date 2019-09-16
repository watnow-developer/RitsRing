//
//  matchOkController.swift
//  sidemenu
//
//  Created by yu on 2019/08/10.
//  Copyright © 2019 yu. All rights reserved.
//

import UIKit
import Firebase

class matchOkController : UIViewController{
    
    var Ref = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    var flag:String?
    var count:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(red: 230/255, green: 124/255, blue: 115/255, alpha: 1)
        navigationItem.title = "もう少しでお友達増えるよ！！o(^▽^)o"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 255/255, green: 0/255, blue: 85/255, alpha: 1)]
        
        self.Ref.child("Rooms").observeSingleEvent(of: .value) { (snapshot) in
            let data = snapshot.value as! [String:AnyObject]
            self.count = data.count
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let matchAlert : UIAlertController = UIAlertController(title: "マッチしました", message: "トークをはじめますか？", preferredStyle: UIAlertController.Style.alert)
        
        let yesAction : UIAlertAction = UIAlertAction(title: "はい", style: UIAlertAction.Style.default){
            action in
            self.judgeFlag()
            
            //let ChatController = chatController()
           // self.present(UINavigationController(rootViewController: ChatController),animated: true , completion: nil)
        }
        
        let noAction : UIAlertAction = UIAlertAction(title: "いいえ", style: UIAlertAction.Style.cancel){
            action in
            let NextController = ContainerController()
            self.present(NextController, animated: true ,completion: nil)
        }
        
        matchAlert.addAction(yesAction)
        matchAlert.addAction(noAction)
        present(matchAlert, animated:true, completion: nil)
        
        
    }
    
    
    func judgeFlag(){
        self.Ref.child("Flag").observeSingleEvent(of: .value, with: {(snapshot) in
            
            var data = snapshot.value as! [String:AnyObject]
            self.flag = data["flag"] as? String
            
            
            print(self.flag ?? "error")
            
            
            if(self.flag == "0"){
                //ルームに接続した側
                self.CheckRoom()
            }else if(self.flag == "1"){
                //ルームを作成した側
                self.createroom()
                
            }
            
            
            
        })
    }
    
    
    //flag = 1 の時
    func createroom(){
        //名前を読み取りParentNameに入れる
        self.Ref.child("User").child(self.userID ?? "").observeSingleEvent(of: .value, with: {(snapshot_1)  in
            var data = snapshot_1.value as! [String:AnyObject]
            let name = data["name"] as? String
            self.Ref.child("Rooms").child("RoomName" + "\(self.count!)").updateChildValues(["ParentName":name ?? "","ChildName":"name"])
        })
        //flagが1から0に変えた
        self.Ref.child("Flag").updateChildValues(["flag":"0"])
        //ルームを作成しさらにもう一個作る
        // self.Ref.child("Rooms").child("RoomName" + "\(self.count!+1)").updateChildValues(["ParentName":"name","ChildName":"name"])
        //自分のRoomInに自分の所属しているルームを入れる
        self.Ref.child("User").child(userID ?? "").updateChildValues(["RoomIn":"RoomName" + "\(self.count!)"])
        //マッチしますかの画面へ
        print("done")
        self.present(UINavigationController(rootViewController: chatController()), animated: true, completion: nil)
        
    }
    
    //flag = 0 の時
    func CheckRoom(){
        self.Ref.child("Rooms").child("RoomName" +  "\(self.count!-1)").observeSingleEvent(of: .value, with: {(snapshot) in
            var data = snapshot.value as! [String:AnyObject]
            let childname = data["ChildName"] as? String
            
            print("childname is" + "\(String(describing: childname))")
            //RoomNameのChildNameが"name"の時そこに名前を入れ、ペアになる
            if(childname == "name"){
                //接続側の名前を取得
                self.Ref.child("User").child(self.userID ?? "").observeSingleEvent(of: .value, with: {snapshot in
                    var data = snapshot.value as! [String:AnyObject]
                    let name = data["name"] as? String
                    //ChildNameに名前を追加
                    self.Ref.child("Rooms").child("RoomName" + "\(self.count!-1)").updateChildValues(["ChildName":name ?? ""])
                })
                //自分のRoomInに所属しているルームを確認する
                self.Ref.child("User").child(self.userID ?? "").updateChildValues(["RoomIn":"RoomName" + "\(self.count!-1)"])
                //マッチしますか　のが画面へ
                self.present(UINavigationController(rootViewController: chatController()), animated: true, completion: nil)
                
            }else if (childname != "name"){
                print("error")
                let nextvc = noselectedview()
                self.present(nextvc, animated: true,completion: nil)
            }
            
        })
        //flagのが数を１に変化
        self.Ref.child("Flag").updateChildValues(["flag":"1"])
        
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    
    
    
}
