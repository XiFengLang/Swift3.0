//
//  ViewControllerCategory.swift
//  6-封装分类
//
//  Created by 蒋鹏 on 16/10/10.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import Foundation

extension ViewController {
    
    // 通过类别给对象拓展属性，使用Runtime绑定属性值
    var jkPro: String? {
        set(newValue) {
            objc_setAssociatedObject(self, "Key", newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, "Key") as? String
        }
    }
    
}
