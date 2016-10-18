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
}


extension Then where Self: AnyObject {
    public func then( block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension NSObject: Then {}
