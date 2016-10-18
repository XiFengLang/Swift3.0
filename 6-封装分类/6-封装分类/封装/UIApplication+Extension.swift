
//
//  UIApplication+Extension.swift
//  6-封装分类
//
//  Created by 蒋鹏 on 16/10/18.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit
extension UIApplication {
    
    func open(withUrl url: String, completionHandler completion:@escaping((Bool) -> Void)) -> Void {
        if iOS10() {
            self.open(URL.init(string: url)!, options: [:], completionHandler: { (successed) in
                completion(successed)
            })
        }else {
            completion(self.openURL(URL.init(string: url)!))
        }
    }
    
}
