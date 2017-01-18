//
//  CreatAccountPage.swift
//  Uber
//
//  Created by ypc on 17/1/17.
//  Copyright © 2017年 com.ypc. All rights reserved.
//

import UIKit

class CreatAccountPage: FxBasePage {

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.navigationController?.title = "创建账户"
        self.title = "创建账户"
        self.setUpNavWith(title: "下一步", selector: #selector(doRight), isRight: true)
        self.setUpNavWith(title: "取消", selector: #selector(doLeft), isRight: false)
    }
    @IBAction func changeCountryClick(_ sender: Any) {
        
        FxLog("changeCountryClick")
        let selectCouryPage = SelectCouryPage()
        let navSelect = UINavigationController(rootViewController: selectCouryPage)
        self.present(navSelect, animated: true, completion: nil)
    }
}
//MARK: - 重写父类的方法
extension CreatAccountPage {
    
    override func doRight() {
        FxLog("doRight")
        // 跳转到设置用户信息界面
        let userInfoPage = UserInfoPage()
        let navUser = UINavigationController(rootViewController: userInfoPage)
//        self.navigationController?.pushViewController(navUser, animated: true)
        self.present(navUser, animated: true, completion: nil)
    }
    
}
