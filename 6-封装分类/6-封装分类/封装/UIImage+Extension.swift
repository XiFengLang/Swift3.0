//
//  UIImageExtension.swift
//  SwiftGaoDe
//
//  Created by 蒋鹏 on 16/10/9.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit

enum UIImageContentMode: Int {
    case scaleToFill
    case scaleAspectFit
    case scaleAspectFill
    case bottom
}

extension UIImage {
    
    /// 给图片倒圆角
    func rounding() -> UIImage {
        let newImage = UIImage.roundingImage(image: self, size: self.size)
        if (newImage != nil) {
            return newImage!
        }
        return self
    }
    
    /// 给图片倒圆角
    class func roundingImage(image: UIImage, size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        let radius = size.width * 0.5
        let center = CGPoint.init(x: radius, y: radius)
        context?.addArc(center: center, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI) * 2.0, clockwise: true)
        context?.closePath()
        context?.clip()
        context?.translateBy(x: 0, y: size.height)
        context?.scaleBy(x: 1, y: -1)
        context?.draw(image.cgImage!, in: CGRect.init(origin: CGPoint.zero, size: size))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
    /// 用UIColor绘制图片
    class func image(withColor color: UIColor, size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        color.set()
        UIRectFill(CGRect.init(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 重新绘制对应大小的图片
    func resize(withSize size: CGSize) -> UIImage {
        return self.resize(withSize: size, contentModel: .scaleToFill)
    }
    
    
    /// 重新绘制对应大小的图片
    func resize(withSize size: CGSize, contentModel: UIImageContentMode) -> UIImage {
        var scale = UIScreen.main.scale
        UIGraphicsBeginImageContext(size)
        var bounds = CGRect.zero
        switch contentModel {
        case .scaleToFill:
            bounds.size = size
            break
        case .scaleAspectFit:
            scale = self.size.width / self.size.height
            let tempScale = size.width / size.height
            if scale < tempScale {
                bounds.size = CGSize.init(width: size.height * scale, height: size.height)
                bounds.origin.x = (size.width - bounds.size.width) * 0.5
            }else {
                bounds.size = CGSize.init(width: size.width, height: size.width * scale)
                bounds.origin.x = (size.height - bounds.size.height) * 0.5
            }
            break
        case .scaleAspectFill:
            scale = self.size.width / self.size.height
            let tempScale = size.width / size.height
            if scale > tempScale {
                bounds.size = CGSize.init(width: size.height * scale, height: size.height)
                bounds.origin.x = (size.width - bounds.size.width) * 0.5
            }else {
                bounds.size = CGSize.init(width: size.width, height: size.width * scale)
                bounds.origin.x = (size.height - bounds.size.height) * 0.5
            }
            break
            
        case .bottom:
                scale = self.size.width / self.size.height
                bounds.size = CGSize.init(width: size.width, height: size.width * scale)
                bounds.origin.y = size.height - bounds.size.height
            break
        }
        
        self.draw(in: bounds)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if (newImage != nil) {
            return newImage!
        }
        return self
    }
    
    /// 缩放图片，透明边缘
    func zoom(withScale scale: CGFloat) -> UIImage {
        let size = self.size
        UIGraphicsBeginImageContext(size)
        let bounds = CGRect.init(x: size.width * (1 - scale) * 0.5,
                                 y: size.height * (1 - scale) * 0.5,
                                 width: size.width * scale,
                                 height: size.height * scale)
        self.draw(in: bounds)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    // 拉伸图片(中心位置)
    func stretchImage() -> UIImage {
        let left = self.size.width * 0.499
        let top = self.size.height * 0.499
        return self.resizableImage(withCapInsets: UIEdgeInsets.init(top: top, left: left, bottom: top, right: left), resizingMode: .stretch)
    }
    
    /// 用UIColor绘制圆角图
    class func roundingImage(withColor color: UIColor, size: CGSize, radius: CGFloat) -> UIImage {
        UIGraphicsBeginImageContext(size)
        let beziePath = UIBezierPath.init()
        beziePath.move(to: CGPoint.init(x: radius, y: 0))
        beziePath.addLine(to: CGPoint.init(x: size.width - radius, y: 0))
        beziePath.addArc(withCenter: CGPoint.init(x: size.width - radius,
                                                  y: radius),
                         radius: radius,
                         startAngle: JK_PI() * 1.5,
                         endAngle: JK_PI() * 2.0,
                         clockwise: true)
        
        beziePath.addLine(to: CGPoint.init(x: size.width,
                                           y: size.height - radius))
        beziePath.addArc(withCenter: CGPoint.init(x: size.width - radius,
                                                  y: size.height - radius),
                         radius: radius,
                         startAngle: 0,
                         endAngle: JK_PI() * 0.5,
                         clockwise: true)
        
        beziePath.addLine(to: CGPoint.init(x: radius, y: size.height))
        beziePath.addArc(withCenter: CGPoint.init(x: radius,
                                                  y: size.height - radius),
                         radius: radius,
                         startAngle: JK_PI() * 0.5,
                         endAngle: JK_PI(),
                         clockwise: true)
        
        beziePath.addLine(to: CGPoint.init(x: 0, y: radius))
        beziePath.addArc(withCenter: CGPoint.init(x: radius, y: radius),
                         radius: radius,
                         startAngle: JK_PI(),
                         endAngle: JK_PI() * 1.5,
                         clockwise: true)
        color.setFill()
        beziePath.fill()
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
    /// 带边框的圆角图
    class func roundingImage(withColor color: UIColor, size: CGSize, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) -> UIImage {
        
        UIGraphicsBeginImageContext(size)
        let pointA = CGPoint.init(x: radius, y: borderWidth)
        let pointB = CGPoint.init(x: size.width - radius, y: borderWidth)
        
        let centerA = CGPoint.init(x: size.width - radius, y: radius)
        let pointC = CGPoint.init(x: size.width - borderWidth, y: size.height - radius)
        
        let centerB = CGPoint.init(x: size.width - radius, y: size.height - radius)
        let pointD = CGPoint.init(x: radius, y: size.height - borderWidth)
        
        let centerC = CGPoint.init(x: radius, y: size.height - radius)
        let pointE = CGPoint.init(x: borderWidth, y: radius)
        
        let centerD = CGPoint.init(x: radius, y: radius)
        
        let beziePath = UIBezierPath.init()
        beziePath.move(to: pointA)
        beziePath.addLine(to: pointB)
        beziePath.addArc(withCenter: centerA,
                         radius: radius - borderWidth,
                         startAngle: JK_PI_2() * 3,
                         endAngle: JK_PI_2() * 4,
                         clockwise: true)
        beziePath.addLine(to: pointC)
        beziePath.addArc(withCenter: centerB,
                         radius: radius - borderWidth,
                         startAngle: 0,
                         endAngle: JK_PI_2(),
                         clockwise: true)
        beziePath.addLine(to: pointD)
        beziePath.addArc(withCenter: centerC,
                         radius: radius - borderWidth,
                         startAngle: JK_PI_2(),
                         endAngle: JK_PI(),
                         clockwise: true)
        beziePath.addLine(to: pointE)
        beziePath.addArc(withCenter: centerD,
                         radius: radius - borderWidth,
                         startAngle: JK_PI(),
                         endAngle: JK_PI_2() * 3,
                         clockwise: true)
        color.setFill()
        beziePath.fill()
        
        borderColor.setStroke()
        beziePath.lineWidth = borderWidth
        beziePath.stroke()
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
