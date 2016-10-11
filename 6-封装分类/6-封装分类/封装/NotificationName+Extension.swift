//
//  JKNotificationNameExtension.swift
//  5-地图
//
//  Created by 蒋鹏 on 16/10/8.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import Foundation
extension Notification.Name {
    
    // 自定义全局静态通知名
    public struct JKLocation{
        public static let disable = Notification.Name.init(rawValue: "JKLocationServicesDisable")
    }
    
    
    
}
