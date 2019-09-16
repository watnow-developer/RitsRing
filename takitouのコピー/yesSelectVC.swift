//
//  yesselected.swift
//  add2_riri
//
//  Created by 瀧頭　直斗 on 2019/07/15.
//  Copyright © 2019 瀧頭　直斗. All rights reserved.
//

import UIKit
import Firebase

class yesselectedview: UIViewController {
    
    var Ref = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    var flag:String?
    var count:Int?
    
    let yeslabel: UILabel = {
        let view = UILabel()
        view.frame.size = CGSize(width: 500, height: 100)
        view.textAlignment = .center
        view.center.x = view.center.x
        view.center = CGPoint(x: 200, y: 200)
        view.text = "フレンド成立"
        return view
        
    }()
    
    
    let namelabel: UITextField = {
        let view = UITextField()
        view.frame.size = CGSize(width: 200, height: 70)
        view.placeholder = "名前"
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor(red: 255/255, green: 230/255, blue: 230/255, alpha: 0.5)
        view.center.x = view.center.x
        view.center = CGPoint(x: 200, y: 550)
        return view
        
    }()
    
    
    let gobutton:UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 230/255, green: 124/255, blue: 115/255, alpha: 1)
        button.setTitle("GO", for: .normal)
        button.center = CGPoint(x: 70, y: 600)
        button.frame.size = CGSize(width:100, height: 70)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(yesselectedview.GONext(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc func GONext(_ sender:UIButton){
        let GScontroller = friendlistController()
        self.present(UINavigationController(rootViewController: GScontroller), animated: true ,completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        yeslabel.font = .systemFont(ofSize: 30)
        view.addSubview(yeslabel)
        
        view.addSubview(namelabel)
        
        gobutton.center.x = self.view.center.x
        view.addSubview(gobutton)
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
        self.Ref.child("User").child(userID ?? "").updateChildValues(["RoomIn":"RoomName" + "\(self.count!-1)"])
        //マッチしますかの画面へ
        self.present(UINavigationController(rootViewController: matchOkController()), animated: true, completion: nil)
        
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
                self.present(UINavigationController(rootViewController: matchOkController()), animated: true, completion: nil)
                
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
 
