//
//  UIImageExtension.swift
//  SwiftGaoDe
//
//  Created by 蒋鹏 on 16/10/9.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit
extension UIImage {
    class func image(withColor color: UIColor, imageSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0.0)
        color.set()
        UIRectFill(CGRect.init(origin: CGPoint.zero, size: imageSize))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
