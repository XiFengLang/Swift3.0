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
        JKLOG(self.jkPro!)
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "iTem", style: .plain, target: nil, action: nil)
        
        
//        let text = "大黄金卡加的我回家看的黄金卡案件和卡号及大家很快哈哈啊环境的骄傲的健康大加快大家很快大家看大海阿卡丽几哈大家哈达"
        
//        let rect = CGRect.init(x: self.view.midX - 100,
//                               y: self.view.midY - 100,
//                               width: 200, height: 200)
//        
//        let frame = CGRect.init(x: self.view.midX - 100,
//                                y: self.view.midY + 150,
//                                width: 200, height: 50)
        
//        let image = UIImage.image(withColor: UIColor.blue, size: CGSize.init(width: 300, height: 300))
        
//        let image_R = image?.rounding()
        
//        let image_R = UIImage.roundingImage(withColor: UIColor.blue, size: CGSize.init(width: 300, height: 300), radius: 80)
        
//        let image_R = UIImage.roundingImage(withColor: UIColor.blue, size: CGSize.init(width: 300, height: 300), radius: 80, borderColor: UIColor.red, borderWidth: 10)

//        let view = UIView.view(withFrame: rect, backgroundColor: UIColor.red)
        
//        let view = UIImageView.imageView(withFrame: rect, image: image_R)
        
//        let view = UILabel.label_WordWrap(withFrame: rect,
//                                             text: text,
//                                             font: UIFont.systemFont(ofSize: 18))
        
//        let view = UIButton.button(withFrame: rect,
//                                   title: "按钮",
//                                   selectedText: nil,
//                                   color: UIColor.red,
//                                   target: self,
//                                   action: #selector(touch))
        
//        let view = UIButton.button(withFrame: rect,
//                                   title: "按钮",
//                                   selectedTitle: "选中",
//                                   backgroundImage: UIImage.init(named: "im_message_error"),
//                                   selectedBgImage: nil,
//                                   target: self,
//                                   action: #selector(touch))
//        self.view.addSubview(view)
        
        
//        let button = UIButton.button(withFrame: frame,
//                                     title: "按钮",
//                                     image: UIImage.image(named: "im_message_error"),
//                                     titleColor: UIColor.blue,
//                                     target: self, action: #selector(touch))
        
//        let button = UIButton.button(withFrame: frame,
//                                     image: UIImage.image(named: "im_message_error"),
//                                     highlightImage: UIImage.image(named: "im_message_error"),
//                                     target: self, action: #selector(touch))
        
//        let button = UIButton.roundedButton(withFrame: frame,
//                                            title: "圆角边框按钮",
//                                            titleColor: UIColor.red,
//                                            fillColor: UIColor.green,
//                                            borderColor: UIColor.darkGray,
//                                            borderRaduis: 10,
//                                            target: self, action: #selector(touch))
        
//        let button = UIButton.roundedButton(withFrame: frame,
//                                            title: "圆角按钮",
//                                            color: UIColor.red,
//                                            highlightColor: UIColor.lightGray,
//                                            radius: 25,
//                                            target: self, action: #selector(touch))
        
//        let button = UIButton.universalRoundedButton(withTitle: "通用型按钮",
//                                                     originY: 300,
//                                                     target: self, action: #selector(touch))
//        self.view.addSubview(button)
    }

    
    func touch() {
        JKLOG("点击按钮")
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

