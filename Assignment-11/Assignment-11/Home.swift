//
//  Home.swift
//  Assignment-11
//
//  Created by DCS on 20/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class Home: UIViewController {
    private let lbl1:UILabel = {
        let lbl = UILabel()
        lbl.text = "Welcome \(UserDefaults.standard.string(forKey: "name") ?? "Student")"
        lbl.textColor = #colorLiteral(red: 0.1333333333, green: 0.2196078431, blue: 0.262745098, alpha: 1)
        lbl.font = UIFont(name: "HelveticaNeue-light", size: 25.0)
        return lbl
    }()
    private let Noticebtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("Notices", for: .normal)
        btn.addTarget(self, action: #selector(notices_btn), for: .touchUpInside)
        btn.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.2196078431, blue: 0.262745098, alpha: 1)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 25.0
        btn.titleLabel?.font = UIFont(name: "HelveticaNeue-bold", size: 20.0)
        //btn.font = UIFont(name: "HelveticaNeue-light", size: 30.0)
        return btn
    }()
    private let profilebtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("Profile", for: .normal)
        btn.addTarget(self, action: #selector(btnprofile), for: .touchUpInside)
        btn.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.2196078431, blue: 0.262745098, alpha: 1)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 25.0
        btn.titleLabel?.font = UIFont(name: "HelveticaNeue-bold", size: 20.0)
        //btn.font = UIFont(name: "HelveticaNeue-light", size: 30.0)
        return btn
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
        view.addSubview(lbl1)
        view.addSubview(Noticebtn)
        view.addSubview(changepwdbtn)
        view.addSubview(profilebtn)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        //self.navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.hidesBackButton = true
        let rightbtn = UIBarButtonItem.init(image: #imageLiteral(resourceName: "logout"), style: .done, target: self, action: #selector(logout))
        self.navigationItem.rightBarButtonItem = rightbtn
    }
    @objc func logout()
    {
        UserDefaults.standard.setValue(nil, forKey: "name")
        UserDefaults.standard.setValue(nil, forKey: "login_id")
        let vc = LoginVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func notices_btn()
    {
        navigationController?.pushViewController(NoticeVC(), animated: true)
    }
    @objc func btnprofile()
    {
        print("profile")
        navigationController?.pushViewController(ProfileVC(), animated: true)
    }
    @objc func btnchangepwd()
    {
        print("profile")
        navigationController?.pushViewController(ChangepwdVC(), animated: true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        lbl1.frame = CGRect(x: 100, y: 200, width: view.width - 40 , height: 30)
        Noticebtn.frame = CGRect(x: 20, y: lbl1.bottom + 20, width: view.width - 40, height: 50)
        changepwdbtn.frame = CGRect(x: 20, y: Noticebtn.bottom + 20, width: view.width - 40, height: 50)
        profilebtn.frame = CGRect(x: 20, y: changepwdbtn.bottom + 20, width: view.width - 40, height: 50)
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
