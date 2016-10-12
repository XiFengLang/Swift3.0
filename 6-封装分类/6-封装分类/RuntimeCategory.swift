//
//  ViewControllerCategory.swift
//  6-封装分类
//
//  Created by 蒋鹏 on 16/10/10.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//  fatal error: unexpectedly found nil while unwrapping an Optional value

import Foundation


extension ViewController {
    
    var jkPro: String? {
        set {
            let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "key".hashValue)
            objc_setAssociatedObject(self, key, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
        get {
            let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "key".hashValue)
            let obj: String? = objc_getAssociatedObject(self, key) as? String
            return obj
        }
    }
    
}
