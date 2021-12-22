//
//  LoginVC.swift
//  Assignment-11
//
//  Created by DCS on 14/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    private let subview:UIView = {
        let sb = UIView()
        sb.backgroundColor = .white
        sb.layer.borderWidth = 1.0
        sb.layer.cornerRadius = 20.0
        return sb
    }()
    private let myImage:UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleToFill
        img.clipsToBounds = true
        img.backgroundColor = #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1)
        img.image = #imageLiteral(resourceName: "login")
        return img
    }()
    private let lbl1:UILabel = {
       let lbl = UILabel()
        lbl.text = "Log-in"
        
        lbl.font = UIFont(name: "HelveticaNeue-light", size: 30.0)
        return lbl
    }()
    private let username:UITextField = {
        let txt = UITextField()
        txt.placeholder = "Enter a Username"
        //txt.borderRect(forBounds: CGRect(x: 10, y: 10, width: 10, height: 10))
        txt.layer.borderWidth = 1.0
        txt.layer.borderColor = #colorLiteral(red: 0.8352941176, green: 0.8352941176, blue: 0.8352941176, alpha: 1)
        txt.layer.cornerRadius = 20.0
        txt.leftViewMode = .always
        var img = UIImageView(frame: CGRect(x: 50, y: 0, width: 50, height: 30))
        img.image = #imageLiteral(resourceName: "username")
        
        img.contentMode = .scaleAspectFit
        //img.backgroundColor = .red
        txt.leftView = img
        //txt.leftViewRect(forBounds: CGRect(x: 0, y: 0, width: 50, height: 30))
        /*var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: txt.frame.height - 1, width: txt.frame.width, height: 1.0)
        bottomLine.backgroundColor = #colorLiteral(red: 0.04190593551, green: 0.0760231599, blue: 0.02147890168, alpha: 1)
        txt.borderStyle = UITextField.BorderStyle.none
        txt.layer.addSublayer(bottomLine)*/
        
        return txt
    }()
    private let pwd:UITextField = {
        let txt = UITextField()
        txt.placeholder = "Enter a Password"
        //txt.borderRect(forBounds: CGRect(x: 10, y: 10, width: 10, height: 10))
        txt.layer.borderWidth = 1.0
        txt.layer.borderColor = #colorLiteral(red: 0.8352941176, green: 0.8352941176, blue: 0.8352941176, alpha: 1)
        txt.layer.cornerRadius = 20.0
        txt.leftViewMode = .always
        var img = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        img.image = #imageLiteral(resourceName: "pass")
        
        img.contentMode = .scaleAspectFit
        //img.backgroundColor = .red
        txt.leftView = img
        txt.isSecureTextEntry = true
        return txt
    }()
    private let loginbtn:UIButton = {
       let btn = UIButton()
        btn.setTitle("Login", for: .normal)
        btn.addTarget(self, action: #selector(btnlogin), for: .touchUpInside)
        btn.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.2196078431, blue: 0.262745098, alpha: 1)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 25.0
        btn.titleLabel?.font = UIFont(name: "HelveticaNeue-bold", size: 20.0)
        //btn.font = UIFont(name: "HelveticaNeue-light", size: 30.0)
        return btn
    }()
    @objc func btnlogin()
    {
        var id = username.text!
        let pass = pwd.text!
        if let id = UserDefaults.standard.string(forKey: "login_id")
        {
            let vc = (id=="Admin") ? AdminVC() : Home()
            navigationController?.pushViewController(vc, animated: false)
        }
            if id == "Admin" && pass == "Admin" {
                UserDefaults.standard.setValue(id, forKey: "login_id")
                UserDefaults.standard.setValue(pass, forKey: "name")
                let vc = AdminVC()
                navigationController?.pushViewController(vc, animated: true)
            } else {
                
                var stud:Student?
                stud = SqliteHandler.shared.check_login(id: Int(id) ?? 0, pass: pass)
                if stud?.id != 0 {
                    UserDefaults.standard.setValue(stud?.id, forKey: "login_id")
                    UserDefaults.standard.setValue(stud?.name, forKey: "name")
                    self.dismiss(animated: true)
                    let vc = Home()
                    navigationController?.pushViewController(vc, animated: true)
                }
            }
        
        
    }
    private let lbl2:UILabel = {
        let lbl = UILabel()
        lbl.text = "Forget password?"
        lbl.textColor = #colorLiteral(red: 0.04190593551, green: 0.0760231599, blue: 0.02147890168, alpha: 1)
        lbl.font = UIFont(name: "HelveticaNeue-light", size: 15.0)
        return lbl
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        if let name = UserDefaults.standard.string(forKey: "login_id") {
            if name == "Admin" {
                let vc = AdminVC()
                navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = Home()
                navigationController?.pushViewController(vc, animated: true)
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(subview)
        view.addSubview(myImage)
        subview.addSubview(lbl1)
        subview.addSubview(username)
        subview.addSubview(pwd)
        subview.addSubview(loginbtn)
        subview.addSubview(lbl2)
        let _ = SqliteHandler.shared
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        subview.frame = CGRect(x: 0, y: 250, width: view.width, height: view.height-subview.bottom)
        myImage.frame = CGRect(x: 0, y: 0, width: view.width, height: 280)
        lbl1.frame = CGRect(x: 40, y: 40, width: 200, height: 40)
        username.frame = CGRect(x: lbl1.left, y: lbl1.bottom + 30, width: view.width - 80, height: 50)
        pwd.frame = CGRect(x: lbl1.left, y: username.bottom + 30, width: view.width - 80, height: 50)
        lbl2.frame = CGRect(x: 210,y: pwd.bottom , width: 150, height: 30)
        loginbtn.frame = CGRect(x: lbl1.left, y: pwd.bottom + 50, width: view.width - 80, height: 50)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
