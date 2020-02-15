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
    let db = Firestore.firestore()
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
    
        /*
        let ramdomchat = self.db.collection("RamdomChat").document(self.userID ?? "")
        ramdomchat.setData(["temp":"1"])
        ramdomchat.updateData(["temp":FieldValue.delete()])
        */
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        let matchAlert : UIAlertController = UIAlertController(title: "相手を探しますか", message: "マッチできない場合は５秒後に戻ります", preferredStyle: UIAlertController.Style.alert)
        //「はい」をに押した時の処理
        let yesAction : UIAlertAction = UIAlertAction(title: "はい", style: UIAlertAction.Style.default){
            action in
            
            //インジケータの開始の宣言
            
            self.activityIndicatorView.startAnimating()
            self.db.collection("ActiveUser").document(self.userID ?? "").updateData(["temp":"1"])
            self.listenStart()
            
            DispatchQueue.main.asyncAfter(deadline: .now()+5){
                //終わると同時に済ませる処理を書く
                self.activityIndicatorView.stopAnimating()
            }
        
        }
        //「いいえ」を押した時の処理
        let noAction : UIAlertAction = UIAlertAction(title: "いいえ", style: UIAlertAction.Style.cancel){
            action in
            let contoroller = HomeController()
            self.present(UINavigationController(rootViewController: contoroller),animated: true,completion:  nil)
            }
        
        matchAlert.addAction(yesAction)
        matchAlert.addAction(noAction)
        present(matchAlert, animated:true, completion: nil)
        
    }
    
    func listenStart(){
        let listener = db.collection("ActiveUser").whereField("temp", isEqualTo: "1")
            .addSnapshotListener { querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    print("Error fetching snapshots: \(error!)")
                    return
                }
                
                snapshot.documentChanges.forEach { diff in
                    if (diff.type == .added) {
                        let on_userID = diff.document.documentID
                        print("New User: \(on_userID)")
                        //自分と違うUIDだけを取ってくる
                        if(diff.document.documentID != self.userID){
                        self.CheckOnline(on_userID: on_userID)
                        }
                    }
                    
                    if (diff.type == .removed) {
                        print("Removed city: \(diff.document.documentID)")
                    }
                   
                }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+5){
            listener.remove()
            print("listenがデパッチされました")
            let ActiveUser = self.db.collection("ActiveUser").document(self.userID!)
            ActiveUser.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.get("temp") as? String
                    if(dataDescription == "1"){
                       ActiveUser.updateData(["temp":FieldValue.delete()])
                        self.non_onlinAlert()
                    }
                }else{
                    self.non_onlinAlert()
                }
            }
            
        }
        
    }
  //tempの値が"1"なのかを判断する関数
    func CheckOnline(on_userID:String){
        let ActiveUser = self.db.collection("ActiveUser").document(on_userID)
        ActiveUser.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.get("temp") as? String
                print("tempの値は\(dataDescription ?? "NULL")")
                if(dataDescription == "1"){
                    print("ユーザ\(on_userID)はオンラインです")
                    self.SetPareuid(on_userID: on_userID)
                    self.CheckPareUser(on_userID: on_userID)
                }else{
                    print("ユーザ\(on_userID)はオフラインです")
                    //もう一度マッチングさせる
                    self.non_onlinAlert()
                }
            } else {
                print("Document does not exist")
                self.non_onlinAlert()
            }
        }

    }
    
    // RamdomChat/自分のUID/のフィールドの値にマッチングした相手のUIDを入れる
    func SetPareuid(on_userID:String){
        let RamdomChat = self.db.collection("RamdomChat").document(self.userID!)
        RamdomChat.setData(["pare":on_userID])
        print("\(self.userID!)に相手のUID\(on_userID)をセットしました")
    }
    
    // RomdomChat/マッチングした相手のUID/　に存在するUIDが自分のUIDと同じなのか判定する
    func CheckPareUser(on_userID:String){
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            let RamdomChat = self.db.collection("RamdomChat").document(on_userID)
            RamdomChat.getDocument{(document,error) in
                if let document = document, document.exists {
                    let data = document.get("pare") as? String
                    if(data == self.userID){
                        print("相手(\(on_userID))とマッチングしたので、部屋に移ります")
                        let ActiveUser = self.db.collection("ActiveUser").document(self.userID!)
                        ActiveUser.updateData(["temp":FieldValue.delete()])
                        let ChatController = chatController()
                        self.activityIndicatorView.stopAnimating()
                        self.present(UINavigationController(rootViewController: ChatController),animated: true , completion: nil)
                    }else{
                        print("マッチングに失敗しました")
                        let ActiveUser = self.db.collection("ActiveUser").document(self.userID!)
                        let RamdomChat = self.db.collection("RamdomChat").document(self.userID!)
                        RamdomChat.updateData(["pare":FieldValue.delete()])
                        ActiveUser.updateData(["temp":FieldValue.delete()])
                        self.faultAlert()
                    }
                }else{
                    // RomdomChat/マッチングした相手のUID/　に存在するUIDが自分と違う場合の処理
                    print("マッチングに失敗しました")
                    let ActiveUser = self.db.collection("ActiveUser").document(self.userID!)
                    let RamdomChat = self.db.collection("RamdomChat").document(self.userID!)
                    RamdomChat.updateData(["pare":FieldValue.delete()])
                    ActiveUser.updateData(["temp":FieldValue.delete()])
                    self.faultAlert()
                }
            }
        }
    }
    
    func faultAlert(){
        let title = "マッチングできませんでした"
        let button = "OK"
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let push_button = UIAlertAction(title: button, style: .cancel){
            action in
            let contoroller = HomeController()
            self.present(UINavigationController(rootViewController: contoroller),animated: true,completion:  nil)
        }
        alert.addAction(push_button)
        
        present(alert,animated: true,completion: nil)
    }
    
    func non_onlinAlert(){
        let title = "オンラインの人がいませんでした"
        let message = "時間を置いて、試してください"
        let button = "OK"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let push_button: UIAlertAction = UIAlertAction(title: button, style: .cancel){
            action in
            let contoroller = HomeController()
            self.present(UINavigationController(rootViewController: contoroller),animated: true,completion:  nil)
        }
        alert.addAction(push_button)
        
        present(alert,animated: true,completion: nil)
    }
    
  
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    
    
}
