//
//  yesselected.swift
//  add2_riri
//
//  Created by 瀧頭　直斗 on 2019/07/15.
//  Copyright © 2019 瀧頭　直斗. All rights reserved.
//

import UIKit

class yesselectedview: UIViewController {
    
    let yeslabel: UILabel = {
        let view = UILabel()
        view.frame.size = CGSize(width: 500, height: 100)
        view.textAlignment = .center
        view.center.x = view.center.x
        view.center = CGPoint(x: 200, y: 200)
        view.text = "フレンド成立"
        return view
        
    }()
    
    let namelabel: UITextField = {
        let view = UITextField()
        view.frame.size = CGSize(width: 200, height: 70)
        view.placeholder = "名前"
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor(red: 255/255, green: 230/255, blue: 230/255, alpha: 0.5)
        view.center.x = view.center.x
        view.center = CGPoint(x: 200, y: 550)
        return view
        
    }()
    
    let gobutton:UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 230/255, green: 124/255, blue: 115/255, alpha: 1)
        button.setTitle("GO", for: .normal)
        button.center = CGPoint(x: 70, y: 600)
        button.frame.size = CGSize(width:100, height: 70)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(yesselectedview.GONext(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc func GONext(_ sender:UIButton){
        let GScontroller = friendlistController()
        self.present(UINavigationController(rootViewController: GScontroller), animated: true ,completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        yeslabel.font = .systemFont(ofSize: 30)
        view.addSubview(yeslabel)
        
        view.addSubview(namelabel)
        
        gobutton.center.x = self.view.center.x
        view.addSubview(gobutton)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
 
