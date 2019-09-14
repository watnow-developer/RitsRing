//
//  talkController.swift
//  sidemenu
//
//  Created by yu on 2019/09/14.
//  Copyright © 2019 yu. All rights reserved.
//



//import UIKit
//import Firebase
//
//
//class CustomView: UIView {
//
//
//    override var intrinsicContentSize: CGSize {
//        return CGSize.zero
//    }
//}
//
//class talkController : UITableViewController, UITextFieldDelegate{
//
//
//
//
//    var fromId: String?
//    var messagetext: String?
//    var timestamp: NSNumber?
//    var toId: String?
//
//
//    //送信textfield
//    lazy var  textField: UITextField = {
//
//        let tf = UITextField()
//        tf.placeholder = "Enter message"
//        tf.backgroundColor = .white
//        tf.borderStyle = .roundedRect
//        tf.translatesAutoresizingMaskIntoConstraints = false
//        tf.delegate = self
//        return tf
//    }()
//
// var databaseRef: DatabaseReference!
//     fileprivate let cellId = "id123"
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        databaseRef = Database.database().reference()
//
//        //Navigation Controller setting
//        navigationItem.title = "RiRi Chat"// すでにフレンドなのか、あたらしい
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.barTintColor = UIColor(red: 230/255, green: 124/255, blue: 115/255, alpha: 1)
//        navigationController?.navigationBar.barStyle = .black
//
//        //tableView setting
//        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
//        tableView.separatorStyle = .none
//        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
//
//        configureUI()
//        observeMessages()
//}
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 50
//    }
//
//
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return  50
//}
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return talk.count
//     
//    }
//    
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
//        
//        
//        
//        let message = talk[indexPath.row]
//        cell.textLabel?.text = message.messagetext
//        return cell
//    }
//
//    //入力欄（キーボード）
//
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//    }
//
//
//    override var inputAccessoryView: UIView? {
//        return inputContainerView
//    }
//
//    override var canBecomeFirstResponder : Bool {
//        return true
//    }
//
//
//
//
//    lazy var inputContainerView: UIView = {
//
//        let containerView = CustomView()
//        containerView.backgroundColor = UIColor(red: 230/255, green: 124/255, blue: 115/255, alpha: 1)
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//
//        containerView.addSubview(textField)
//
//        self.textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
//        self.textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
//
//        self.textField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -50).isActive = true
//
//        // layoutMarginsGuide.bottomAnchorに対して制約を付ける
//        self.textField.bottomAnchor.constraint(equalTo: containerView.layoutMarginsGuide.bottomAnchor, constant: -8).isActive = true
//
//        //送信ボタン
//        let barButton: UIButton = UIButton(type: UIButton.ButtonType.system)
//        barButton.setTitle("送信", for: UIControl.State.normal)
//
//        barButton.addTarget(self, action: #selector(buttonEvent), for: .touchUpInside)
//
//        containerView.addSubview(barButton)
//        barButton.translatesAutoresizingMaskIntoConstraints = false
//        barButton.tintColor = UIColor.white
//        //位置情報（送信ボタン）
//        barButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: +10).isActive = true
//
//        barButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -15).isActive = true
//
//        barButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
//        barButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
//
//
//
//        let separatorLineView = UIView()
//        separatorLineView.backgroundColor = .white
//        separatorLineView.translatesAutoresizingMaskIntoConstraints = false
//        containerView.addSubview(separatorLineView)
//
//        separatorLineView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
//        separatorLineView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
//        separatorLineView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
//        separatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
//        self.textField.topAnchor.constraint(equalTo: separatorLineView.bottomAnchor, constant: 8).isActive = true
//
//        return containerView
//
//
//    }()
//
//    //送信した時の処理
//
//    @objc func buttonEvent(){
//
//        let ref = Database.database().reference().child("Chat")
//        let childRef = ref.childByAutoId()
//     //   let toId = userID!
//        let fromId = Auth.auth().currentUser!.uid
//        let timestamp = NSDate().timeIntervalSince1970
//        let values = ["message" : textField.text!, /*"toID" : toId ,*/ "fromID" : fromId, "time stamp" : timestamp] as [String : Any]
//
//        childRef.updateChildValues(values)
//
// 
//    }
//    var talk = [talkController]()
//    
//    func observeMessages(){
//        let ref = Database.database().reference().child("Chat")
//        ref.observe(.childAdded, with: { (snapshot) in
//            
//            if let dictionary = snapshot.value as? [String: AnyObject]{
//                
//                self.messagetext = dictionary["message"] as? String
//                self.toId = dictionary["toID"] as? String
//                self.fromId = dictionary["fromID"] as? String
//                self.timestamp = dictionary["time stamp"] as? NSNumber
//                
//          //   let talkdata = Talkdata()
//                //                message.setValuesForKeys(dictionary)
//                //                print(message.message as Any)
//                
//                print(self.toId as Any)
//               
//                print(self.messagetext as Any)
//                
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//                
//            }
//            
//            
//        }, withCancel: nil)
//        
//    }
//    
//
//    //次に行く動作
//    @objc func backMain(){
//        let NextController44 = SelectFriendViewController()
//        self.present(NextController44, animated: true ,completion: nil)
//    }
//
//
//
//
//    func configureUI(){
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "backbutton").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backMain ))
//
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        buttonEvent()
//        return true
//    }
//
//
//}
