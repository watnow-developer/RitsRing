//
//  TextInputTableViewCell.swift
//  addriri5
//
//  Created by 瀧頭　直斗 on 2019/08/10.
//  Copyright © 2019 瀧頭　直斗. All rights reserved.
//

import UIKit

class TextInputTableViewCell: UITableViewCell {
    //MARK: Properties
    var TitleTextField:UITextField!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.createTitleTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(TitleTextField)
        TitleTextField.frame = CGRect(x: 0, y: 0, width: frame.width - 60, height: frame.height)
    }
    //MARK : method
    private func createTitleTextField(){
        
        TitleTextField = UITextField(frame: CGRect.zero)
        TitleTextField.textAlignment = .center
        TitleTextField.font = UIFont.systemFont(ofSize: 20)
        
    }
}

