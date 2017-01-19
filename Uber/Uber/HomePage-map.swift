//
//  HomePage-map.swift
//  Uber
//
//  Created by ypc on 17/1/19.
//  Copyright © 2017年 com.ypc. All rights reserved.
//

import Foundation
class CarAnimationView : BMKAnnotationView {
    var imageView : UIImageView?
    override init(annotation:BMKAnnotation!,reuseIdentifier:String!){
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.bounds = CGRect(x: 0, y: 0, width: 32, height: 32)
        self.backgroundColor = UIColor.clear
        imageView = UIImageView(image: UIImage(named: "map-taxi.png"))
        imageView?.frame = self.bounds
        
        self.addSubview(imageView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomePage : BMKMapViewDelegate,BMKGeoCodeSearchDelegate{
    
    // 添加百度地图
    func setUpBaiduMap() {
        mapView = BMKMapView(frame: self.view.bounds)
//        view = mapView
        self.view.addSubview(mapView!)
        startLocation()
        startTimer()
        geoCoder = BMKGeoCodeSearch()
    }
    
    func mapView(_ mapView: BMKMapView!, viewFor annotation: BMKAnnotation!) -> BMKAnnotationView! {
            let car = CarAnimationView(annotation: annotation, reuseIdentifier: "PID")
        car.isDraggable = false
        return car
    }
    
    func mapView(_ mapView: BMKMapView!, regionDidChangeAnimated animated: Bool) {
        
        // 把大头针的坐标转成经纬度
        let point = mapView.convert(tuDindBtn.center, toCoordinateFrom: self.view)
//        print(point)
        let option = BMKReverseGeoCodeOption()
        option.reverseGeoPoint = point
        geoCoder?.reverseGeoCode(option)
        
    }
    
    func onGetReverseGeoCodeResult(_ searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        
        TopLabel.text = result.address
    }
    //
    func startLocation() {
        
        locService = BMKLocationService()
        locService?.delegate = self
        locService?.startUserLocationService()
        mapView?.showsUserLocation = true
        
        userCoordinate = CLLocationCoordinate2D(latitude: 40.115, longitude: 116.404)
        
//        addCars()
    }
    
    func addCars() {
        
        // 首先要对已有的点进行清除
        if point != nil {
            
            mapView?.removeAnnotation(point)
        }
        point = BMKPointAnnotation()
        
        point?.coordinate = CLLocationCoordinate2D(latitude: userCoordinate!.latitude, longitude: (userCoordinate?.longitude)!)
        point?.title = "Car"
        // 大头针添加到地图上
        mapView?.addAnnotation(point)
    }
    
    // 获取从车辆位置到人的位置需要的时间
    func getCarArriveTime() {
    
        let point1 = BMKMapPointForCoordinate(CLLocationCoordinate2D(latitude: 39.915, longitude: 116.404))
        let point2 = BMKMapPointForCoordinate(CLLocationCoordinate2D(latitude: 38.915, longitude: 115.404))
        let distance = BMKMetersBetweenMapPoints(point1, point2)
        let time = distance / (50 * 1000)
        
    }
}

//MARK: - 设置定时器 实时刷新车辆位置
extension HomePage {
    
    // 1.开启定时器
    func startTimer() {
        carTimer = Timer(timeInterval: 10.0, target: self, selector: #selector(self.updateCarNews), userInfo: nil, repeats: true)
        let runloop = RunLoop.current
        runloop.add(carTimer!, forMode: .commonModes)
        carTimer?.fire()
    }
    // 2.关闭定时器
    func stopTimer() {
        carTimer?.invalidate()
    }
    
    func updateCarNews() {
        userCoordinate?.longitude += 0.001
        userCoordinate?.longitude += 0.001
        addCars()
    }
}
//MARK: - 遵守BMKLocationServiceDelegate
extension HomePage : BMKLocationServiceDelegate{
    func didUpdate(_ userLocation: BMKUserLocation!) {
//        userCoordinate?.longitude += 0.01
//        userCoordinate?.longitude += 0.01

//        print("didUpdate")
        addCars()
//        startTimer()
    }
    
}
