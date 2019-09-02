//
//  Container.swift
//  sidemenu
//
//  Created by yu on 2019/08/03.
//  Copyright © 2019 yu. All rights reserved.
//

import UIKit

class ContainerController: UIViewController {
    
    // Mark - Properties
    
    var menuController:MenuController!
    var centerController:UIViewController!
    var isExpanded = false
    
    //Mark - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHomeController()
    }
    
    
    //navigation bar
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
        return.slide
    }
    
    override var prefersStatusBarHidden: Bool{
        return isExpanded
    }
    
    //Mark - Handlers
    func configureHomeController(){
        let homeController = HomeController()
        homeController.delegate = self
        
        
        centerController
            = UINavigationController(rootViewController:  homeController)
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self )
        
    }
    
    func configureMenuController(){
        
        if menuController == nil{
            
            menuController = MenuController()
            menuController.delegate = self
            view.insertSubview(menuController.view , at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
            
        }
        
    }
    
    
    
    func animatePanel(shouldExpand:Bool, menuOption: MenuOption?){
        
        if shouldExpand{
            //show menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity:0 , options: .curveEaseInOut, animations:
                {
                    //位置情報
                    self.centerController.view.frame.origin.x =
                        self.centerController.view.frame.width - 80
                    
            }, completion: nil)
        }else{
            //hide menu
            
            
            UIView.animate(withDuration: 0.5, delay: 0 , usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations:  {
                //位置情報
                self.centerController.view.frame.origin.x = 0
            }){(_) in
                guard let menuOption = menuOption else {return}
                self.didSelectMenuOption(menuOption: menuOption )
            }
        }
        animateStatusBar()
    }
    
    
    //各ボタン選択したときの動作(画面遷移）
    func didSelectMenuOption(menuOption: MenuOption){
        switch menuOption{
            
        case .profile:
            let controller2 = MyprofileViewController()
            present(UINavigationController(rootViewController: controller2),animated: true , completion: nil)
        case .friend:
            let controller = friendlistController()
            present(UINavigationController(rootViewController: controller),animated: true , completion: nil)
        case .matchFriend:
            let controller1 = genderSelectController()
            present(UINavigationController(rootViewController: controller1),animated: true , completion: nil)
            
        case .logout:
            let controller3 = SignUpViewController()
            present(UINavigationController(rootViewController: controller3),animated: true , completion: nil)
            
        }
    }
    func animateStatusBar(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity:0 , options: .curveEaseInOut, animations:
            {
                self.setNeedsStatusBarAppearanceUpdate()
        }, completion: nil)
    }
    
}

extension ContainerController: HomeControllerDelegate{
    func handleMenuToggle(forMenuOption menuOption: MenuOption?) {
        if !isExpanded{
            configureMenuController()
        }
        
        isExpanded = !isExpanded
        
        animatePanel(shouldExpand: isExpanded, menuOption: menuOption)
    }
}
