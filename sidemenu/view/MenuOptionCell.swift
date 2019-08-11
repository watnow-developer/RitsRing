//
//  MenuOptionCellTableViewCell.swift
//  sidemenu
//
//  Created by yu on 2019/08/04.
//  Copyright © 2019 yu. All rights reserved.
//



//サイドメニュー（左）機能
import UIKit

class MenuOptionCell: UITableViewCell {
    
    
    //Mark: properties
    
        let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
     
        return  iv
        
      
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "sample text"
        return label
    }()

    
    //Mark:Init
    
    override init(style:UITableViewCell.CellStyle, reuseIdentifier:String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        backgroundColor = UIColor(red: 230/255, green: 124/255, blue: 115/255, alpha: 1)
        selectionStyle = .none
        
        
        //icon image
        addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconImageView.leftAnchor.constraint(equalTo: leftAnchor , constant:12).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        
        //label
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor , constant:12).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //Mark:Handlers
    
    
}
