//
//  UserCenterPage.swift
//  Uber
//
//  Created by ypc on 17/1/18.
//  Copyright © 2017年 com.ypc. All rights reserved.
//

import UIKit

class UserCenterPage: FxBasePage {

    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = true
        view.backgroundColor = UIColor.black

}
    
    @IBAction func btnClick(_ sender: UIButton) {
        print("点击btnClick")
        let setPage = SettingPage()
        
        self.present(setPage, animated: true, completion: nil)
    }
    
}

extension UserCenterPage {
}
