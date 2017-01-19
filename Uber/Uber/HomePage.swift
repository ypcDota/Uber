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

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var carBtn: UIButton!
    //MARK: - 定义属性
    var showingLeft : Bool? = false
    var mapView : BMKMapView?
    var locService : BMKLocationService?
    var userCoordinate : CLLocationCoordinate2D?
    var point : BMKPointAnnotation?
    var carTimer : Timer?
    
    
    //MARK: - 懒加载
    lazy var btnHelper : FxButtonHelper? = FxButtonHelper()
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
    
    //MARK: - 控件方法
    
    @IBAction func changeCarStyle(_ sender: UIButton) {
        btnHelper?.normalImageName = "1.png"
        btnHelper?.selectedImageName = "CarBtn.png"
        
        btnHelper?.setButtonEx(sender)
        
    }
    //MARK: - 系统生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = true
        self.setUpNavWith(title: "account_icon_up.png", selector: #selector(self.leftButtonClick(_:)), isRight: false)
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "logo_uber_grey_zh_CN.png"))
        
        setUpBaiduMap()
        addBackControl()
        self.view.bringSubview(toFront: bottomView)
        
        self.changeCarStyle(carBtn)
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mapView?.delegate = self
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mapView?.delegate = nil
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: -监听控件的点击
     func leftButtonClick(_ sender: Any) {
        if showingLeft! {
            showCenterPanel()
        } else {
            showLeftPanel()
        }
    }
}

// 设置左边的用户中心view
extension HomePage {
    func addBackControl() {
        
        view.addSubview(backControl!)
        // 将backControl 调整到最下面
        view.sendSubview(toBack: backControl!)
    }
    // 点击模板,退出左边的view
    func doTapCenter() {
        // 如果是正在显示leftView, 让他切换显示到
        if showingLeft! {
            showCenterPanel()
        }
    }
    
    // 添加左边的leftView
    func addLeftView() {
        view.addSubview(leftView!)
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
    //MARK: - 显示左边
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
    //MARK: - 显示中间
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

//MARK: - 添加用户中心的控制器view
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

//MARK: - 集成百度地图
//extension HomePage : BMKMapViewDelegate{
//    func setUpBaiduMap() {
//        mapView = BMKMapView(frame: self.view.bounds)
//        view = mapView
//    }
//    
//}
