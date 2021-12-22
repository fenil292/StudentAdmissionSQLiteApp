//
//  NoticeVC.swift
//  Assignment-11
//
//  Created by DCS on 20/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class NoticeVC: UIViewController {
    private let myTable = UITableView()
    public var notes = [Notice]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let rightbtn = UIBarButtonItem.init(image: #imageLiteral(resourceName: "logout"), style: .done, target: self, action: #selector(logout))
        self.navigationItem.rightBarButtonItem = rightbtn
        view.addSubview(myTable)
        myTable.dataSource = self
        myTable.delegate = self
        myTable.register(UITableViewCell.self, forCellReuseIdentifier: "citycell")
        let course = SqliteHandler.shared.fetch_stud_course(id: Int(UserDefaults.standard.string(forKey: "login_id") ?? "") ?? 0)
        notes = SqliteHandler.shared.fetch_stud_notice(name: course)
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
        myTable.frame = CGRect(x: 0, y: 40, width: view.width, height: view.height - 40)
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
extension NoticeVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return notes.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "citycell", for: indexPath)
        let n = notes[indexPath.row]
        cell.textLabel?.text = "\(n.name) | \(n.notice_date)"
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print([indexPath.row])
        let vc = NoticedispVC()
        vc.notice = notes[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        /*let name = notes[indexPath.row]
        let filepath = FileManagerService.getDocDir().appendingPathComponent("\(name).txt")
        do {
            try FileManager.default.removeItem(at: filepath)
            print("delete")
            self.notes.remove(at: indexPath.row)
            label2.text = "\(notes.count) Notes"
            self.myTable.deleteRows(at: [indexPath], with: .automatic)
        } catch {
            print(error)
        }*/
    }
    /*func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
     if section == 0 {
     return CGRect(x: 0,y: 0, width: view.frame.size.width,
     height: 100)
     }
     }*/
}
