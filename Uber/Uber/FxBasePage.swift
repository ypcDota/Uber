//
//  FxBasePage.swift
//  Uber
//
//  Created by ypc on 17/1/16.
//  Copyright © 2017年 com.ypc. All rights reserved.
//

import UIKit

class FxBasePage: FxBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension FxBasePage {
    
    func setUpNavWith(title:String,selector:Selector,isRight:Bool) {
        
        var item : UIBarButtonItem?
        
        if title.hasSuffix("png"){// 如果title后缀有png,说明需要给item设置图片
            
            
           item = UIBarButtonItem(image:UIImage(named: title), style: UIBarButtonItemStyle.plain, target: self, action: selector)
        } else {
            
            item = UIBarButtonItem(title: title, style: .plain, target: self, action: selector)
        }
        
        item?.tintColor = UIColor.darkGray
        if isRight { // 如果是设置rightBarButtonItem
            
            self.navigationItem.rightBarButtonItem = item
        } else {
            self.navigationItem.leftBarButtonItem = item
        }
    }
    
    func doRight() {
    
    }
    
    
    func doLeft() {
        
    self.dismiss(animated: true, completion: nil)
        
//        if (self.navigationController?.viewControllers.count)! > 1{
//            
//            self.navigationController?.popViewController(animated: true)
//        } else {
//            self.dismiss(animated: true, completion: nil)
//        }
   }
}
