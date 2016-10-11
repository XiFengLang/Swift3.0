//
//  UIView+Factory.swift
//  6-封装分类
//
//  Created by 蒋鹏 on 16/10/11.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    class func jk_view(withFrame frame: CGRect, backgroundColor: UIColor) -> UIView {
        return UIView.init(frame: frame).then(block: { (view) in
            view.backgroundColor = backgroundColor
        })
    }
    
    class func jk_label(withFrame frame: CGRect, text: String?, font: UIFont) -> UILabel {
        return UILabel.init(frame: frame).then(block: { (label) in
            label.text = text
            label.textColor = UIColor.black
            label.backgroundColor = UIColor.white
            label.font = font
        })
    }
    
    /// 多行居中的label
    class func jk_label_WordWrap(withFrame frame: CGRect, text: String?, font: UIFont) -> UILabel {
        return UILabel.init(frame: frame).then(block: { (label) in
            label.text = text
            label.textColor = UIColor.black
            label.backgroundColor = UIColor.white
            label.font = font
            // label.textAlignment = .center
            label.numberOfLines = 0
        })
    }
    
    class func jk_imageView(withFrame frame: CGRect, image: UIImage?) -> UIImageView {
        return UIImageView.init(frame: frame).then(block: { (imageView) in
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            imageView.backgroundColor = UIColor.white
        })
    }
    
    
    
    
    
    
    
}
