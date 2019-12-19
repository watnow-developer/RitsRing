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
    var pare_user:String!
    var time:Timer?
    var flag:Int = 1
    
    var activityIndicatorView:UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.center = CGPoint(x: UIScreen.main.bounds.width/2 , y: UIScreen.main.bounds.height/2)
        indicator.style = .whiteLarge
        indicator.color = .black
        return indicator
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(red: 230/255, green: 124/255, blue: 115/255, alpha: 1)
        navigationItem.title = "もう少しでお友達増えるよ！！o(^▽^)o"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 255/255, green: 0/255, blue: 85/255, alpha: 1)]
        
        view.addSubview(activityIndicatorView)
    
        
        let ramdomchat = self.db.collection("RamdomChat").document(self.userID ?? "")
        ramdomchat.setData(["temp":"1"])
        ramdomchat.updateData(["temp":FieldValue.delete()])
        
        let user_ref = self.db.collection("Users").document(userID ?? "")
        
        user_ref.getDocument { (document, error) in
            if let document = document, document.exists {
                self.username = document.get("name") as? String
                print("Document data: \(self.username!)")
            } else {
                print("Document does not exist")
            }
        }
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        let matchAlert : UIAlertController = UIAlertController(title: "相手を探しますか", message: "マッチできない場合は５秒後に戻ります", preferredStyle: UIAlertController.Style.alert)
        //「はい」をに押した時の処理
        let yesAction : UIAlertAction = UIAlertAction(title: "はい", style: UIAlertAction.Style.default){
            action in
            
            
            let active_user = self.db.collection("ActiveUser")
            active_user.document(self.userID ?? "").setData(["temp":"1"])
            
            //インジケータの開始の宣言
            
            self.activityIndicatorView.startAnimating()
             self.JudgeActiveUser()
            
            DispatchQueue.global(qos: .default).async {
                // 非同期処理などを実行（今回は５秒間待つだけ）
                Thread.sleep(forTimeInterval: 3)
      
                // 非同期処理などが終了したらメインスレッドでアニメーション終了
                DispatchQueue.main.async {
                    // アニメーション終了
                     self.db.collection("ActiveUser").document(self.userID ?? "").updateData(["temp":FieldValue.delete()])
                     self.db.collection("RomdomChat").document(self.userID ?? "").updateData(["temp":FieldValue.delete()])
                     self.flag = 0
                    
                    //終わると同時に済ませる処理を書く
                    self.activityIndicatorView.stopAnimating()
                    
                }
                
            }
            
            
            //let ChatController = chatController()
            // self.present(UINavigationController(rootViewController: ChatController),animated: true , completion: nil)
        }
        //「いいえ」を押した時の処理
        let noAction : UIAlertAction = UIAlertAction(title: "いいえ", style: UIAlertAction.Style.cancel){
            action in
            }
        
        matchAlert.addAction(yesAction)
        matchAlert.addAction(noAction)
        present(matchAlert, animated:true, completion: nil)
        
    }
    
    
    func JudgeActiveUser(){
        let active_user = self.db.collection("ActiveUser")
        active_user.whereField("temp", isEqualTo: "1").getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    //自分と違うuid を一つとってくる
                    if(self.userID != document.documentID){
                        self.pare_user = document.documentID
                        self.RecivedUid(recived_uid: self.pare_user)
                        print("相手のducumentIDは\(self.pare_user!)")
                        return
                    }
                }
            }
            print("オンライン状態ではない")
            if(self.flag == 0){
                print("na")
                return
            }
                self.JudgeActiveUser()
        }
    }
    
    
    
    func RecivedUid(recived_uid:String){
        let ramdomchat = self.db.collection("RamdomChat")
        ramdomchat.document(userID ?? "").setData(["recivedUID":recived_uid]) //自分のRamdomChatに取ってきた相手のUIDを入れる
        //JudgeActiveUserで取ってきたUIDを参照し、相手に入ってるUIDが自分のUIDであるかを判定する
        ramdomchat.document(recived_uid).getDocument{(document, error) in
            if let document = document, document.exists {
                let pare_uid = document.get("recieveUID")
                print("Document dat: \(pare_uid!)")
                self.CreateRoom(recived_uid:pare_uid as! String)
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func CreateRoom(recived_uid:String){
        if(recived_uid == userID){
            let active_user = self.db.collection("ActiveUser").document(userID ?? "")
            active_user.updateData(["temp":FieldValue.delete()])
            self.activityIndicatorView.stopAnimating()
            print("相手とマッチングしたので、トークルームへ移動します")
        }else{
            //JudgeActiveUserの関数へ戻りループ
            print("マッチングに失敗")
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
