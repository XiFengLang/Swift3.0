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
        // 此处用JKLOG有BUG，待解决
        
        
        
        let testView = UIView.init()
        testView.backgroundColor = UIColor.red
        self.view.addSubview(testView)
        
        testView.x = 100
        testView.y = 200
        testView.width = 100
        testView.height = 100
        testView.centerX = 200
        testView.centerY = 200
        
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

