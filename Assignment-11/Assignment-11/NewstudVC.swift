//
//  NewstudVC.swift
//  Assignment-11
//
//  Created by DCS on 14/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class NewstudVC: UIViewController {
    private let course = ["Select Course","BCA","MCA","BBA","MBA","Bcom","Mcom"]
    public var stud:Student?
    private let lbl1:UILabel = {
        let lbl = UILabel()
        lbl.text = "Add Student"
        lbl.textColor = #colorLiteral(red: 0.1333333333, green: 0.2196078431, blue: 0.262745098, alpha: 1)
        lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 25.0)
        return lbl
    }()
    private let doblbl:UILabel = {
        let lbl = UILabel()
        lbl.text = "Date of Birth:"
        lbl.textColor = #colorLiteral(red: 0.1333333333, green: 0.2196078431, blue: 0.262745098, alpha: 1)
        lbl.font = UIFont(name: "HelveticaNeue-light", size: 17.0)
        return lbl
    }()
    private let name:UITextField = {
        let txt = UITextField()
        txt.placeholder = "Enter a Name"
        
        txt.layer.borderWidth = 1.0
        txt.layer.borderColor = #colorLiteral(red: 0.8352941176, green: 0.8352941176, blue: 0.8352941176, alpha: 1)
        txt.layer.cornerRadius = 20.0
        txt.leftViewMode = .always
        var img = UIImageView(frame: CGRect(x: 50, y: 0, width: 50, height: 30))
        img.image = #imageLiteral(resourceName: "username")
        img.contentMode = .scaleAspectFit
        txt.leftView = img
        return txt
    }()
    private let phno:UITextField = {
        let txt = UITextField()
        txt.placeholder = "Enter a Mobile No"
        
        txt.layer.borderWidth = 1.0
        txt.layer.borderColor = #colorLiteral(red: 0.8352941176, green: 0.8352941176, blue: 0.8352941176, alpha: 1)
        txt.layer.cornerRadius = 20.0
        txt.leftViewMode = .always
        var img = UIImageView(frame: CGRect(x: 50, y: 0, width: 50, height: 25))
        img.image = #imageLiteral(resourceName: "phone")
        img.contentMode = .scaleAspectFit
        txt.leftView = img
        return txt
    }()
    private let gmail:UITextField = {
        let txt = UITextField()
        txt.placeholder = "Enter a Gmail"
        
        txt.layer.borderWidth = 1.0
        txt.layer.borderColor = #colorLiteral(red: 0.8352941176, green: 0.8352941176, blue: 0.8352941176, alpha: 1)
        txt.layer.cornerRadius = 20.0
        txt.leftViewMode = .always
        var img = UIImageView(frame: CGRect(x: 50, y: 0, width: 50, height: 25))
        img.image = #imageLiteral(resourceName: "email")
        img.contentMode = .scaleAspectFit
        txt.leftView = img
        return txt
    }()
    private let mySeg:UISegmentedControl = {
        let seg = UISegmentedControl()
        seg.insertSegment(withTitle: "Male", at: 0, animated: true)
        seg.insertSegment(withTitle: "Female", at: 1, animated: true)
        seg.backgroundColor = .white
        seg.layer.cornerRadius = 25.0
        seg.selectedSegmentIndex = 0
        seg.tintColor = #colorLiteral(red: 0.1333333333, green: 0.2196078431, blue: 0.262745098, alpha: 1)
        //seg.addTarget(self, action: #selector(segCllick), for: .valueChanged)
        return  seg
    }()
    private let pickerView = UIPickerView()
    private let BirthDatePicker : UIDatePicker = {
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
    private let savebtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("Save", for: .normal)
        btn.addTarget(self, action: #selector(save_btn), for: .touchUpInside)
        btn.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.2196078431, blue: 0.262745098, alpha: 1)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 25.0
        btn.titleLabel?.font = UIFont(name: "HelveticaNeue-bold", size: 20.0)
        //btn.font = UIFont(name: "HelveticaNeue-light", size: 30.0)
        return btn
    }()
    @objc func save_btn()
    {
        //SqliteHandler.shared.delete(id: 202120212)
        let id = SqliteHandler.shared.fetch_id() + 1
        let spid:Int
        if id == 1 {
            let y = "2021\(id)"
            spid = Int(y) ?? 1
        } else {
            spid = id
        }
        let p = "\(spid)"
        let sname = name.text!
        let mob = phno.text!
        let sgmail = gmail.text!
        let gender = mySeg.selectedSegmentIndex == 0 ? "Male" : "Female"
        let scourse = course[pickerView.selectedRow(inComponent:0)]
        let date = "\(BirthDatePicker.date)".components(separatedBy: " ").first ?? ""
        //print(date)
        let insstud = Student(id: spid, pwd: p, name: sname, phone: mob, gmail: sgmail, gender: gender, course: scourse, dob: date)
        print(insstud.id)
        
        insert(stud: insstud)
        
    }
    private func resetfields()
    {
        name.text = ""
        phno.text = ""
        gmail.text = ""
        pickerView.selectRow(0, inComponent: 0, animated: true)
        mySeg.selectedSegmentIndex = 0
    }
    private func insert(stud:Student) {
        SqliteHandler.shared.insert(s: stud) { (success) in
            if success {
                print("Insert successfull, recevied mesage at VC")
                self.resetfields()
            } else {
                print("Insert failed, recevied mesage at VC")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //navigationController?.setNavigationBarHidden(false, animated: false)
        view.addSubview(name)
        //view.addSubview(lbl1)
        view.addSubview(phno)
        view.addSubview(gmail)
        view.addSubview(mySeg)
        view.addSubview(pickerView)
        view.addSubview(BirthDatePicker)
        view.addSubview(savebtn)
        view.addSubview(doblbl)
        pickerView.dataSource = self
        pickerView.delegate = self
        if let s = stud {
            name.text = s.name
            phno.text = s.phone
            gmail.text = s.gmail
            mySeg.selectedSegmentIndex = (s.gender == "Male") ? 0 : 1
            var i=0
            for name in course
            {
                if name == s.course {
                    pickerView.selectRow(i, inComponent: 1, animated: true)
                }
                i = i + 1
            }
            
            //BirthDatePicker.date = DateFormatter().date(from: s.dob) ?? DateFormatter().calendar.date(from: <#T##DateComponents#>)
            //pickerView.selectRow(course.indices.fi, inComponent: <#T##Int#>, animated: <#T##Bool#>)
        }
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //lbl1.frame = CGRect(x: 120, y: 0, width: 200, height: 40)
        name.frame = CGRect(x: 40, y: 30, width: view.width - 80, height: 45)
        phno.frame = CGRect(x: 40, y: name.bottom + 30, width: view.width - 80, height: 45)
        gmail.frame = CGRect(x: 40, y: phno.bottom + 30, width: view.width - 80, height: 45)
        mySeg.frame = CGRect(x: 40, y: gmail.bottom + 30, width: view.width - 80, height: 45)
        pickerView.frame = CGRect(x: 40, y: mySeg.bottom + 30, width: view.width - 80, height: 60)
        doblbl.frame = CGRect(x: 140, y: pickerView.bottom, width: 200, height: 25)
        BirthDatePicker.frame = CGRect(x: 40, y: doblbl.bottom + 5, width: view.width - 80, height: 50)
        savebtn.frame = CGRect(x: 40, y: BirthDatePicker.bottom + 20, width: view.width - 80, height: 50)
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
extension NewstudVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
          return course.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return course[row]
        
        
    }
    
    
}
