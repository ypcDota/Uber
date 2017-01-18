//
//  SelectCouryPage.swift
//  Uber
//
//  Created by ypc on 17/1/17.
//  Copyright © 2017年 com.ypc. All rights reserved.
//

import UIKit
// 常量
let kSelectPageId = "kSelectPageId"

class SelectCouryPage: FxBasePage {

    //MARK: - 定义属性
    fileprivate var countrys : [CountryInfo]?
    fileprivate var headers : [String]?
    fileprivate var dictData : [String : Any]?
    
    //MARK: - 控件属性
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.cyan
        self.title = "选择国家/地区"
        // 1.设置 leftBarButtonItem
        self.setUpNavWith(title: "取消", selector: #selector(self.doLeft), isRight: false)
        
        // 2.注册tableViewCell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kSelectPageId)
    }
}
//MARK: - 获取国家列表等数据
extension SelectCouryPage {
    func initCountry() {
        
        let arrCode = NSLocale.isoCountryCodes
        let local : Locale = Locale.current
        
        var info = CountryInfo()
        
        // 遍历
//        for  var code in arrCode {
//            info.code = code
//            info.name = local.localizedString(forScriptCode: <#T##String#>)
//            
//        }
        
        
    }
    
    
}
//MARK: - 数据源
extension SelectCouryPage : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kSelectPageId, for: indexPath)
        
        cell.textLabel?.text = "测试"
        return cell
    }
    
}
