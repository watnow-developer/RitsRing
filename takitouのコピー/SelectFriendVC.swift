//
//  ViewController.swift
//  add2_riri
//
//  Created by 瀧頭　直斗 on 2019/07/11.
//  Copyright © 2019 瀧頭　直斗. All rights reserved.
//

import UIKit

class SelectFriendViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let Alert: UIAlertController = UIAlertController(title:"フレンドになりますか",message: nil,preferredStyle: .alert)
        let YesAction = UIAlertAction(title: "Yes", style: .default) {
            action in
            
            let controller = yesselectedview()
            self.present(UINavigationController(rootViewController: controller),animated: true , completion: nil)
        }
        
        let NoAction = UIAlertAction(title: "No", style: .default){
            action in
            
            let controller = noselectedview()
            self.present(UINavigationController(rootViewController: controller),animated: true , completion: nil)
        }
        
        Alert.addAction(YesAction)
        Alert.addAction(NoAction)
        present(Alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    

}
/*
var screenwidth:CGFloat = 0

let friendlabel: UILabel = {
    let view = UILabel()
    view.frame.size = CGSize(width: 500, height: 50)
    view.center = CGPoint(x: 200, y: 200)
    view.textAlignment = .center
    view.text = "フレンドになりますか"
    return view
}()

let yesbutton:UIButton = {
    let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.width/5, y: 400, width: 200, height: 200))
    button.backgroundColor = UIColor(red: 230/255, green: 124/255, blue: 115/255, alpha: 1)
    button.setTitle("YES", for: .normal)
    button.layer.cornerRadius = 100
    button.layer.masksToBounds = true
    button.addTarget(nil, action: #selector(ViewController.yesview(_:)), for: .touchUpInside)
    return button
}()

let nobutton:UIButton = {
    let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.width/2, y: 400, width: 200, height: 200))
    button.backgroundColor = UIColor(red: 230/255, green: 124/255, blue: 115/255, alpha: 1)
    button.setTitle("NO", for: .normal)
    button.layer.cornerRadius = 100
    button.layer.masksToBounds = true
    button.addTarget(nil, action: #selector(ViewController.noview(_:)), for: .touchUpInside)
    return button
    
}()



override func viewDidLoad() {
    
    screenwidth = view.frame.size.width
    
    friendlabel.font = .systemFont(ofSize: 40)
    view.addSubview(friendlabel)
    
    view.addSubview(yesbutton)
    
    view.addSubview(nobutton)
    
    // Do any additional setup after loading the view.
}

@objc func noview(_ sender:UIButton){
    
    let noselected = noselectedview()
    noselected.view.backgroundColor = .white
    self.present(noselected, animated: true, completion: nil)
    
}

@objc func yesview(_ sender:UIButton){
    let yesselected = yesselectedview()
    yesselected.view.backgroundColor = .white
    self.present(yesselected, animated:  true, completion: nil)
}
*/
