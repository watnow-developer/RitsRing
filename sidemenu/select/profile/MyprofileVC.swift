//
//  ViewController.swift
//  addriri5
//
//  Created by 瀧頭　直斗 on 2019/08/10.
//  Copyright © 2019 瀧頭　直斗. All rights reserved.
//

import UIKit

class MyprofileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    
    //section1の文字配列
    let rowtext:[String] = ["性別","学部", "入学年度"]
    
    var tableview:UITableView = {
        
        var tableview = UITableView()
        tableview = UITableView(frame: UIScreen.main.bounds, style: UITableView.Style.grouped)
        tableview.rowHeight = UIScreen.main.bounds.width/5
        
        return tableview
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        view.addSubview(tableview)
        
    
        
        tableview.register(TextInputTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(TextInputTableViewCell.self))
        
        configureUI()
        // Do any additional setup after loading the view.
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0 ){
            return ("プロフィール")
        }else{
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        }else{
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier:NSStringFromClass(TextInputTableViewCell.self), for: indexPath) as? TextInputTableViewCell else {
            fatalError("The dequeued cell is not instance of MealTableViewCell.")
        }
        
        cell.TitleTextField.delegate = self
        cell.backgroundColor = UIColor(red: 255/255, green: 230/255, blue: 230/250, alpha: 0.5)
        
        switch indexPath.section {
        case 0:
            cell.TitleTextField.placeholder = "名前を入力"
            
        default:
            cell.textLabel?.text = rowtext[indexPath.row]
            
        }
        return cell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

