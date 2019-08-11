//
//  HomeController.swift
//  sidemenu
//
//  Created by yu on 2019/08/03.
//  Copyright © 2019 yu. All rights reserved.
//


    //メイン画面
import UIKit

class HomeController: UIViewController {
    

    
    // Mark - Properties
    
    
    var delegate: HomeControllerDelegate?
    
    
    //Mark - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configureNavigationBar()

    }
    
    @objc func handleMenuToggle(){
        delegate?.handleMenuToggle(forMenuOption: nil) 
    }
    //Mark - Handlers
    func configureNavigationBar(){
        navigationController?.navigationBar.barTintColor = UIColor(red: 230/255, green: 124/255, blue: 115/255, alpha: 1)
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "RiRi"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "san icon") .withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
        
        
    }
}
