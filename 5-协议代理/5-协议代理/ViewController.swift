//
//  ViewController.swift
//  5-协议代理
//
//  Created by 蒋鹏 on 16/10/10.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit


// 遵守协议JKEmployerDelegate
class ViewController: JKBaseViewController,JKEmployerDelegate,JKEmployerOptionalDelegate {

    
    var employer: JKEmployer?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.employer = JKEmployer.init()
        self.employer?.delegate = self
        self.employer?.dataSource = self
        
        self.employer?.activateDelegateFunc(str: "触发协议方法")
        self.employer?.activateOptionalDelegateFunc(str: "触发可选协议方法")
    }
    
    // 必须实现的协议方法
    func jkDelegateFunc(str: String) {
        JKLOG(str)
    }

    // 可选实现的协议方法
    func jkOptionalDelegateFunc(str: String) {
        JKLOG(str)
    }
    
    // 待返回值的协议方法
    func jkOptionalDelegateFun(str: String) -> String {
        return str
    }
    
}

