//
//  noselectedview.swift
//  add2_riri
//
//  Created by 瀧頭　直斗 on 2019/07/14.
//  Copyright © 2019 瀧頭　直斗. All rights reserved.
//

import UIKit

class noselectedview:UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let Alert: UIAlertController = UIAlertController(title:"マッチできませんでした",message:nil,preferredStyle: .alert)
        let CloseAction = UIAlertAction(title: "もう一度マッチしにいく", style: .default) {
            action in
            
            let controller = genderSelectController()
            self.present(UINavigationController(rootViewController: controller),animated: true , completion: nil)
        }
        Alert.addAction(CloseAction)
        present(Alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

