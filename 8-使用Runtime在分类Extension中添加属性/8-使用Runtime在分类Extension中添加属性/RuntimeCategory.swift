//
//  ViewControllerCategory.swift
//  6-封装分类
//
//  Created by 蒋鹏 on 16/10/10.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//  fatal error: unexpectedly found nil while unwrapping an Optional value

import Foundation

// 通过类别给对象拓展属性，使用Runtime绑定属性值
extension ViewController {
    
    // 平常写法
//    var jkPro: String? {
//        set {
//            objc_setAssociatedObject(self, "key", newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
//        }
//        
//        get {
//            return objc_getAssociatedObject(self, "key") as? String
//        }
//    }
    
    
    // 平常写法加判断
//    var jkPro: String? {
//        set {
//            objc_setAssociatedObject(self, "key", newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
//        }
//        
//        get {
//            let obj = objc_getAssociatedObject(self, "key") as? String
//            if obj != nil {
//                return obj
//            }
//            return String()
//        }
//    }
    
    
    // 改进写法(推荐)
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
