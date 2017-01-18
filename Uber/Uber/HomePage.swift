//
//  HomePage.swift
//  Uber
//
//  Created by ypc on 17/1/18.
//  Copyright © 2017年 com.ypc. All rights reserved.
//

import UIKit

let PanWidth : CGFloat = 100
class HomePage: FxBasePage {

    //MARK: - 定义属性
//    var leftView : UIView?
//    var backControl : UIControl?
    var showingLeft : Bool? = false
    
    //MARK: - 懒加载
    lazy var backControl : UIControl? = {
    
        let frame = self.view.bounds
        let backControl = UIControl(frame: frame)
        backControl.backgroundColor = UIColor.black
        backControl.alpha = 0.0
        backControl.isUserInteractionEnabled = true
        backControl.addTarget(self, action: #selector(self.doTapCenter), for: .touchUpInside)
        return backControl
    }()
    fileprivate lazy var leftView : UIView? = {
        let view = UIView()
        var frame = self.view.bounds
        frame.origin.x = -frame.size.width + PanWidth
        frame.size.width -= PanWidth
        view.frame = frame
        view.isUserInteractionEnabled = true
        view.backgroundColor = UIColor.black
        
        return view
    }()
    //MARK: - 系统生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = true
        addBackControl()
    }
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        addLeftView()
        addUserCenterView()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        showingLeft = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: -监听控件的点击
    @IBAction func leftButtonClick(_ sender: Any) {
        if showingLeft! {
            showCenterPanel()
        } else {
            showLeftPanel()
        }
    }
}

extension HomePage {
    func addBackControl() {
        
        view.addSubview(backControl!)
        // 将backControl 调整到最下面
        view.sendSubview(toBack: backControl!)
    }
    func doTapCenter() {
        // 如果是正在显示leftView, 让他切换显示到
        if showingLeft! {
            showCenterPanel()
        }
    }
    
    // 添加左边的leftView
    func addLeftView() {
        view.addSubview(leftView!)
//        self.navigationController?.view.addSubview(leftView!)
    }
    
    func showCenterView(view:UIView,offset:CGFloat,shadow:Bool) {
        
        if shadow {
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOpacity = 0.2
            view.layer.shadowOffset = CGSize(width: offset, height: offset)
        } else {
            view.layer.cornerRadius = 0.0
            view.layer.shadowOpacity = 0.0
            view.layer.shadowOffset = CGSize(width: offset, height: offset)
        }
    }
    
    func showLeftPanel() {
        showingLeft = true
        showCenterView(view: leftView!, offset: -2, shadow: true)
        
        // 添加动画
        UIView.animate(withDuration: 1.0, delay: 0, options: .beginFromCurrentState, animations: { 
            var frame = self.leftView?.frame
            frame?.origin.x = 0
            self.leftView?.frame = frame!
            
            frame = self.navigationController?.navigationBar.frame
            frame?.origin.x = (frame?.size.width)! - PanWidth
            self.navigationController?.navigationBar.frame = frame!
        }) { (finished : Bool) in
            if finished {
//                view.sendSubview(toBack: backControl!)
                self.backControl?.alpha = 0.2
                self.view.bringSubview(toFront:  self.backControl!)
                self.view.bringSubview(toFront:  self.leftView!)

            }
        }
    }
    
    func showCenterPanel() {
        showingLeft = false
        
        UIView.animate(withDuration: 1.0, delay: 0, options: .beginFromCurrentState, animations: { 
            var frame = self.leftView?.frame
            frame?.origin.x = -(frame?.size.width)!
            self.leftView?.frame = frame!
            
            frame = self.navigationController?.navigationBar.frame
            frame?.origin.x = 0
            self.navigationController?.navigationBar.frame = frame!
        }) { (finished : Bool) in
            if finished {

                self.backControl?.alpha = 0.0
                self.showCenterView(view: self.leftView!, offset: 0, shadow: false)
            }
        }
    }
}

extension HomePage {
    func addUserCenterView() {
        let userCenterPage = UserCenterPage()
        userCenterPage.view.frame = (self.leftView?.bounds)!
        leftView?.isUserInteractionEnabled = true
        self.addChildViewController(userCenterPage)
        // 把用户中新控制器的view 添加到 leftView身上,
        // 这时候一定要记得把控制器添加到另一个控制器上
        leftView?.addSubview(userCenterPage.view)
    }
}
