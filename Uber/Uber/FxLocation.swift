////
////  FxLocation.swift
////  Uber
////
////  Created by ypc on 17/1/16.
////  Copyright © 2017年 com.ypc. All rights reserved.
////
//
import UIKit
import CoreLocation
class FxLocation : NSObject{

    //MARK: - 定义属性
    
//    var manager : CLLocationManager?
    lazy var manager : CLLocationManager = CLLocationManager()
    // 反地理编码
    lazy var geCoder : CLGeocoder = CLGeocoder()
    
}

extension FxLocation {
    
    func startLocation() {
        
        // 首先判断当前定位服务是否可用
        if CLLocationManager.locationServicesEnabled() {
            
            manager.distanceFilter = 100
            //定位精确度
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.delegate = self
            
            manager.requestAlwaysAuthorization()
//            manager?.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
            
//            let status = CLLocationManager.authorizationStatus()
//            print(status.hashValue)
        }
    }
    
}

//MARK: - 遵守 代理方法
extension FxLocation : CLLocationManagerDelegate {
    
    
    //因为授权动作是异步的，所以应用不能马上开始使用定位服务。相反，应用中必须实现locationManager:didChangeAuthorizationStatus的代理方法，这个代理方法当用户改变当前的授权权限的时候将会被发送。
    //如果用户上一次授予用户定位服务的权限，这个代理方法将会在定位管理者被初始化之后并且它的代理被设置成正确的授权状态后被调用。这样将便于代码进行定位服务
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(status.hashValue)
        
        
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        
//        print("行吗")
//    }
//
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // 获取最后一次定位
        let currentLocation = locations.last
        
//        FxLog("定位纬度为:\(currentLocation?.coordinate.latitude)")
//        FxLog("定位经度为:\(currentLocation?.coordinate.longitude)")
        
        geCoder.reverseGeocodeLocation(currentLocation!, completionHandler: { (marks, error) -> Void in
            //地理位置信息数据处理
            if error == nil {
                
                FxLog("反地理编码成功")
                for mark in marks! {
                    guard let placeName = mark.name else {return}
                    FxLog(placeName)
                }
            }
            
        })

//        guard let plsResult = pls else {return}
//        let firstPL = plsResult.first
//        self.addressTV.text = firstPL?.name
//        self.latitudeTF.text = "\((firstPL?.location?.coordinate.latitude)!)"
//        self.longitudeTF.text = "\((firstPL?.location?.coordinate.longitude)!)"

//        geCoder.reverseGeocodeLocation(currentLocation!) { (playMarks:[CLPlacemark]?, error:NSError?) in
//            
//        } as! CLGeocodeCompletionHandler

    }
//       Cannot convert value of type '([CLPlacemark]?,NSError?)->()'to expected argument type CLGeocodeCompletionHandler
    func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        
        print("暂停")
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        FxLog("定位失败:\(error)")
    }
//    func searchAddress(location : CLLocation) {
//        
//        // 反地理编码,
//        let coder = CLGeocoder()
//        coder.reverseGeocodeLocation(location) { (marks : [CLPlacemark]?, error : NSError?) in
//            
//            if marks != nil {
//                
//                for mark in marks {
//                    FxLog(mark)
//                }
//            }
//        }
}
//import UIKit
//import CoreLocation

//class FxLocation: NSObject, CLLocationManagerDelegate {
//    var manager:CLLocationManager?
//    
//    func startLocation()
//    {
//        if CLLocationManager.locationServicesEnabled() {
//            manager   = CLLocationManager()
//            
//            manager?.delegate = self
//            manager?.desiredAccuracy = kCLLocationAccuracyBest
//            manager?.distanceFilter = 100
//            
//            manager?.startUpdatingLocation()
//            manager?.requestAlwaysAuthorization()
//        }
//    }
//    
//    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
//        FxLog(String(describing: status))
//    }
//    
//    func searchAddress(location:CLLocation)
//    {
//        let corder = CLGeocoder()
//        
//        corder.reverseGeocodeLocation(location, completionHandler: {
//            (marks:[CLPlacemark]?, error:NSError?) in
//            
//            if marks != nil {
//                for mark in marks! {
//                    FxLog(mark.name!)
//                }
//            }
//        } as! CLGeocodeCompletionHandler)
//    }
//    
//    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation)
//    {
//        searchAddress(location: newLocation)
//    }
//    
//    private func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
//    {
//        searchAddress(location: locations[0])
//        
//        //停止更新位置（如果定位服务不需要实时更新的话，那么应该停止位置的更新）
//        manager.stopUpdatingLocation()
//    }
//}
