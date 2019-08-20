//
//  friendlistController.swift
//  sidemenu
//
//  Created by yu on 2019/08/08.
//  Copyright © 2019 yu. All rights reserved.
//

import UIKit


let sectionTitle = ["Online","Offline"]
let section0 = ["username1","username2","username3"]
let section1 = ["username A" , "username B", "username C"]
let tableData = [section0,section1]


class friendlistController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //セクション数を返す
    func numberOfSections(in tableView: UITableView) -> Int{
        return sectionTitle.count
    }
    
    
    
    
    
    //セクションタイトルを返す
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return sectionTitle[section]
    }

    //セクションごとの行数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionData = tableData[section]
        return sectionData.count
    }
    
    
        
    
    //各行に表示するセルを返す
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
       
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let sectionData = tableData[(indexPath as NSIndexPath).section]
        let cellData    = sectionData[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = cellData
        cell.accessoryType = UITableViewCell.AccessoryType.detailButton
        

        return cell
    }
    
   func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    let controller = ViewController()
    present(UINavigationController(rootViewController: controller),animated: true , completion: nil)
 }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*online か offline かチェック
            */
        //cell タップ
        if(indexPath.section == 0 ){
            let controller0 = friendchatController()
            self.present(UINavigationController(rootViewController: controller0), animated: true ,completion: nil)
        }else if(indexPath.section == 1){
            let controller1 = talkUnableController()
            self.present(UINavigationController(rootViewController: controller1), animated: true ,completion: nil)

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myTableView :UITableView!
        myTableView = UITableView(frame: view.frame, style: .grouped)

        myTableView.delegate = self
        myTableView.dataSource = self
        view.addSubview(myTableView)
        myTableView.rowHeight = 50
        
        configureUI()
        
    }
    //Selectors
    @objc func backMain(){
        let NextController = ContainerController()
        self.present(NextController, animated: true ,completion: nil)
    }
    
    
    
 //navigation bar
    
    func configureUI(){
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(red: 230/255, green: 124/255, blue: 115/255, alpha: 1)
        navigationItem.title = "Friend List"
        navigationController?.navigationBar.barStyle = .black
        
        //withRenderingMode(.alwaysOriginal)することによって元の色を保つ
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "backbutton").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backMain ))
        
    }
    
}
