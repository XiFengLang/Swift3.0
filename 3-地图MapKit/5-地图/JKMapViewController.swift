//
//  JKMapViewController.swift
//  5-地图
//
//  Created by 蒋鹏 on 16/10/8.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit
import MapKit

class JKMapViewController: FCBaseViewController {

    var mapView: MKMapView?
    var tableView: UITableView?
    var hiddenTableView: UITableView?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        JKLocationManager.shared.startUpdatingLocation()
        
        
        self.view.backgroundColor = UIColor.white
        let mapViewFrame = CGRect.init(x: 0, y: 108, width: JKScreenWidth(), height: JKScreenHeight()*0.4)
        self.mapView = MKMapView.init(frame: mapViewFrame)
        self.mapView?.showsUserLocation = true
        self.mapView?.delegate = self
        self.mapView?.mapType = .standard
        self.mapView?.showsCompass = true
        self.mapView?.userTrackingMode = .follow
        self.mapView?.showsScale = true
        self.view.addSubview(self.mapView!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(JKMapViewController.didReceive(notification:)), name: NSNotification.Name.JKLocation.disable, object: nil)
        
        self.tableView = UITableView.init(frame: CGRect.init(x: 0, y: JKMaxYOfView(self.mapView!), width: JKScreenWidth(), height: JKScreenHeight() - JKMaxYOfView(self.mapView!)), style: .plain)
        self.tableView?.backgroundColor = UIColor.white
        self.tableView?.allowsSelection = true
        self.tableView?.tintColor = UIColor.red
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
//        JKLocationTableViewCell.registerCell(withTableView: self.tableView!)
        
        self.view .addSubview(self.tableView!)
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "还原", style: .plain, target: self, action: #selector(locationToUserPosition(sender:)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let span = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion.init(center: JKLocationManager.shared.userLocation!, span: span)
        self.mapView?.setRegion(region, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.locationToUserPosition(sender: nil)
    }
    

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.mapView?.showsUserLocation = false
        self.mapView?.frame = CGRect.zero
        self.mapView?.removeFromSuperview()
        self.mapView?.delegate = nil
    }
    
    final func locationToUserPosition(sender: UIButton?) {
        sender?.isSelected = true
        self.mapView?.setCenter((self.mapView?.userLocation.coordinate)!, animated: true)
    }
    
    
    final func didReceive(notification: Notification){
        self.jk_popViewController(animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension JKMapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        let location = CLLocation.init(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        JKLocationManager.shared.jkReverseGeocoder(location: location) { (placemark, error) in
            let request: MKLocalSearchRequest = MKLocalSearchRequest.init()
//            let span = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
//            let region = MKCoordinateRegion.init(center: mapView.centerCoordinate, span: span)
            request.region = mapView.region
            request.naturalLanguageQuery = "饭店"
            
            let search: MKLocalSearch = MKLocalSearch.init(request: request)
            search.start { (searchResponse, error) in
                if (error != nil) {
                    JKLOG(error?.localizedDescription)
                }else {
                    self.dataArray.removeAll()
                    for item in (searchResponse?.mapItems)!{
                        self.dataArray.append(item)
                    }
                    self.tableView?.reloadData()
                }
            }
        }
        
//        self.mapView?.removeFromSuperview()
//        self.view.addSubview(self.mapView!)
    }
}

extension JKMapViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = JKLocationTableViewCell.cell(withTableView: tableView)
        let item: MKMapItem = self.dataArray[indexPath.row] as! MKMapItem
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.phoneNumber
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        JKLOG(self.dataArray[indexPath.row])
        let item: MKMapItem = self.dataArray[indexPath.row] as! MKMapItem
        self.mapView?.setCenter(item.placemark.coordinate, animated: true)
    }
}

