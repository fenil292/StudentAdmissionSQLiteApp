//
//  ChangepwdVC.swift
//  Assignment-11
//
//  Created by DCS on 22/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ChangepwdVC: UIViewController {
    private let newpwd:UITextField = {
        let txt = UITextField()
        txt.placeholder = "Enter a New Password"
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
        
        return txt
    }()
    private let confirmpwd:UITextField = {
        let txt = UITextField()
        txt.placeholder = "Enter a Confirm Password"
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
    private let changepwdbtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("Change Password", for: .normal)
        btn.addTarget(self, action: #selector(btnchangepwd), for: .touchUpInside)
        btn.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.2196078431, blue: 0.262745098, alpha: 1)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 25.0
        btn.titleLabel?.font = UIFont(name: "HelveticaNeue-bold", size: 20.0)
        //btn.font = UIFont(name: "HelveticaNeue-light", size: 30.0)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let rightbtn = UIBarButtonItem.init(image: #imageLiteral(resourceName: "logout"), style: .done, target: self, action: #selector(logout))
        self.navigationItem.rightBarButtonItem = rightbtn
        view.addSubview(newpwd)
        view.addSubview(confirmpwd)
        view.addSubview(changepwdbtn)
        // Do any additional setup after loading the view.
    }
    @objc func logout()
    {
        UserDefaults.standard.setValue(nil, forKey: "name")
        UserDefaults.standard.setValue(nil, forKey: "login_id")
        let vc = LoginVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func btnchangepwd()
    {
        if newpwd.text == confirmpwd.text {
            let id = Int(UserDefaults.standard.string(forKey: "login_id") ?? "0") ?? 0
            let pass = newpwd.text!
            update(pass: pass, id: id)
        }
    }
    func update(pass: String, id: Int) {
        SqliteHandler.shared.update_password(pass: pass, id: id) { (success) in
            if success {
                print("Update successfull, recevied mesage at VC")
                self.newpwd.text = ""
                self.confirmpwd.text = ""
            } else {
                print("Update failed, recevied mesage at VC")
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        newpwd.frame = CGRect(x: 20, y: 200, width: view.width - 40, height: 50)
        confirmpwd.frame = CGRect(x: 20, y: newpwd.bottom + 30, width: view.width - 40, height: 50)
        changepwdbtn.frame = CGRect(x: 20, y: confirmpwd.bottom + 30, width: view.width - 40, height: 50)
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
