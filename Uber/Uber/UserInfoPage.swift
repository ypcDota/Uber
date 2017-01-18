//
//  UserInfoPage.swift
//  Uber
//
//  Created by ypc on 17/1/17.
//  Copyright © 2017年 com.ypc. All rights reserved.
//

import UIKit

class UserInfoPage: FxBasePage {

    //MARK: - 控件属性
    @IBOutlet weak var headerView: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.title = "建立基本资料"
        // 添加左右 NavBarButtonItem
        self.setUpNavWith(title: "下一步", selector: #selector(self.doRight), isRight: true)
        self.setUpNavWith(title: "取消", selector: #selector(self.doLeft), isRight: false)
        
    }
    
    override func doRight() {
        // 跳转到支付界面
        let payPage = AddPayPage()
        let navPay = UINavigationController(rootViewController: payPage)
        self.present(navPay, animated: true, completion: nil)
        
    }
    //MARK: - 编辑背景图片
    @IBAction func changeHeaderView(_ sender: Any) {
        FxLog("changeHeaderView")
       let imagePickerVc = UIImagePickerController()
        imagePickerVc.sourceType = .photoLibrary
        imagePickerVc.delegate = self
//        let navPicker = UINavigationController(rootViewController: imagePickerVc)
        self.present(imagePickerVc, animated: true, completion: nil)
    }
}

extension UserInfoPage : UIImagePickerControllerDelegate ,UINavigationControllerDelegate{
//    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       headerView.image = info["UIImagePickerControllerOriginalImage"] as! UIImage?
        picker.dismiss(animated: true, completion: nil)
    }
    
}
