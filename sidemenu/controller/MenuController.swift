//
//  MenuController.swift
//  sidemenu
//
//  Created by yu on 2019/08/03.
//  Copyright © 2019 yu. All rights reserved.
//



    //サイドメニュー（左）
import UIKit

class MenuController: UIViewController {
    
 
    
    private let reuseIdenifer = "MenuOptionCell"
    
    
    // Mark - Properties
    
    var tableView: UITableView!
    var delegate: HomeControllerDelegate?
    
    //Mark - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }

    //Mark - Handlers
    
    func configureTableView(){
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MenuOptionCell.self  , forCellReuseIdentifier: reuseIdenifer)
        tableView.backgroundColor = UIColor(red: 230/255, green: 124/255, blue: 115/255, alpha: 1)
        tableView.separatorStyle = .none
        //サイドメニュー列高さ
        tableView.rowHeight = 80
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
}

extension MenuController: UITableViewDelegate, UITableViewDataSource{
    
    //メニューの列が3つ
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdenifer, for: indexPath) as!
        MenuOptionCell
        
        let menuOption = MenuOption(rawValue: indexPath.row)
        cell.descriptionLabel.text = menuOption?.description
        cell.iconImageView.image = menuOption?.image
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuOption = MenuOption(rawValue: indexPath.row)
        delegate?.handleMenuToggle(forMenuOption: menuOption)
    }
    
    
}
