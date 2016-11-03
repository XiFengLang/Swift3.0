//
//  ContextRefVC.swift
//  12-QuartzCore框架
//
//  Created by 蒋鹏 on 16/10/24.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit

class ContextRefVC: JKBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.view.addSubview(CGContextView.view(withFrame: CGRect.init(x: 0, y: 66, width: 100, height: 100), backgroundColor: UIColor.red))
    }

    
}
