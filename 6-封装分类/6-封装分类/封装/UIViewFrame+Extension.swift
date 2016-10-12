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
    
    public var x: CGFloat {
        set(newValue) {
            var tempRect = self.frame
            tempRect.origin.x = newValue
            self.frame = tempRect
        }
        
        get {
            return self.frame.origin.x
        }
    }
    
    public var y: CGFloat {
        set(newValue) {
            var tempRect = self.frame
            tempRect.origin.y = newValue
            self.frame = tempRect
        }
        
        get {
            return self.frame.origin.y
        }
    }
    
    public var width: CGFloat {
        set(newValue) {
            var tempRect = self.frame
            tempRect.size.width = newValue
            self.frame = tempRect
        }
        
        get {
            return self.frame.size.width
        }
    }
    
    public var height: CGFloat {
        set(newValue) {
            var tempRect = self.frame
            tempRect.size.height = newValue
            self.frame = tempRect
        }
        
        get {
            return self.frame.size.height
        }
    }
    
    public var centerX: CGFloat {
        set(newValue) {
            var tempCenter = self.center
            tempCenter.x = newValue
            self.center = tempCenter
        }
        
        get {
            return self.center.x
        }
    }
    
    
    public var size: CGSize {
        set {
            self.frame.size = newValue
        }
        get {
            return self.frame.size
        }
    }
    
    public var centerY: CGFloat {
        set(newValue) {
            var tempCenter = self.center
            tempCenter.y = newValue
            self.center = tempCenter
        }
        
        get {
            return self.center.y
        }
    }
    
    public var maxX: CGFloat {
        get {
            return self.frame.maxX
        }
    }
    
    public var maxY: CGFloat {
        get {
            return self.frame.maxY
        }
    }
    
    public var midX: CGFloat {
        get {
            return self.frame.midX
        }
    }
    
    public var midY: CGFloat {
        get {
            return self.frame.midY
        }
    }
    
    
}
