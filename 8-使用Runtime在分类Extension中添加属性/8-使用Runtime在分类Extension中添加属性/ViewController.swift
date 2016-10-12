//
//  ViewController.swift
//  8-使用Runtime在分类Extension中添加属性
//
//  Created by 蒋鹏 on 16/10/12.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.jkPro = "通过类别拓展的属性"
        NSLog(self.jkPro!)// 对nil进行解包会崩溃
        JKLOG(self.jkPro!)
        JKLOG(self.jkPro)
    }
}

