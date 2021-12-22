//
//  NewstudVC.swift
//  Assignment-11
//
//  Created by DCS on 14/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class NewNoticeVC: UIViewController {
    private let ncourse = ["All Courses","BCA","MCA","BBA","MBA","Bcom","Mcom"]
    public var note:Notice?
    /*private let doblbl:UILabel = {
        let lbl = UILabel()
        lbl.text = "Date of Birth:"
        lbl.textColor = #colorLiteral(red: 0.1333333333, green: 0.2196078431, blue: 0.262745098, alpha: 1)
        lbl.font = UIFont(name: "HelveticaNeue-light", size: 17.0)
        return lbl
    }()*/
    private let topic_name:UITextField = {
        let txt = UITextField()
        txt.placeholder = "Enter a Topic name"
        txt.leftViewMode = .always
        var img = UIImageView(frame: CGRect(x: 50, y: 0, width: 50, height: 25))
        img.image = #imageLiteral(resourceName: "notice")
        img.contentMode = .scaleAspectFit
        txt.leftView = img
        txt.layer.borderWidth = 1.0
        txt.layer.borderColor = #colorLiteral(red: 0.8352941176, green: 0.8352941176, blue: 0.8352941176, alpha: 1)
        txt.layer.cornerRadius = 20.0
        
        return txt
    }()
    private let desc:UITextView = {
        let txt = UITextView()
        txt.text = ""
        txt.layer.borderWidth = 1.0
        txt.layer.borderColor = #colorLiteral(red: 0.8352941176, green: 0.8352941176, blue: 0.8352941176, alpha: 1)
        txt.layer.cornerRadius = 20.0
        txt.font = .systemFont(ofSize: 16)
        
        return txt
    }()
    
    private let noticedate : UIDatePicker = {
        let db = UIDatePicker()
        db.timeZone = NSTimeZone.local
        db.datePickerMode = UIDatePicker.Mode.date
        db.layer.borderWidth = 1
        db.layer.borderColor = UIColor.white.cgColor
        db.tintColor = .black
        db.backgroundColor = .white
        db.setValue(UIColor.black, forKey: "textColor")
        let date = Date()
        db.setDate(date, animated: false)
        return db
    }()
    
    private let pickerView = UIPickerView()
    
    private let savebtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("Save", for: .normal)
        btn.addTarget(self, action: #selector(save_notice), for: .touchUpInside)
        btn.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.2196078431, blue: 0.262745098, alpha: 1)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 25.0
        btn.titleLabel?.font = UIFont(name: "HelveticaNeue-bold", size: 20.0)
        //btn.font = UIFont(name: "HelveticaNeue-light", size: 30.0)
        return btn
    }()
    @objc private func save_notice()
    {
        let notice_name = topic_name.text!
        let course = ncourse[pickerView.selectedRow(inComponent:0)]
        let ndate = "\(noticedate.date)".components(separatedBy: " ").first ?? ""
        let ndesc = desc.text!
        if let n = note {
            let upnotice = Notice(id: n.id, name: notice_name, course: course, notice_date: ndate, desc: ndesc)
            update(not: upnotice)
        } else {
            let insnotice = Notice(id: 0, name: notice_name, course: course, notice_date: ndate, desc: ndesc)
            if notice_name != "" {
                    insert(not: insnotice)
            }
        }
        
    }
    private func resetfields()
    {
        note = nil
        topic_name.text = ""
        desc.text = ""
        pickerView.selectRow(0, inComponent: 0, animated: true)
    }
    private func insert(not:Notice) {
        SqliteHandler.shared.insert_notice(s: not) { (success) in
            if success {
                print("Insert successfull, recevied mesage at VC")
                self.resetfields()
            } else {
                print("Insert failed, recevied mesage at VC")
            }
        }
    }
    private func update(not:Notice) {
        SqliteHandler.shared.update_notice(n: not) { (success) in
            if success {
                print("Update successfull, recevied mesage at VC")
                self.resetfields()
            } else {
                print("Update failed, recevied mesage at VC")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //navigationController?.setNavigationBarHidden(false, animated: false)
        view.addSubview(topic_name)
        //view.addSubview(lbl1)
        
        view.addSubview(pickerView)
        view.addSubview(noticedate)
        view.addSubview(savebtn)
        view.addSubview(desc)
        //view.addSubview(doblbl)
        pickerView.dataSource = self
        pickerView.delegate = self
        if let n = note {
            topic_name.text = n.name
            desc.text = n.desc
            var i=0
            for name in ncourse
            {
                if name == n.course {
                    pickerView.selectRow(i, inComponent: 0, animated: false)
                    
                    break
                }
                i = i + 1
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat =  "yyyy-MM-dd"
            
            let date = dateFormatter.date(from: n.notice_date)
            noticedate.date = date ?? Date()
        }
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //lbl1.frame = CGRect(x: 120, y: 0, width: 200, height: 40)
        topic_name.frame = CGRect(x: 40, y: 30, width: view.width - 80, height: 45)
        pickerView.frame = CGRect(x: 40, y: topic_name.bottom + 5, width: view.width - 80, height: 60)
        //doblbl.frame = CGRect(x: 140, y: pickerView.bottom, width: 200, height: 25)
        noticedate.frame = CGRect(x: 40, y: pickerView.bottom + 5, width: view.width - 80, height: 50)
        desc.frame = CGRect(x: 40, y: noticedate.bottom + 30, width: view.width - 80, height: 200)
        savebtn.frame = CGRect(x: 40, y: desc.bottom + 20, width: view.width - 80, height: 50)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
extension NewNoticeVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ncourse.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ncourse[row]
        
        
    }
    
    
}
