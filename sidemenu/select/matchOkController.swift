//
//  matchOkController.swift
//  sidemenu
//
//  Created by yu on 2019/08/10.
//  Copyright © 2019 yu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore

class matchOkController : UIViewController{
    
    var Ref = Database.database().reference()
    var db = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    var username:String? //名前
    var Roomjudge:Bool? // Closed Bool判定
    var getRoomID:String?//部屋の名前(親のuid)の取得
    var time:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(red: 230/255, green: 124/255, blue: 115/255, alpha: 1)
        navigationItem.title = "もう少しでお友達増えるよ！！o(^▽^)o"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 255/255, green: 0/255, blue: 85/255, alpha: 1)]
        
        self.db.collection("Users").document(userID ?? "").getDocument { (document, error) in
            if let document = document, document.exists {
                self.username = document.get("name") as? String
                print("Document data: \(self.username!)")
            } else {
                print("Document does not exist")
            }
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
    
    
    // TODO: test data
    let FROM_ID = "testId"
    func judgeFlag(){
        //User から自分名前を引っ張ってくる
                //waitRoom
            self.db.collection("waitRooms").whereField("Closed", isEqualTo: false).limit(to: 1).getDocuments() { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        self.Roomjudge = document.get("Closed") as? Bool
                        self.getRoomID = document.documentID
                        print(self.getRoomID!)
                        print(self.Roomjudge!)
                         if(self.Roomjudge == false){
                            //部屋に接続する
                            print("Succes")
                            self.joinRoom()
                            return
                         }
                    }
                   self.WaitRoom()
                }
        }
    }
    
    /*
    func createroom(fromId: String){
        //マッチしますかの画面へ
        
        let chatVc = chatController()
        chatVc.fromId = fromId
        self.present(UINavigationController(rootViewController: chatVc), animated: true, completion: nil)
    }
 */
    
    func WaitRoom(){
        print("名前は\(self.username ?? "error")")
        self.db.collection("Rooms").document(self.userID ?? "").setData(["ParentName": self.username!,"ChildName": "" ])
        //waitRoomsに募集してることを出す
        self.db.collection("waitRooms").document(self.userID!).setData(["Closed": false], merge: false)
        
    }

    func joinRoom(){
        self.db.collection("waitRooms").document(self.getRoomID!).setData(["Closed":true], merge: true)
        //接続した部屋のChildNameに自分の名前を入れる
        self.db.collection("Rooms").document(self.getRoomID!).setData(["ChildName":username!], merge: true)
        //waitsRoomsの削除
        self.db.collection("waitRooms").document(self.getRoomID!).delete()

    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    
}
