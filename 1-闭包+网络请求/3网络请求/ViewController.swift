//
//  ViewController.swift
//  3网络请求
//
//  Created by 蒋鹏 on 16/9/23.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Push", style: .plain, target: self, action: #selector(ViewController.pushAction))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "循环引用", style: .plain, target: self, action: #selector(pushLoopVC))
    }
    
    final func pushAction() {
        let blockVC : BlockTestViewController = BlockTestViewController.init()
        self.navigationController?.pushViewController(blockVC, animated: true)
    }
    
    final func pushLoopVC() {
        let blockVC : BlockLoopViewController = BlockLoopViewController.init()
        self.navigationController?.pushViewController(blockVC, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

