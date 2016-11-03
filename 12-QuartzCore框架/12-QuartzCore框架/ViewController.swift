//
//  ViewController.swift
//  12-QuartzCore框架
//
//  Created by 蒋鹏 on 16/10/24.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit

class ViewController: JKBaseViewController {

    var layer: CALayer?
    var iconImageView: UIImageView?
    var leftImage: UIImage?
    var rightImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.layer = CALayer.init()
        self.layer?.backgroundColor = UIColor.red.cgColor
        self.layer?.bounds = CGRect.init(x: 0, y: 0, width: 100, height: 100)
        self.layer?.position = CGPoint.init(x: 160, y: 180)
        self.view.layer.addSublayer(self.layer!)
        
        
        self.iconImageView = UIImageView.imageView(withFrame: CGRect.init(x: 80, y: 300, width: 100, height: 100), image: nil)
        self.view.addSubview(self.iconImageView!)
        self.iconImageView?.backgroundColor = UIColor.white
        
        self.leftImage = UIImage.image(withColor: UIColor.red, size: CGSize.init(width: 100, height: 100))
        self.rightImage = UIImage.image(withColor: UIColor.blue, size: CGSize.init(width: 100, height: 100))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "CGContext", style: .plain, target: self, action: #selector(ContextRef))
    }
    
    
    func ContextRef() -> () {
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       // let touch = touches.first
        
        

/**
         【移动】
         
         let animation = CABasicAnimation.init()
         animation.keyPath = "position"
         
         // 不设置fromValue的时候从当前位置出发
         // animation.fromValue = NSValue.init(cgPoint: CGPoint.init(x: 100, y: 100))
         animation.toValue = NSValue.init(cgPoint: (touch?.location(in: self.view))!)
         // 在当前位置上增加多少
         // animation.byValue = NSValue.init(cgPoint: CGPoint.init(x: 200, y: 300))
 */
 
/**
         【闪烁】
         
         let animation = CABasicAnimation.init()
         animation.keyPath = "opacity"
         animation.fromValue = NSNumber.init(value: 1)
         animation.toValue = NSNumber.init(value: 0.3)
         // 还原初始状态
         animation.autoreverses = true
*/
        
/**
         【缩放】
         
         let animation = CABasicAnimation.init()
         animation.keyPath = "bounds"
         animation.toValue = NSValue.init(cgRect: CGRect.init(x: 0, y: 0, width: 300, height: 300))
         animation.autoreverses = true
*/
        
/**
         【旋转】
         
         let animation = CABasicAnimation.init()
         animation.keyPath = "transform"
         animation.byValue = NSValue.init(caTransform3D: CATransform3DMakeRotation(CGFloat(M_PI_4), 1, 1, 0))
         // http://www.jianshu.com/p/69ba0a4b2df9
*/
        
/**
         【抖动】
         
         let animation = CAKeyframeAnimation.init()
         animation.keyPath = "transform.rotation"
         animation.values = [NSNumber.init(value: JK_Angle(-10)),
         NSNumber.init(value: JK_Angle(10)),
         NSNumber.init(value: JK_Angle(-10))]
*/
        
/** 
         let animation = CAKeyframeAnimation.init()
         animation.keyPath = "transform.rotation"
         animation.values = [NSNumber.init(value: JK_Angle(-10)),
         NSNumber.init(value: JK_Angle(10)),
         NSNumber.init(value: JK_Angle(-10))]
         
         // 加这2行代码，动画结束后会更新位置
         animation.isRemovedOnCompletion = false
         animation.fillMode = kCAFillModeForwards
         
         // 动画效果
         animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
         
         animation.duration = 0.5
         // 重复
         animation.repeatCount = 10
         
         self.layer?.add(animation, forKey: nil)
         //        self.layer?.removeAnimation(forKey: key)
         
*/
        
/**
        【转场动画】
         
         self.iconImageView?.image = self.leftImage
         let ani = CATransition.init()
         ani.type = "cube"
         ani.subtype = kCATransitionFromLeft
         ani.duration = 0.5
         self.iconImageView?.layer.add(ani, forKey: nil)
         
         /// 没法封装,代码块JKAsyncAfter
         DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.5) {
         self.iconImageView?.image = self.rightImage
         let animation = CATransition.init()
         animation.type = "cube"
         animation.subtype = kCATransitionFromRight
         animation.duration = 0.5
         self.iconImageView?.layer.add(animation, forKey: nil)
         }
*/
        
        
    }

}

