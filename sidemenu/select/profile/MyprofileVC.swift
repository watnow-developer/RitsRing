//
//  ViewController.swift
//  addriri5
//
//  Created by 瀧頭　直斗 on 2019/08/10.
//  Copyright © 2019 瀧頭　直斗. All rights reserved.
//

import UIKit
import Firebase


class MyprofileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    var Ref: DatabaseReference?
    var UserID = Auth.auth().currentUser?.uid
    //section1の文字配列
    var rowtext:[String] = ["性別","学部","入学年度"]
    
    var displayname:String?
    var displaygender:String?
    var displayfaculty:String?
    var displaygrade:String?
    
    var textlabel:UILabel?
    
    var tableview:UITableView = {
        
        var tableview = UITableView()
        tableview = UITableView(frame: UIScreen.main.bounds, style: UITableView.Style.grouped)
        tableview.rowHeight = UIScreen.main.bounds.width/5
        
        return tableview
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        print(displayname ?? "false")
        
        LoadmyData()
        tableview.delegate = self
        tableview.dataSource = self
        view.addSubview(tableview)
        
    
        
        tableview.register(TextInputTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(TextInputTableViewCell.self))
        
        configureUI()
        // Do any additional setup after loading the view.

        
    }
    
    func LoadmyData(){
        
        Ref = Database.database().reference()
        //User/uid からデータの取得
        Ref?.child("User").child(UserID ?? "").observeSingleEvent(of: .value, with:{ (snapshot)  in
            
            var data = snapshot.value as? [String: AnyObject]
            self.displayname = data?["名前"] as? String
            self.displaygender = data?["性別"] as? String
            self.displayfaculty = data?["学部"] as? String
            self.displaygrade = data?["入学年度"] as? String
            print(data?.count ?? "nil")
            
            print(self.displayname as Any)
            print(self.displaygrade as Any)
            print(self.displayfaculty as Any)
            print(self.displaygender as Any)
            
            self.tableview.reloadData()
            
        })
        
    }

   


@objc func handleDismiss(){
    dismiss(animated: true, completion: nil)
}
    
    func configureUI(){
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(red: 230/255, green: 124/255, blue: 115/255, alpha: 1)
        navigationItem.title = "プロフィール"
        navigationController?.navigationBar.barStyle = .black
        //withRenderingMode(.alwaysOriginal)することによって元の色を保つ
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "backbutton").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleDismiss ))
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return("名前")
        case 1:
            return("性別")
        case 2:
            return("学部")
        default :
            return("入学年度")
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell =
            tableView.dequeueReusableCell(withIdentifier:NSStringFromClass(TextInputTableViewCell.self), for: indexPath) as? TextInputTableViewCell else {
            fatalError("The dequeued cell is not instance of MealTableViewCell.")
        }
        
        cell.TitleTextField.delegate = self
        cell.backgroundColor = UIColor(red: 255/255, green: 230/255, blue: 230/250, alpha: 0.5)
        textlabel?.textAlignment = .center
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text =  self.displayname
            case 1:
                cell.textLabel?.text = self.displaygender
            case 2:
                cell.textLabel?.text = self.displayfaculty
            default:
                cell.textLabel?.text = self.displaygrade
            }
        return cell
        }
    
    
    
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

