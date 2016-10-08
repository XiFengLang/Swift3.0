//
//  FCBaseObject.swift
//  4-WKWebView
//
//  Created by 蒋鹏 on 16/9/27.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit

class FCBaseObject: NSObject {
    
    deinit {
        NSLog("\(self.classForCoder)%@已释放")
    }
}
