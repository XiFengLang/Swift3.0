//
//  FCBaseViewController.swift
//  4-WKWebView
//
//  Created by 蒋鹏 on 16/9/27.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit

class FCBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }
    
    deinit {
        NSLog("\(self.classForCoder)%@已释放")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
