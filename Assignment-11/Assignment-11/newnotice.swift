//
//  newnotice.swift
//  Assignment-11
//
//  Created by DCS on 18/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class newnotice: UIViewController {
    private let lbl1:UILabel = {
        let lbl = UILabel()
        lbl.text = "Add Student"
        lbl.textColor = #colorLiteral(red: 0.1333333333, green: 0.2196078431, blue: 0.262745098, alpha: 1)
        lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 25.0)
        return lbl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(lbl1)
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lbl1.frame = CGRect(x: 0, y: 20, width: 300, height: 50)
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
