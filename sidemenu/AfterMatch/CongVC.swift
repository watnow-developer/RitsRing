//
//  CongVC.swift
//  sidemenu
//
//  Created by yu on 2019/11/07.
//  Copyright © 2019 yu. All rights reserved.

import UIKit

class CongViewController:UIViewController
{
    let Squareimage = UIImageView()
    let Congratulation = UIImageView()
    let Coupleimage = UIImageView()
    let Omeimage = UIImageView()
    let Nextsquare = UIButton()
    let image = UIImage(named:"nextsquare")!
    let Rednext = UIImageView()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor =  UIColor(red: 230/255, green: 124/255, blue: 115/255, alpha: 1)
        
         
        squareimage()
        congratulation()
        coupleimage()
        omeimage()
        nextsquare()
        rednext()
    }
    
    private func congratulation(){
        
        Congratulation.image = UIImage(named:"congratulation")
        
        let screenW:CGFloat = view.frame.size.width
        let screenH:CGFloat = view.frame.size.height
        
        Congratulation.frame = CGRect(x:25/414, y:112/896, width:366, height:52)
        Congratulation.center = CGPoint(x:screenW/2, y:screenH/5)
        self.view.addSubview(Congratulation)
    }

    
    private func squareimage(){
        
        Squareimage.image = UIImage(named:"square")
        
        let screenW:CGFloat = view.frame.size.width
        let screenH:CGFloat = view.frame.size.height
        
        Squareimage.frame = CGRect(x:23/414, y:91/896, width:369, height:90)
        Squareimage.center = CGPoint(x:screenW/2, y:screenH/5)
        self.view.addSubview(Squareimage)
    }
    
    
    
    private func coupleimage(){
        
        Coupleimage.image = UIImage(named:"Cong")
        
        let screenW:CGFloat = view.frame.size.width
        let screenH:CGFloat = view.frame.size.height
        
        Coupleimage.frame = CGRect(x:79/414, y:258/896, width:256, height:256)
        Coupleimage.center = CGPoint(x:screenW/2, y:screenH/2.1)
        self.view.addSubview(Coupleimage)
    }
    
    private func omeimage(){
        
        Omeimage.image = UIImage(named:"omedetou")!
        
        let screenW:CGFloat = view.frame.size.width
        let screenH:CGFloat = view.frame.size.height
        
        Omeimage.frame = CGRect(x:107/414, y:558/896, width:200, height:106)
        Omeimage.center = CGPoint(x:screenW/2, y:screenH/1.3)
        self.view.addSubview(Omeimage)
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
    private func rednext(){
        Rednext.image = UIImage(named:"rednext")!
        
        let screenW:CGFloat = view.frame.size.width
        let screenH:CGFloat = view.frame.size.height
        
        Rednext.frame = CGRect(x:107/414, y:718/896, width:201.49, height:43.93)
        Rednext.center = CGPoint(x:screenW/2, y:screenH/1.2)
        self.view.addSubview(Rednext)
        
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
