//
//  NoticedispVC.swift
//  Assignment-11
//
//  Created by DCS on 22/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class NoticedispVC: UIViewController {
    public var notice:Notice?
    private let titlelbl:UILabel = {
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
    private let datelbl:UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = #colorLiteral(red: 0.1333333333, green: 0.2196078431, blue: 0.262745098, alpha: 1)
        lbl.font = UIFont(name: "HelveticaNeue-light", size: 25.0)
        return lbl
    }()
    private let desclbl:UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = #colorLiteral(red: 0.1333333333, green: 0.2196078431, blue: 0.262745098, alpha: 1)
        lbl.font = UIFont(name: "HelveticaNeue-light", size: 25.0)
        return lbl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titlelbl)
        view.addSubview(courselbl)
        view.addSubview(datelbl)
        view.addSubview(desclbl)
        let rightbtn = UIBarButtonItem.init(image: #imageLiteral(resourceName: "logout"), style: .done, target: self, action: #selector(logout))
        self.navigationItem.rightBarButtonItem = rightbtn
        if let n = notice {
            titlelbl.text = "Topic: \(n.name)"
            courselbl.text = "Course: \(n.course)"
            datelbl.text = "Date: \(n.notice_date)"
            desclbl.text = "\(n.desc)"
        }
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titlelbl.frame = CGRect(x: 60, y: 100, width: view.width - view.left, height: 30)
        courselbl.frame = CGRect(x: titlelbl.left, y: titlelbl.bottom + 20, width: view.width - view.left, height: 30)
        datelbl.frame = CGRect(x: titlelbl.left, y: courselbl.bottom + 20, width: view.width - view.left, height: 30)
        desclbl.frame = CGRect(x: 60, y: datelbl.bottom + 20, width: view.width - view.left, height: 50)
    }
    @objc func logout()
    {
        UserDefaults.standard.setValue(nil, forKey: "name")
        UserDefaults.standard.setValue(nil, forKey: "login_id")
        let vc = LoginVC()
        navigationController?.pushViewController(vc, animated: true)
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
