//
//  ViewController.swift
//  6-封装分类
//
//  Created by 蒋鹏 on 16/10/10.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.jkPro = "通过类别拓展的属性"
        NSLog(self.jkPro!)
        
        
        print("标记")
        
        
        
        
        
        
        
//        let text = "大黄金卡加的我回家看的黄金卡案件和卡号及大家很快哈哈啊环境的骄傲的健康大加快大家很快大家看大海阿卡丽几哈大家哈达"
        
        let rect = CGRect.init(x: self.view.midX - 100,
                               y: self.view.midY - 100,
                               width: 200, height: 200)
        
//        let image = UIImage.image(withColor: UIColor.blue, size: CGSize.init(width: 300, height: 300))
//        let image_R = image?.rounding()
        
//        let image_R = UIImage.roundingImage(withColor: UIColor.blue, size: CGSize.init(width: 300, height: 300), radius: 80)
        let image_R = UIImage.roundingImage(withColor: UIColor.blue, size: CGSize.init(width: 300, height: 300), radius: 80, borderColor: UIColor.red, borderWidth: 10)

//        let view = UIView.jk_view(withFrame: rect, backgroundColor: UIColor.red)
        let view = UIImageView.jk_imageView(withFrame: rect, image: image_R)
//        let view = UILabel.jk_label_WordWrap(withFrame: rect, text: text, font: UIFont.systemFont(ofSize: 18))
        self.view.addSubview(view)
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

