//
//  UIFont+Extension.swift
//  6-封装分类
//
//  Created by 蒋鹏 on 16/10/17.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit
extension UIFont {
    
    class func font(forHeight height:CGFloat) -> UIFont {
        return UIFont.font(forHeight: height, referenceFontSize: 17.0)
    }
    
    
    class func font(forHeight height: CGFloat, referenceFontSize: CGFloat) -> UIFont {
        let heightTemp = ("测试字符串" as NSString).size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: referenceFontSize)]).height
        
        let scale = height / heightTemp
        let fontSize = scale * referenceFontSize
        let heightCopy = ("测试字符串" as NSString).size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)]).height
        let scaleTemp = heightCopy / heightTemp / scale
        if (scaleTemp > 1.05 || scaleTemp < 0.95) {
            return UIFont.font(forHeight: height, referenceFontSize: fontSize)
        } else {
            return UIFont.systemFont(ofSize: fontSize)
        }
    }
    
}
