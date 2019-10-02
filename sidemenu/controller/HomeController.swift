//
//  HomeController.swift
//  sidemenu
//
//  Created by yu on 2019/08/03.
//  Copyright © 2019 yu. All rights reserved.
//


//メイン画面
import UIKit

class HomeController: UIViewController,UINavigationControllerDelegate{
    
    let image = UIImage(named:"click")!
    var screenWidth:CGFloat = 0
    var screenHeight:CGFloat = 0
    let clickbutton = UIButton()
    
    // Mark - Properties
    
    
    var delegate: HomeControllerDelegate?
    
    
    //Mark - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // イラストbutton
        screenWidth = view.frame.size.width
        screenHeight = view.frame.size.height
        clickbutton.frame = CGRect(x:0, y:180,
                                   width:screenWidth, height:screenWidth)
        
        button_init(button: clickbutton)
        self.view.addSubview(clickbutton)
        
        view.backgroundColor = UIColor(red: 254/255, green: 249/255, blue: 251/255, alpha: 1)
        
        //画面遷移
        
        clickbutton.addTarget(self, action: #selector(HomeController.click(_:)), for: .touchUpInside)
        
        view.addSubview(clickbutton)
    }
    
    func button_init(button:UIButton){
        clickbutton.setImage(image, for: .normal)
        
        
        // Aspect Fit
        button.imageView?.contentMode = .scaleAspectFit
        
        // Horizontal 拡大
        button.contentHorizontalAlignment = .fill
        
        // Vertical 拡大
        button.contentVerticalAlignment = .fill
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
    
    @objc func click(_ sender: UIButton) {
        let controller1 = matchOkController()
        self.present(controller1, animated: true, completion: nil)
        
    }
    
}
