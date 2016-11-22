//
//  UIColor+Extension.swift
//  6-封装分类
//
//  Created by 蒋鹏 on 16/10/11.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class var JKThemColor_Yellow: UIColor {
        get {
            return UIColor.RGB(r: 254, g: 212, b: 48)!
        }
    }
    
    class var JKThemColor_Dark: UIColor {
        get {
            return UIColor.RGB(r: 32, g: 44, b: 61)!
        }
    }
    
    
    class var JKThemColor_Light: UIColor {
        get {
            return UIColor.RGB(r: 116, g: 116, b: 116)!
        }
    }
    
    
    class var JKThemColor_Mid: UIColor {
        get {
            return UIColor.RGB(r: 77, g: 77, b: 77)!
        }
    }
    
    
    class func RGB_Float(r:CGFloat,g:CGFloat,b:CGFloat) -> UIColor? {
        return UIColor.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    class func RGB(r:Int,g:Int,b:Int) -> UIColor? {
        return UIColor.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
    
    func alpha(_ alpha: CGFloat) -> UIColor {
        return self.withAlphaComponent(alpha)
    }
    
    
}
