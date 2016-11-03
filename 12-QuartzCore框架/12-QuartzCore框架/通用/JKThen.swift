//
//  Then.swift
//  7-[搬运]令人眼前一亮的初始化方式
//
//  Created by 蒋鹏 on 16/10/11.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import Foundation

public protocol Then {}

extension Then where Self: Any {
    public func then_Any( block: (inout Self) -> Void) -> Self {
        var copy = self
        block(&copy)
        return copy
    }
    
    
    /*
     let  _ = UILabel().then_Any { (label) in
        label.backgroundColor = .blue
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.text = "Then协议库"
        label.frame = CGRect.init(x: 20, y: 200, width: 150, height: 40)
        view.addSubview(label)
     }
     */
}


extension Then where Self: AnyObject {
    public func then( block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
    /*
     let  _ = UILabel().then { (label) in
        label.backgroundColor = .blue
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.text = "Then协议库"
        label.frame = CGRect.init(x: 20, y: 200, width: 150, height: 40)
        view.addSubview(label)
     }
     */
}


extension NSObject: Then {}
