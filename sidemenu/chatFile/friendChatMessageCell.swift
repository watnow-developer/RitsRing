//
//  friendChatMessageCell.swift
//  sidemenu
//
//  Created by yu on 2019/08/20.
//  Copyright © 2019 yu. All rights reserved.
//

import UIKit

class friendChatMessageCell: UITableViewCell {
    
    let messageLabel = UILabel()
    let bubbleBackgroundView = UIView()
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    
    var friendchatMessage: friendChatMessage!{
        didSet{
            bubbleBackgroundView.backgroundColor =
                friendchatMessage.isIncoming ?.white : UIColor(red: 255/255, green: 51/255, blue: 68/255, alpha: 0.5)
            messageLabel.textColor = friendchatMessage.isIncoming ? .black : .white
            
            messageLabel.text = friendchatMessage.text
            
            if friendchatMessage.isIncoming{
                leadingConstraint.isActive = true
                trailingConstraint.isActive = false
            }else{
                leadingConstraint.isActive = false
                trailingConstraint.isActive = true
            }
        }
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        //背景
        backgroundColor = .clear
        
        //吹き出し設定
        
        bubbleBackgroundView.backgroundColor = .yellow
        bubbleBackgroundView.layer.cornerRadius = 12
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bubbleBackgroundView)
        addSubview(messageLabel)
        
        
        messageLabel.text = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
        
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        //吹き出し位置設定
        let constraints =
            [messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16 ),
             messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32 ),
             //lessthan使うことによって文字少ない時の吹き出しの無駄スペースをなくす
                messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
                bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor,constant:-16),
                bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor,constant:-16),
                bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor,constant:16),
                bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor,constant:16 ),
                
                ]
        
        NSLayoutConstraint.activate(constraints)
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 32)
        leadingConstraint.isActive = false
        
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        
        trailingConstraint.isActive = true
        
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
