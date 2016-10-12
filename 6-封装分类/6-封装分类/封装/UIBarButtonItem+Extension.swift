//
//  UIBarButtonItem+Extension.swift
//  6-封装分类
//
//  Created by 蒋鹏 on 16/10/12.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    struct RuntimeKey {
        static let button = UnsafeRawPointer.init(bitPattern: "JKUIBarButtonItemRuntimeKeyButton".hashValue)
    }
    
    var button: UIButton? {
        set {
            objc_setAssociatedObject(self, UIBarButtonItem.RuntimeKey.button, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, UIBarButtonItem.RuntimeKey.button) as! UIButton?
        }
    }
    
    
    class func item(withTitle title: String?, target: Any?, action: Selector?, width: CGFloat) -> UIBarButtonItem {
        let button = UIButton.init(type: .custom).then { (button) in
            button.setTitle(title, for: .normal)
            button.bounds = CGRect.init(x: 0, y: 0, width: width, height: 21)
            button.contentMode = .scaleAspectFit
            button.titleLabel?.textAlignment = .left
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            button.setTitleColor(UIColor.black, for: .normal)
            button.setTitleColor(UIColor.lightGray, for: .disabled)
            if (action != nil){
                button.addTarget(target, action: action!, for: .touchUpInside)
            }
        }
        let item = UIBarButtonItem.init(customView: button)
        item.button = button
        return item
    }
    
    
    class func item(withImage image: UIImage?, highlightImage: UIImage?, target: Any?, action: Selector?) -> UIBarButtonItem {
        let button = UIButton.init(type: .custom).then { (button) in
            button.bounds = CGRect.init(x: 0, y: 0, width: 23, height: 21)
            button.imageView?.contentMode = .scaleAspectFit
            if (action != nil){
                button.addTarget(target, action: action!, for: .touchUpInside)
            }
            
            button.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
            button.setImage(highlightImage?.withRenderingMode(.alwaysOriginal), for: .highlighted)
        }
        let item = UIBarButtonItem.init(customView: button)
        item.button = button
        return item
    }
    
    
    
}
