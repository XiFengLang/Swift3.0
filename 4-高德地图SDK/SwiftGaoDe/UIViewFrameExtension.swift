//
//  UIViewFrameExtension.swift
//  SwiftGaoDe
//
//  Created by 蒋鹏 on 16/10/9.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    public func x(_ x: CGFloat) -> Void {
        var tempRect = self.frame
        tempRect.origin.x = x
        self.frame = tempRect
    }
    
    public func y(_ y: CGFloat) -> Void {
        var tempRect = self.frame
        tempRect.origin.y = y
        self.frame = tempRect
    }
    
    public func width(_ width: CGFloat) -> Void {
        var tempRect = self.frame
        tempRect.size.width = width
        self.frame = tempRect
    }
    
    
    public func height(_ height: CGFloat) -> Void {
        var tempRect = self.frame
        tempRect.size.height = height
        self.frame = tempRect
    }
}
