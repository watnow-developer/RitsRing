//
//  ViewController.swift
//  addriri4
//
//  Created by 瀧頭　直斗 on 2019/08/10.
//  Copyright © 2019 瀧頭　直斗. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    //section1の文字配列
    let rowtext:[String] = ["性別","学部", "学科", "入学年度"]
    
    var tableview:UITableView = {
        
        var tableview = UITableView()
        tableview = UITableView(frame: UIScreen.main.bounds, style: UITableView.Style.grouped)
        tableview.rowHeight = UIScreen.main.bounds.width/5
        
        return tableview
    }()
    //画像
    var headerview:UIImageView = {
        
        var headerview = UIImageView()
        let imageview = UIImage(named: "people")
        let screenwidth = UIScreen.main.bounds.width/4
        let screenheight = UIScreen.main.bounds.width/4
        headerview = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width/7*5, y: screenheight, width: screenwidth, height: screenwidth))
        headerview.image = imageview
        headerview.layer.cornerRadius = 20
        headerview.clipsToBounds = true
        
        return headerview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        view.addSubview(tableview)
        
        view.addSubview(headerview)
        
        
        // Do any additional setup after loading the view.
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
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      let cell = UITableViewCell()
        
        cell.backgroundColor = UIColor(red: 255/255, green: 230/255, blue: 230/250, alpha: 0.5)
        
        switch indexPath.section {
        case 0:
            
            break
            
        default:
            cell.textLabel?.text = rowtext[indexPath.row]
            
        }
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

