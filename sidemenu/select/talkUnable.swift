//
//  talkUnable.swift
//  sidemenu
//
//  Created by yu on 2019/08/10.
//  Copyright © 2019 yu. All rights reserved.
//

import UIKit

class talkUnableController: UIViewController {
  
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .white
            navigationController?.navigationBar.barTintColor = UIColor(red: 230/255, green: 124/255, blue: 115/255, alpha: 1)
            
        }
        
        override func viewDidAppear(_ animated: Bool) {
            let Alert: UIAlertController = UIAlertController(title:"トークできません",message:"オンラインの人を選択してください",preferredStyle: .alert)
            let CloseAction = UIAlertAction(title: "戻る", style: .default) {
                action in
                
                let controller = friendlistController()
                self.present(UINavigationController(rootViewController: controller),animated: true , completion: nil)
            }
            Alert.addAction(CloseAction)
            present(Alert, animated: true, completion: nil)
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
        
}
