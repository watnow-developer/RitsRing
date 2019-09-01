//
//  menuOption.swift
//  sidemenu
//
//  Created by yu on 2019/08/07.
//  Copyright © 2019 yu. All rights reserved.
//

//メモ　；　Enum(列挙型)とは、複数の定数をひとつにまとめておくことができる型

import UIKit

enum MenuOption: Int, CustomStringConvertible{
    
    
    
    case profile
    case friend
    case matchFriend
    case logout
    
    var description: String{
        switch self {
            
        case .profile:
            return "Profile"
        case .friend:
            return "Friend List"
        case .matchFriend:
            return "Match Friend"
        case .logout:
            return "Logout"
        }
    }
    
    var image: UIImage{
        switch self {
            
    case .profile:
        return UIImage(named:"profile") ?? UIImage()
    case .friend:
        return UIImage(named:"friends") ?? UIImage()
    case .matchFriend:
        return UIImage(named:"matchfriend") ?? UIImage()
    case .logout:
        return UIImage(named:"logout") ?? UIImage()

}
}
    
}
