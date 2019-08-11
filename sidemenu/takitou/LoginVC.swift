//
//  ViewController.swift
//  riri
//
//  Created by 瀧頭　直斗 on 2019/07/02.
//  Copyright © 2019 瀧頭　直斗. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    

    var table: UITableView?
    
    var button:UIButton?
    
    let textsection:[String] = ["Mailadress","Passward"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
        
        let table = UITableView(frame:self.view.frame, style: UITableView.Style.grouped)
            table.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
            ]
            table.delegate = self
            table.dataSource = self
            table.estimatedRowHeight = 100
            table.rowHeight = 50
            self.view.addSubview(table)
        
        let button:UIButton = UIButton(frame: CGRect(x: self.view.frame.width/4, y: 300, width: 200, height: 50))
            button.backgroundColor = UIColor(red: 230/255, green: 124/255, blue: 115/255, alpha: 1)
            button.setTitle("新規登録", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 20
            self.view.addSubview(button)
            button.addTarget(self, action: #selector(ViewController.goNext(_:)), for: .touchUpInside)
            view.addSubview(button)
       
        
        }
    
    @objc func goNext(_ sender:UIButton){
        let nextvc = NextViewController()
        nextvc.view.backgroundColor = .white
        self.present(nextvc, animated: true, completion: nil)
    }
    
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
    }
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return textsection[section]
    }
    //保留
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell:UITableViewCell = UITableViewCell()
        cell.backgroundColor = UIColor(red: 255/255, green: 230/255, blue: 230/250, alpha: 0.5)
        cell.layer.cornerRadius = 10
        cell.textLabel?.text = "textfieldを入れる"
        return cell
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}



