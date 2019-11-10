//
//  FailVC.swift
//  sidemenu
//
//  Created by yu on 2019/11/10.
//  Copyright © 2019 yu. All rights reserved.
//

import UIKit

class FailViewController:UIViewController
{
    let Squareimage = UIImageView()
    let Ohimage = UIImageView()
    let Failimage = UIImageView()
    let Failmessimage = UIImageView()
    let Nextsquare = UIButton()
    let image = UIImage(named:"nextsquare")!
    let Bluenext = UIImageView()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor =  UIColor(red: 130/255, green: 143/255, blue: 239/255, alpha: 1)
        
         
        squareimage()
        ohimage()
      failimage()
        failmessimage()
        nextsquare()
        bluenext()
    }
    
    private func ohimage(){
        
       Ohimage.image = UIImage(named:"oh")
        
        let screenW:CGFloat = view.frame.size.width
        let screenH:CGFloat = view.frame.size.height
        
       Ohimage.frame = CGRect(x:150/414, y:112/896, width:116, height:52)
       Ohimage.center = CGPoint(x:screenW/2, y:screenH/5)
        self.view.addSubview(Ohimage)
    }

    
    private func squareimage(){
        
        Squareimage.image = UIImage(named:"square")
        
        let screenW:CGFloat = view.frame.size.width
        let screenH:CGFloat = view.frame.size.height
        
        Squareimage.frame = CGRect(x:23/414, y:91/896, width:369, height:90)
        Squareimage.center = CGPoint(x:screenW/2, y:screenH/5)
        self.view.addSubview(Squareimage)
    }
    
    
    
    private func failimage(){
        
        Failimage.image = UIImage(named:"fail")
        
        let screenW:CGFloat = view.frame.size.width
        let screenH:CGFloat = view.frame.size.height
        
        Failimage.frame = CGRect(x:79/414, y:258/896, width:256, height:256)
        Failimage.center = CGPoint(x:screenW/2, y:screenH/2.1)
        self.view.addSubview(Failimage)
    }
    
    private func failmessimage(){
        
        Failmessimage.image = UIImage(named:"failmess")!
        
        let screenW:CGFloat = view.frame.size.width
        let screenH:CGFloat = view.frame.size.height
        
        Failmessimage.frame = CGRect(x:107/414, y:558/896, width:180, height:106)
        Failmessimage.center = CGPoint(x:screenW/2, y:screenH/1.3)
        self.view.addSubview(Failmessimage)
    }
    
    private func nextsquare(){
        
        let screenW:CGFloat = view.frame.size.width
        let screenH:CGFloat = view.frame.size.height
        
        Nextsquare.frame = CGRect(x:78/414, y:724/896, width:260, height:60)
        Nextsquare.center = CGPoint(x:screenW/2, y:screenH/1.2)
        self.view.addSubview(Nextsquare)
        

        Nextsquare.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
         Nextsquare.setImage(image, for: .normal)
               
    }
    private func bluenext(){
       Bluenext.image = UIImage(named:"bluenext")!
        
        let screenW:CGFloat = view.frame.size.width
        let screenH:CGFloat = view.frame.size.height
        
        Bluenext.frame = CGRect(x:107/414, y:718/896, width:201.49, height:43.93)
       Bluenext.center = CGPoint(x:screenW/2, y:screenH/1.2)
        self.view.addSubview(Bluenext)
        
    }

    @objc func backMain(){
        let NextController = ContainerController()
        self.present(NextController, animated: true ,completion: nil)
    }
    
    @objc func click(_ sender: UIButton) {
         let controller = ContainerController()
         self.present(controller, animated: true, completion: nil)
         
     }
     
    
}
