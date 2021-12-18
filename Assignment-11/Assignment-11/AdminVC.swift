//
//  StudhomeVC.swift
//  Assignment-11
//
//  Created by DCS on 13/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class AdminVC: UIViewController {
    public var name:String?
    public var studs = [Student]()
    public var notices = [Notice]()
    private let tabBar:UITabBar = {
       let tabbar = UITabBar()
        let item1 = UITabBarItem(title: "Students", image: #imageLiteral(resourceName: "stud"), tag: 1)
        //let item1 = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        let item2 = UITabBarItem(title: "Noticeboard", image: #imageLiteral(resourceName: "notice"), tag: 2)
        //tabbar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8470588235)
        //tabbar.items.selectedImageTintColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        //tabbar.unselectedItemTintColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        tabbar.tintColor = #colorLiteral(red: 0.1333333333, green: 0.2196078431, blue: 0.262745098, alpha: 1)
        let fontAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-bold", size: 15.0)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes as [NSAttributedString.Key : Any], for: .normal)
        //item1.lab
        tabbar.items = [item1,item2]
        tabbar.selectedItem = item1
        return tabbar
    }()
    private let toolBar:UIToolbar = {
        let toolBar = UIToolbar()
        
        let item1 = UIBarButtonItem(title: "Students", style: .plain, target: self, action: nil)
        let fontAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-bold", size: 23.0)]
        item1.setTitleTextAttributes(fontAttributes as [NSAttributedString.Key : Any], for: .normal)
        
        //UIToolbar.appearance().setTitleTextAttributes(fontAttributes as [NSAttributedString.Key : Any], for: .normal)
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let item2 = UIBarButtonItem(image: #imageLiteral(resourceName: "logout"), style: .plain, target: nil, action: nil)
        //let item3 = UIBarButtonItem(barButtonSystemItem: .add, target:self, action: #selector(handleAdd))
        toolBar.items = [space, item1,space,item2]
        //toolBar.items.
        toolBar.tintColor = #colorLiteral(red: 0.1333333333, green: 0.2196078431, blue: 0.262745098, alpha: 1)
        return toolBar
    }()
    private let addbtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("+", for: .normal)
        btn.addTarget(self, action: #selector(btnadd), for: .touchUpInside)
        btn.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.2196078431, blue: 0.262745098, alpha: 1)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 30.0
        btn.titleLabel?.font = UIFont(name: "HelveticaNeue-bold", size: 25.0)
        //btn.font = UIFont(name: "HelveticaNeue-light", size: 30.0)
        return btn
    }()
    /*private lazy var Newstudent: NewstudVC = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        let viewController = storyboard.instantiateViewController(withIdentifier: "NewstudVC") as! NewstudVC
        
        // Add View Controller as Child View Controller
        add(asChildViewController: viewController)
        
        return viewController
    }()*/
    @objc func btnadd()
    {
        btn_click(op: -1)
        
    }
    func btn_click(op: Int)
    {
        print("click")
        if(tabBar.selectedItem?.title == "Noticeboard")
        {
            print("notice")
            let nvc = NewNoticeVC()
            addChild(nvc)
            nvc.view.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
            studentvc.addSubview(nvc.view)
            studentvc.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
            nvc.didMove(toParent: self)
            toolBar.items?.removeAll()
            let item = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: nil, action: #selector(back_btn))
            let item1 = UIBarButtonItem(title: "Add Notice", style: .plain, target: self, action: nil)
            let fontAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-bold", size: 25.0)]
            item1.setTitleTextAttributes(fontAttributes as [NSAttributedString.Key : Any], for: .normal)
            let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let item2 = UIBarButtonItem(image: #imageLiteral(resourceName: "logout"), style: .plain, target: nil, action: nil)
            toolBar.items = [item,space, item1,space,item2]
            //.reloadInputViews()
        }
        else {
            let vc = NewstudVC()
            if op >= 0 {
                vc.stud = studs[op]
            }
            
            addChild(vc)
            vc.view.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
            studentvc.addSubview(vc.view)
            studentvc.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
            toolBar.items?.removeAll()
            let item = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: nil, action: #selector(back_btn))
            let item1 = UIBarButtonItem(title: "Add Student", style: .plain, target: self, action: nil)
            let fontAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-bold", size: 25.0)]
            item1.setTitleTextAttributes(fontAttributes as [NSAttributedString.Key : Any], for: .normal)
            let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let item2 = UIBarButtonItem(image: #imageLiteral(resourceName: "logout"), style: .plain, target: nil, action: nil)
            toolBar.items = [item,space, item1,space,item2]
            vc.didMove(toParent: self)
        }
    }
    @objc func back_btn()
    {
        
        let vc = AdminVC()
        //self.dismiss(animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
        /*studentvc.removeFromSuperview()
        let subvc:UIView = {
            let sb = UIView()
            sb.backgroundColor = .white
            /*sb.layer.borderWidth = 1.0
             sb.layer.cornerRadius = 20.0*/
            return sb
        }()
        studentvc = subvc
        view.addSubview(studentvc)
        //studentvc.addSubview(UIView())
        studentvc.addSubview(myTable)
        //studentvc.addSubview(toolBar)
        studentvc.addSubview(addbtn)
        //studentvc.reloadInputViews()
        //toolBar.items?.removeFirst()
        //toolBar.setItems(UIBarButtonItem(, animated: true)
        //toolbarItems?.removeFirst()
        //toolBar.items?.removeAll()
        DispatchQueue.main.async {
            self.toolBar.items?.removeAll()
        }
        let item1 = UIBarButtonItem(title: "Students", style: .plain, target: self, action: nil)
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let item2 = UIBarButtonItem(image: #imageLiteral(resourceName: "logout"), style: .plain, target: nil, action: nil)
        let fontAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-bold", size: 23.0)]
        item1.setTitleTextAttributes(fontAttributes as [NSAttributedString.Key : Any], for: .normal)
        
        toolBar.items = [space, item1,space,item2]*/
    }
    /*func remove_item()
    {
        toolBar.items?.remove(at: 0)
    }*/
    private let myTable = UITableView()
    
    private var city = ["Surat", "Navsari", "Mumbai", "Bhopal", "Delhi", "Kolkta", "Navsari", "Mumbai", "Bhopal", "Delhi", "Kolkta", "Navsari", "Mumbai", "Bhopal", "Delhi", "Kolkta", "Navsari", "Mumbai", "Bhopal", "Delhi", "Kolkta", "Navsari", "Mumbai", "Bhopal", "Delhi", "Kolkta"]
    private var studentvc:UIView = {
        let sb = UIView()
        sb.backgroundColor = .white
        /*sb.layer.borderWidth = 1.0
        sb.layer.cornerRadius = 20.0*/
        return sb
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        myTable.dataSource = self
        myTable.delegate = self
        myTable.register(UITableViewCell.self, forCellReuseIdentifier: "citycell")
        tabBar.delegate = self
        view.addSubview(tabBar)
        view.addSubview(toolBar)
        view.addSubview(studentvc)
        studentvc.addSubview(myTable)
        studentvc.addSubview(addbtn)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        studs = SqliteHandler.shared.fetch()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let tabBarHeight:CGFloat = view.safeAreaInsets.bottom + 60.0
        tabBar.frame = CGRect(x: 0, y: view.height - tabBarHeight, width: view.width, height: tabBarHeight)
        let toolBarHeight:CGFloat = view.safeAreaInsets.top + 60.0
        toolBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: toolBarHeight)
        studentvc.frame = CGRect(x: 0, y: toolBar.bottom, width: view.width, height: view.height - toolBar.bottom - tabBar.height)
        myTable.frame = CGRect(x: 0, y: 0, width: view.width - 20, height: studentvc.height)
        addbtn.frame = CGRect(x: 280, y: 460 , width: 60, height: 60)
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
extension AdminVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tabBar.selectedItem?.title == "Students" {
         return studs.count
        } else {
            return notices.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "citycell", for: indexPath)
        if tabBar.selectedItem?.title == "Students" {
            let s = studs[indexPath.row]
            cell.textLabel?.text = "\(s.id) \t | \t \(s.name) \t | \t \(s.course)"
            return cell
        }
        else {
            let s = notices[indexPath.row]
            cell.textLabel?.text = "\t \(s.name) "
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(studs[indexPath.row])
        btn_click(op: indexPath.row)
    }
    
    /*func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
     if section == 0 {
     return CGRect(x: 0,y: 0, width: view.frame.size.width,
     height: 100)
     }
     }*/
}
extension AdminVC: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title == "Students" {
                print("ddd")
            studs = SqliteHandler.shared.fetch()
            myTable.reloadData()
        }
        else {
            print("ssf")
            studs.removeAll()
            notices = SqliteHandler.shared.fetch_notice()
            DispatchQueue.main.async {
                self.myTable.reloadData()
            }
        }
    }
    /*func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        print("ddd123")
    }*/
}
