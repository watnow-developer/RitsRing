//
//  ViewController.swift
//  addriri5
//
//  Created by 瀧頭　直斗 on 2019/08/10.
//  Copyright © 2019 瀧頭　直斗. All rights reserved.
//

import UIKit

class MyprofileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    
    //section1の文字配列
    let rowtext:[String] = ["性別","学部", "学科", "入学年度"]
    
    var tableview:UITableView = {
        
        var tableview = UITableView()
        tableview = UITableView(frame: UIScreen.main.bounds, style: UITableView.Style.grouped)
        tableview.rowHeight = UIScreen.main.bounds.width/5
        
        return tableview
    }()
    //画像
    var headerview:UIImageView = {
        
        var headerview = UIImageView()
        let imageview = UIImage(named: "profile")
        let screenwidth = UIScreen.main.bounds.width/4
        let screenheight = UIScreen.main.bounds.width/4
        headerview = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width/7*5, y: screenheight, width: screenwidth, height: screenwidth))
        headerview.image = imageview
        headerview.layer.cornerRadius = 20
        headerview.clipsToBounds = true
        
        return headerview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        view.addSubview(tableview)
        
        view.addSubview(headerview)
        
        tableview.register(TextInputTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(TextInputTableViewCell.self))
        
        configureUI()
        
        let tapview = UITapGestureRecognizer(target: self, action:#selector(imageTapped))
        headerview.isUserInteractionEnabled = true
        headerview.addGestureRecognizer(tapview)
        // Do any additional setup after loading the view.
    }

    
    @objc fileprivate func imageTapped(){
        // アルバム(Photo liblary)の閲覧権限の確認
        checkPermission()
        
      /*  if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            print("present Start")
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }*/
    }
    
    func checkPermission(){
       /* let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationStatus {
        case .authorized:
            print("auth")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                }
            })
            print("not Determined")
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        @unknown default:
            break
        }*/
    }


@objc func handleDismiss(){
    dismiss(animated: true, completion: nil)
}
    
    func configureUI(){
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(red: 230/255, green: 124/255, blue: 115/255, alpha: 1)
        navigationItem.title = "プロフィール"
        navigationController?.navigationBar.barStyle = .black
        //withRenderingMode(.alwaysOriginal)することによって元の色を保つ
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "backbutton").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleDismiss ))
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0 ){
            return ("プロフィール")
        }else{
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        }else{
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier:NSStringFromClass(TextInputTableViewCell.self), for: indexPath) as? TextInputTableViewCell else {
            fatalError("The dequeued cell is not instance of MealTableViewCell.")
        }
        
        cell.TitleTextField.delegate = self
        cell.backgroundColor = UIColor(red: 255/255, green: 230/255, blue: 230/250, alpha: 0.5)
        
        switch indexPath.section {
        case 0:
            cell.TitleTextField.placeholder = "名前を入力"
            
        default:
            cell.textLabel?.text = rowtext[indexPath.row]
            
        }
        return cell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

