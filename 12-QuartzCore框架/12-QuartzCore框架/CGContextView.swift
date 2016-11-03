//
//  CGContextView.swift
//  12-QuartzCore框架
//
//  Created by 蒋鹏 on 16/10/24.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit

class CGContextView: UIView {


    override func draw(_ rect: CGRect) {
        // 获取上下文
        let context = UIGraphicsGetCurrentContext()
        
        context?.move(to: CGPoint.init(x: 0, y: 0))
        context?.addLine(to: CGPoint.init(x: 100, y: 100))
        
        // 显示绘制的内容(空心)
        context?.strokePath()
        // 实心
        //context?.fillPath()
    }

}
