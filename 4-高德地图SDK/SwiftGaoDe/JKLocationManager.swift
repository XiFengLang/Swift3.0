//
//  JKLocationManager.swift
//  5-地图
//
//  Created by 蒋鹏 on 16/9/30.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit



/// Block类型别名
public typealias JKGeocodeCompletionHandler = ([AMapGeocode]?, Error?) -> Void
public typealias JKReGeocodeCompletionHandler = (AMapReGeocode?, Error?) -> Void


class JKLocationManager: NSObject,AMapLocationManagerDelegate {
//    let JKGeocoderKey = "JKGeocoderKey"
//    let JKRegeocoderKey = "JKRegeocoderKey"
    var geocodeCompletionHandler: JKGeocodeCompletionHandler?
    var reGeocodeCompletionHandler: JKReGeocodeCompletionHandler?
    
    
    // 推荐的单例写法
    static let shared = JKLocationManager()
    private override init() { // 防止外部初始化
        super.init()
        self.initialization()
    }
    
    var appLocationServerEnable: Bool?
    var userLocation: CLLocationCoordinate2D?
    var currentCity: String?

    
    
    // getter方法写法
    var globalLocationServerEnable : Bool {
        get {
            return CLLocationManager.locationServicesEnabled()
        }
    }
    
    
    // 懒加载写法
    lazy var locationManager: AMapLocationManager = {
        var manager = AMapLocationManager.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 10.0
        manager.reGeocodeTimeout = 3
        manager.locationTimeout = 5
        return manager
    }()
    lazy var search: AMapSearchAPI = {
        let search = AMapSearchAPI.init()
        search?.delegate = self
        return search!
    }()
    
    
    private func initialization() {
        self.userLocation = CLLocationCoordinate2D.init(latitude: 0, longitude: 0)
    }
    
    ///  获取定位信息
    final func startUpdatingLocation() {
        self.appLocationServerEnable = true
        self.locationManager.startUpdatingLocation()
    }
    
    
    // 定位成功
    func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!) {
        manager.stopUpdatingLocation()
        self.appLocationServerEnable = true
        
        if (self.userLocation?.latitude != location?.coordinate.latitude || self.userLocation?.longitude != location?.coordinate.longitude) {
            self.userLocation = location?.coordinate
        }
        
        // 获取城市信息
        self.jkReverseGeocoder(location: location.coordinate) {[weak self] (reGeocode, error) in
            if (error != nil) {
                JKLOG(error?.localizedDescription)
            } else {
                self?.currentCity = reGeocode?.addressComponent.city
                JKLOG("\(reGeocode?.formattedAddress)\n\(reGeocode?.addressComponent)")
            }
        }
    }
    
    // 定位失败
    func amapLocationManager(_ manager: AMapLocationManager!, didFailWithError error: Error!) {
        self.userLocation = CLLocationCoordinate2D.init(latitude: 0, longitude: 0)
        self.appLocationServerEnable = false
        NotificationCenter.default.post(name: NSNotification.Name.JKLocation.disable, object: nil)
    }
    
    
    /// 测距
    func distance(betweenLocation locationA: CLLocation, andLocation locationB: CLLocation) -> String {
        let locationDistance = locationA.distance(from: locationB)
        return String.init(format: "%.3f", locationDistance/1000.0)
    }
    
    
    
//    /// 测距
//    func distance(fromLocationCoordinate locationA: CLLocationCoordinate2D, toLocationCoordinate locationB: CLLocationCoordinate2D) -> String {
//        let pointA = MKMapPointForCoordinate(locationA)
//        let pointB = MKMapPointForCoordinate(locationB)
//        let distance = MKMetersBetweenMapPoints(pointA, pointB)
//        return String.init(format: "%.3f", distance/1000.0)
//    }
}


extension JKLocationManager:AMapSearchDelegate {
    
    // 在分类中添加static静态常量属性会直接报错，无论加没加@nonobjc
    //  error: a declaration cannot be both 'final' and 'dynamic'
    // static let JKRegeocoderKey = "JKRegeocoderKey"
    
    // 在分类中添加属性同样报错
    // let JKGeocoderKey = "JKGeocoderKey"
    
    /// 正向地理编码（地名-->坐标）
    func jkGeocoder(address: String, city: String?, completionHandler: @escaping JKGeocodeCompletionHandler) -> Void {
        let request = AMapGeocodeSearchRequest.init()
        request.address = address
        request.city = city
        self.search.aMapGeocodeSearch(request)
        

        // 用runtime绑定Block，绑定字符串无事，编译时报错Showing Recent Issues Command failed due to signal: Segmentation fault: 11
        // 解决方案：completionHandler as AnyObject
        // objc_setAssociatedObject(self, "key", completionHandler as AnyObject, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        
        self.geocodeCompletionHandler = completionHandler
    }
    
    func onGeocodeSearchDone(_ request: AMapGeocodeSearchRequest!, response: AMapGeocodeSearchResponse!) {
        self.geocodeCompletionHandler?(response.geocodes,nil)
        self.geocodeCompletionHandler = nil
    }
    
    
    /// 反向地理编码（坐标-->地名）
    func jkReverseGeocoder(location: CLLocationCoordinate2D,completionHandler: @escaping JKReGeocodeCompletionHandler) -> Void {
        let request = AMapReGeocodeSearchRequest.init()
        request.radius = 1000
        let point = AMapGeoPoint.location(withLatitude: CGFloat(location.latitude), longitude: CGFloat(location.longitude))
        request.location = point
        request.requireExtension = true
        self.search.aMapReGoecodeSearch(request)
        
        self.reGeocodeCompletionHandler = completionHandler
    }
    

    
    func onReGeocodeSearchDone(_ request: AMapReGeocodeSearchRequest!, response: AMapReGeocodeSearchResponse!) {
        self.reGeocodeCompletionHandler?(response.regeocode,nil)
        self.reGeocodeCompletionHandler = nil
    }
    
    func aMapSearchRequest(_ request: Any!, didFailWithError error: Error!) {
//        if let completionHandler: JKGeocodeCompletionHandler = objc_getAssociatedObject(self, self.JKGeocoderKey) as? JKGeocodeCompletionHandler {
//            completionHandler(nil,error)
//            objc_removeAssociatedObjects(self)
//        }else if let completionHandler: JKReGeocodeCompletionHandler = objc_getAssociatedObject(self, self.JKRegeocoderKey) as? JKReGeocodeCompletionHandler{
//            completionHandler(nil,error)
//            objc_removeAssociatedObjects(self)
//        }
        
        if (self.geocodeCompletionHandler != nil) {
            self.geocodeCompletionHandler?(nil,error)
            self.geocodeCompletionHandler = nil
        }else if (self.reGeocodeCompletionHandler != nil) {
            self.reGeocodeCompletionHandler?(nil,error)
            self.reGeocodeCompletionHandler = nil
        }
        
        JKLOG(error.localizedDescription)
    }
}

