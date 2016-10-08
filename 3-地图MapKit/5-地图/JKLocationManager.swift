//
//  JKLocationManager.swift
//  5-地图
//
//  Created by 蒋鹏 on 16/9/30.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation
import MapKit



/// Block类型别名
public typealias JKGeocodeCompletionHandler = (CLPlacemark?, Error?) -> Void



class JKLocationManager: NSObject,CLLocationManagerDelegate {
    
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
    lazy var locationManager: CLLocationManager = {
        var manager = CLLocationManager.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 100.0
        return manager
    }()
    lazy var geocoder : CLGeocoder = { return CLGeocoder.init() }()
    
    
    private func initialization() {
        self.userLocation = CLLocationCoordinate2D.init(latitude: 0, longitude: 0)
    }
    
    ///  获取定位信息
    final func startUpdatingLocation() {
        self.appLocationServerEnable = true
        
        if Bundle.main.object(forInfoDictionaryKey: "NSLocationAlwaysUsageDescription") != nil {
            self.locationManager.requestWhenInUseAuthorization()
        }
        if Bundle.main.object(forInfoDictionaryKey: "NSLocationWhenInUseUsageDescription") != nil {
            self.locationManager.requestWhenInUseAuthorization()
        }
        
        
        self.locationManager.startUpdatingLocation()
    }
    
    
    /// 定位成功
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        self.appLocationServerEnable = true
        let location = locations.first
        if (self.userLocation?.latitude != location?.coordinate.latitude || self.userLocation?.longitude != location?.coordinate.longitude) {
            self.userLocation = location?.coordinate
        }
        
        // 正向地理编码
        self.jkReverseGeocoder(location: location!) {[weak self] (placeMark, error) in
            self?.currentCity = placeMark?.addressDictionary?["City"] as! String?
            JKLOG(placeMark?.addressDictionary?["FormattedAddressLines"])
            JKLOG(self?.currentCity)
        }
    }
    
    /// 定位失败
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
        self.userLocation = CLLocationCoordinate2D.init(latitude: 0, longitude: 0)
        self.appLocationServerEnable = false
        NotificationCenter.default.post(name: NSNotification.Name.JKLocation.disable, object: nil)
    }
    
    
    
    
    
    
    /// 正向地理编码（地名-->坐标）
    func jkGeocoder(address: String,completionHandler: @escaping JKGeocodeCompletionHandler) -> Void {
        self.geocoder.geocodeAddressString(address) { (placemarks, error) in
            completionHandler(placemarks?.last,error)
        }
    }
    
    
    
    /// 反向地理编码（坐标-->地名）
    func jkReverseGeocoder(location: CLLocation,completionHandler: @escaping JKGeocodeCompletionHandler) -> Void {
        self.geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            completionHandler(placemarks?.last,error)
        }
    }
    
    
    
    /// 测距
    func distance(betweenLocation locationA: CLLocation, andLocation locationB: CLLocation) -> String {
        let locationDistance = locationA.distance(from: locationB)
        return String.init(format: "%.3f", locationDistance/1000.0)
    }
    
    
    
    /// 测距
    func distance(fromLocationCoordinate locationA: CLLocationCoordinate2D, toLocationCoordinate locationB: CLLocationCoordinate2D) -> String {
        let pointA = MKMapPointForCoordinate(locationA)
        let pointB = MKMapPointForCoordinate(locationB)
        let distance = MKMetersBetweenMapPoints(pointA, pointB)
        return String.init(format: "%.3f", distance/1000.0)
    }
}
