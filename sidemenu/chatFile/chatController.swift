///
//  chatController.swift
//  sidemenu
//
//  Created by yu on 2019/08/11.
//  Copyright © 2019 yu. All rights reserved.
//

import UIKit

struct ChatMessage {
    let text: String
    let isIncoming: Bool
    let date: Date
}

extension Date {
    static func dateFromCustomStirng(customString: String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: customString)  ?? Date()
        
    }
}

class chatController : UITableViewController{
    
    fileprivate let cellId = "id123"
    
    let messegeTF: UITextField = {
        let textdield = UITextField()
        textdield.frame = CGRect(x: UIScreen.main.bounds.width / 8, y: UIScreen.main.bounds.height * 2/3 , width: UIScreen.main.bounds.width * 3/4, height: 100)
        textdield.textAlignment = NSTextAlignment.center
        textdield.backgroundColor = UIColor.white
        return textdield
    }()
    //true 左　false 右
    
    
    
    let messagesFromServer = [
        ChatMessage(text: "here's my first message", isIncoming: true , date: Date.dateFromCustomStirng(customString: "08/11/2019")),
        ChatMessage(text: "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz", isIncoming: true, date: Date.dateFromCustomStirng(customString: "08/10/2019 ")),
        ChatMessage(text: "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz", isIncoming: false, date: Date()),
        ChatMessage(text: "abc", isIncoming: false, date: Date()),
        ChatMessage(text: "this message should appear in the left", isIncoming: true, date: Date()),
        ChatMessage(text: "Third section message", isIncoming: true, date: Date())
    ]
    
    
    fileprivate func attemptToAssembleGroupedMessages() {
        print("Attempt to group our messages together based on Date property")
        
        //????
        let groupedMessages = Dictionary(grouping: messagesFromServer) { (element) -> Date in
            return element.date
        }
        
        //provide a sorting for your keys somehow
        let sortedKeys = groupedMessages.keys.sorted()
        sortedKeys.forEach { (key) in
            let values = groupedMessages[key]
            chatMessages.append(values ?? [] )
        }
        
    }
    
    var chatMessages = [[ChatMessage]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attemptToAssembleGroupedMessages()
        
        //Navigation Controller setting
        navigationItem.title = "RiRi Chat"// すでにフレンドなのか、あたらしい
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UIColor(red: 230/255, green: 124/255, blue: 115/255, alpha: 1)
        navigationController?.navigationBar.barStyle = .black
        
        
        //tableView setting
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        configureUI()
        view.addSubview(messegeTF)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return chatMessages.count
    }
    //日付見た目
    class DateHeaderLabel: UILabel {
        override init(frame: CGRect){
            super.init(frame: frame)
            backgroundColor = UIColor(red: 240/255, green: 48/255, blue: 64/255, alpha: 1)
            textColor = .white
            textAlignment = .center
            translatesAutoresizingMaskIntoConstraints = false
            font = UIFont.boldSystemFont(ofSize: 14)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
        override var intrinsicContentSize: CGSize{
            let originalContentSize = super.intrinsicContentSize
            let height = originalContentSize.height + 12
            layer.cornerRadius = height/2
            layer.masksToBounds = true
            return CGSize(width: originalContentSize .width + 16 , height: height )
        }
    }
    
    //日付設定
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        if let firstMessageInSection = chatMessages[section].first{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let dateString = dateFormatter.string(from:firstMessageInSection.date)
            let label =  DateHeaderLabel()
            
            label.text = dateString
            let containerView = UIView()
            containerView.addSubview(label)
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            
            return containerView
        }

        return nil
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  50
    }
    
    //一つのセクションに何個メッセージ(return)
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)as!ChatMessageCell
        let chatMessage  = chatMessages[indexPath.section][indexPath.row]
        cell.chatMessage = chatMessage
        return cell
    }
    
    //次に行く動作
    @objc func backMain(){
        let NextController44 = SelectFriendViewController()
        self.present(NextController44, animated: true ,completion: nil)
    }
    
    
    func configureUI(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "backbutton").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backMain ))
    
    }
    
    

}
