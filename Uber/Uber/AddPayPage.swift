//
//  AddPayPage.swift
//  Uber
//
//  Created by ypc on 17/1/17.
//  Copyright © 2017年 com.ypc. All rights reserved.
//

import UIKit
//MARK: - 常量
let kReUsedid = "kReUsedid"
class AddPayPage: FxBasePage {

    //MARK: - 控件属性
    @IBOutlet weak var tableView: UITableView!
    //MARK: - 懒加载
    fileprivate lazy var datas : [PayInfo] = [PayInfo]()
    //MARK: - 系统的生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow
        self.title = "添加付款方式"
        
        self.setUpNavWith(title: "返回", selector: #selector(self.doLeft), isRight: false)
        self.setUpNavWith(title: "验证", selector: #selector(self.doVerifyPhonePage), isRight: true)
        
        //注册tableViewCell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kReUsedid)
        // 初始化数据
        setUpData()
    }
    
    func doVerifyPhonePage() {
    let verifyPage = VerifyPhonePage()
        let NavVerify = UINavigationController(rootViewController: verifyPage)
        self.present(NavVerify, animated: true, completion: nil)
//        showHomePage()
    }
    
    fileprivate func showHomePage() {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        
        appdelegate.showHomePage()
    
    }
}

//MARK: - 初始化数据
extension AddPayPage {
    func setUpData() {
        var data : PayInfo?
        let dict : [String : String] = ["百度钱包":"BaiDuWallet.png","银联":"YinLian.png","支付宝":"AliPay.png","国际信用卡":"CreditCard.png"]
        // 遍历字典 字典转模型
        for (key,value) in dict {
            data = PayInfo()
            data?.name = key
            data?.icon = value
            datas.append(data!)
        }
    }
}

//MARK: - 数据源
extension AddPayPage : UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kReUsedid, for: indexPath)
        let data = datas[indexPath.row]
        cell.textLabel?.text = data.name
        cell.imageView?.image = UIImage(named: data.icon)
         return cell
    }
}
//MARK: - 代理
extension AddPayPage : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let yinlianPage = YinLianPage()

        self.present(yinlianPage, animated: true, completion: nil)
    }
}
