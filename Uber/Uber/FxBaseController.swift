//
//  FxBaseController.swift
//  Uber
//
//  Created by ypc on 17/1/16.
//  Copyright © 2017年 com.ypc. All rights reserved.
//

import UIKit

class FxBaseController: UIViewController {

    //MARK: - 定义属性
    var activity : FxActivity?
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

//MARK: - 显示加载动画
extension FxBaseController {
    
    func showActivityInview(view : UIView) ->FxActivity {
        let activity = FxActivityIndicator(view: view)
        
        activity?.frame = view.bounds
        view.addSubview(activity!)
        activity?.labelText = ""
        return activity!
    }
    func showIndicator(tipMessage : String?,autoHide : Bool,afterDelay : Bool){
        
        if activity == nil {
            activity = showActivityInview(view: self.view)
        }
        
        if tipMessage != nil {
            activity?.labelText = tipMessage
            activity?.show(false)
        }
        
        if autoHide && CGFloat((activity?.alpha)!) >= 1.0 {
            if afterDelay {
                activity?.hide(true, afterDelay: 1.0)
            }else {
                activity?.hide(true)
            }
        }
    }
    
    func hideIndicator() {
        
        activity?.hide(true)
    }
}
