//
//  JKNavigationViewController.swift
//  SwiftGaoDe
//
//  Created by 蒋鹏 on 16/10/10.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit

class JKNavigationViewController: FCBaseViewController {

    lazy var driverManager: AMapNaviDriveManager? = {
        var manager = AMapNaviDriveManager.init()
        manager.delegate = self
        return manager
    }()
    var driverView: AMapNaviDriveView?
    var startPoint: AMapNaviPoint?
    var endPoint: AMapNaviPoint?
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.driverView = AMapNaviDriveView.init(frame: self.view.bounds)
        self.driverView?.delegate = self
        
        // 进行关联
        self.driverManager?.addDataRepresentative(self.driverView!)
        self.view.addSubview(self.driverView!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.driverManager?.calculateDriveRoute(withStart: [self.startPoint!],
                                                end: [self.endPoint!],
                                                wayPoints: nil,
                                                drivingStrategy: AMapNaviDrivingStrategy.singleAvoidHighwayAndCostAndCongestion)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension JKNavigationViewController: AMapNaviDriveManagerDelegate{
    func driveManager(onCalculateRouteSuccess driveManager: AMapNaviDriveManager) {
        // 路径规划成功，开始仿真导航
//        self.driverManager?.startEmulatorNavi()
        self.driverManager?.startGPSNavi()
    }
    
    // 路径规划失败
    func driveManager(_ driveManager: AMapNaviDriveManager, onCalculateRouteFailure error: Error) {
        JKLOG(error)
        
    }
    
    func driveManager(_ driveManager: AMapNaviDriveManager, error: Error) {
        JKLOG(error)
    }
}

extension JKNavigationViewController: AMapNaviDriveViewDelegate {
    // 点击底部的关闭按钮
    func driveViewCloseButtonClicked(_ driveView: AMapNaviDriveView) {
        self.dismiss(animated: true) { 
            self.driverManager?.delegate = nil
            self.driverView?.delegate = nil
            self.driverView?.removeFromSuperview()
        }
    }
}
