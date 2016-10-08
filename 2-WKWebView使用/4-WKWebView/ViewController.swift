//
//  ViewController.swift
//  4-WKWebView
//
//  Created by 蒋鹏 on 16/9/27.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "跳转", style: .plain, target: self, action: #selector(ViewController.pushAction))
    }

    final func pushAction() {
        let webVC = FCWebViewController.init()
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

