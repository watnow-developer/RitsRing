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
    
//    let image = UIImage(named:"click")!
    var screenWidth:CGFloat = 0
    var screenHeight:CGFloat = 0
    let Ritsringhome = UIImageView()
    let Squarebox = UIButton()
    let Squareboxbutton = UIImage(named:"squarebox")!
    let  Matchfriendimage = UIImageView()
//    let clickbutton = UIButton()
    
    // Mark - Properties
    
    
    var delegate: HomeControllerDelegate?
    
    
    //Mark - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    ritsringhome()
        squarebox()
matchfriendimage()
         
      view.backgroundColor =  UIColor(red: 230/255, green: 124/255, blue: 115/255, alpha: 1)
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "san icon") .withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
   
        
        
    }
    
   private func ritsringhome(){
        Ritsringhome.image = UIImage(named:"ritsringhome")!
        
        let screenW:CGFloat = view.frame.size.width
        let screenH:CGFloat = view.frame.size.height
        
    Ritsringhome.frame = CGRect(x:30.5/414, y:236.5/896, width:354, height:102)
       Ritsringhome.center = CGPoint(x:screenW/2, y:screenH/4)
        self.view.addSubview(Ritsringhome)
    }
    private func squarebox(){
           
           let screenW:CGFloat = view.frame.size.width
           let screenH:CGFloat = view.frame.size.height
           
           Squarebox.frame = CGRect(x:48.12/414, y:415.57/896, width:321.38, height:272.05)
        Squarebox.center = CGPoint(x:screenW/2, y:screenH/1.8)
           self.view.addSubview(Squarebox)
           

          Squarebox.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
           Squarebox.setImage(Squareboxbutton, for: .normal)
                  
       }
       private func matchfriendimage(){
         Matchfriendimage.image = UIImage(named:"matchfriend-1")!
           
           let screenW:CGFloat = view.frame.size.width
           let screenH:CGFloat = view.frame.size.height
           
         Matchfriendimage.frame = CGRect(x:48/414, y:432/896, width:319, height:239.78)
        Matchfriendimage.center = CGPoint(x:screenW/2, y:screenH/1.8)
           self.view.addSubview(Matchfriendimage)
           
       }

    
    
    
    @objc func click(_ sender: UIButton) {
        let controller1 = matchOkController()
        self.present(controller1, animated: true, completion: nil)
        
    }
    
    
}
