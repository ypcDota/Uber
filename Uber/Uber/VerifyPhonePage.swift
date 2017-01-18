//
//  VerifyPhonePage.swift
//  Uber
//
//  Created by ypc on 17/1/18.
//  Copyright © 2017年 com.ypc. All rights reserved.
//

import UIKit

class VerifyPhonePage: FxBasePage {

    //MARK: - 控件属性
    @IBOutlet weak var number1: UITextField!
    @IBOutlet weak var number2: UITextField!
    @IBOutlet weak var number3: UITextField!
    @IBOutlet weak var number4: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "确认手机"
        self.setUpNavWith(title: "返回", selector: #selector(self.doLeft), isRight: false)
        
        number1.becomeFirstResponder()
    }
    // 监听4个textLabel的编辑
    @IBAction func doValueChange(_ textField: UITextField) {
        let tag = textField.tag
        print(tag)
        // 判断 如果 textField 是空的
        if textField.text!.isEmpty {
            if tag - 1 > 0 { // 如果不是第一个
                // 取出上一个格子,使它成为第一响应者 ,聚焦
                let preField = self.view.viewWithTag(tag - 1) as! UITextField
                preField.becomeFirstResponder()
            }
        
        } else {
            if tag + 1 <= 4 { // 如果不是最后一个
                //
                let nextField = self.view.viewWithTag(tag + 1) as! UITextField
                nextField.becomeFirstResponder()
            }
        }
        
        // 如果是最后一个,表示出入完成
        if tag == 4 {
            textField.resignFirstResponder()
            // 进行验证
            doVerify()
        }
    }
    
    
}

extension VerifyPhonePage {
    
    func doVerify() {
    self.showIndicator(tipMessage: "验证中", autoHide: true, afterDelay: true)
        // 验证完毕后跳转到主页
        self.perform(#selector(self.doShowHomePage), with: nil, afterDelay: 1.0)
    }
    
    func doShowHomePage() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.showHomePage()
    }
}






