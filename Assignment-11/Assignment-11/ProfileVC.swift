//
//  ProfileVC.swift
//  Assignment-11
//
//  Created by DCS on 22/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    private var stud:Student?
    private let spidlbl:UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = #colorLiteral(red: 0.1333333333, green: 0.2196078431, blue: 0.262745098, alpha: 1)
        lbl.font = UIFont(name: "HelveticaNeue-light", size: 25.0)
        return lbl
    }()
    private let namelbl:UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = #colorLiteral(red: 0.1333333333, green: 0.2196078431, blue: 0.262745098, alpha: 1)
        lbl.font = UIFont(name: "HelveticaNeue-light", size: 25.0)
        return lbl
    }()
    private let phonelbl:UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = #colorLiteral(red: 0.1333333333, green: 0.2196078431, blue: 0.262745098, alpha: 1)
        lbl.font = UIFont(name: "HelveticaNeue-light", size: 25.0)
        return lbl
    }()
    private let gmaillbl:UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = #colorLiteral(red: 0.1333333333, green: 0.2196078431, blue: 0.262745098, alpha: 1)
        lbl.font = UIFont(name: "HelveticaNeue-light", size: 25.0)
        return lbl
    }()
    private let genderlbl:UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = #colorLiteral(red: 0.1333333333, green: 0.2196078431, blue: 0.262745098, alpha: 1)
        lbl.font = UIFont(name: "HelveticaNeue-light", size: 25.0)
        return lbl
    }()
    private let courselbl:UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = #colorLiteral(red: 0.1333333333, green: 0.2196078431, blue: 0.262745098, alpha: 1)
        lbl.font = UIFont(name: "HelveticaNeue-light", size: 25.0)
        return lbl
    }()
    private let doblbl:UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = #colorLiteral(red: 0.1333333333, green: 0.2196078431, blue: 0.262745098, alpha: 1)
        lbl.font = UIFont(name: "HelveticaNeue-light", size: 25.0)
        return lbl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let rightbtn = UIBarButtonItem.init(image: #imageLiteral(resourceName: "logout"), style: .done, target: self, action: #selector(logout))
        self.navigationItem.rightBarButtonItem = rightbtn
        view.addSubview(spidlbl)
        view.addSubview(namelbl)
        view.addSubview(phonelbl)
        view.addSubview(gmaillbl)
        view.addSubview(genderlbl)
        view.addSubview(courselbl)
        view.addSubview(doblbl)
        stud = SqliteHandler.shared.fetch_stud_info(id: Int(UserDefaults.standard.string(forKey: "login_id") ?? "") ?? 0)
        if let s = stud {
            spidlbl.text = "Spid: \(s.id)"
            namelbl.text = "Name: \(s.name)"
            phonelbl.text = "Phone no: \(s.phone)"
            gmaillbl.text = "Gmail: \(s.gmail)"
            genderlbl.text = "Gender: \(s.gender)"
            courselbl.text = "Course: \(s.course)"
            doblbl.text = "DOB: \(s.dob)"
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    @objc func logout()
    {
        UserDefaults.standard.setValue(nil, forKey: "name")
        UserDefaults.standard.setValue(nil, forKey: "login_id")
        let vc = LoginVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        spidlbl.frame = CGRect(x: 30, y: 100, width: view.width - 60, height: 50)
        namelbl.frame = CGRect(x: spidlbl.left, y: spidlbl.bottom + 10, width: view.width - 30, height: 50)
        phonelbl.frame = CGRect(x: spidlbl.left, y: namelbl.bottom + 10, width: view.width - 30, height: 50)
        gmaillbl.frame = CGRect(x: spidlbl.left, y: phonelbl.bottom + 10, width: view.width - 30, height: 50)
        genderlbl.frame = CGRect(x: spidlbl.left, y: gmaillbl.bottom + 10, width: view.width - 30, height: 50)
        courselbl.frame = CGRect(x: spidlbl.left, y: genderlbl.bottom + 10, width: view.width - 30, height: 50)
        doblbl.frame = CGRect(x: spidlbl.left, y: courselbl.bottom + 10, width: view.width - 30, height: 50)
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
