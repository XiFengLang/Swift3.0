//
//  BlockLoopViewController.swift
//  3网络请求
//
//  Created by 蒋鹏 on 16/9/26.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit
import Dispatch

class BlockLoopViewController: UIViewController {
    
    var block_One: ((_ text:String) -> String?)?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        
        /*
         会产生循环引用
        self.block_One = {(text) -> String? in
            self.view.backgroundColor = UIColor.white
            return text
        }
        */
        
        
        /*
         方案1.
        self.block_One = {[weak self] (text) -> String? in
            // 不会产生循环引用
            self?.view.backgroundColor = UIColor.white
            return text
        }
        */
        
        
        
        /*
         方案2.
        weak var weakSelf = self
        self.block_One = { (text) -> String? in
            // 不会产生循环引用
            weakSelf?.view.backgroundColor = UIColor.white
            return text
        }
         */
        
        
        /*
         方案3.不推荐      unowned无主的，类似OC  _unsafe_unretained
         用weak      self是可选的
         用unowned   self不可选
         
         如果Self在闭包被调用的时候有可能是Nil。则使用weak
         如果Self在闭包被调用的时候永远不会是Nil。则使用unowned
         
        self.block_One = {[unowned self] (text) -> String? in
            // 不会产生循环引用
            self.view.backgroundColor = UIColor.white
            return text
        }
         */
        
        /* 方案5.推荐    先弱后强
        self.block_One = {[weak self] (text) -> String? in
            guard let strongSelf = self else { return nil }
            strongSelf.view.backgroundColor = UIColor.white
            return text
        }
         */
        
        
        
        /* 方案6.推荐    先弱后强
        weak var weakSelf = self
        self.block_One = {(text) -> String? in
            guard let strongSelf = weakSelf else { return nil }
            strongSelf.view.backgroundColor = UIColor.white
            return text
        }
        */
    }

    
    final func escapingBlock(WithParamter param: String,block: @escaping((_ str: String) -> Void)) -> String{
        var temp = "测试"
        DispatchQueue.global().async {
            for i in 0...30{
                temp += "\(i)"
                
                if i == 29 {
                    DispatchQueue.main.async {
                        block(temp)
                    }
                }
            }
        }
        return temp
    }
    
    
    final func nonescapingBlock(WithParamter param: String,block: (_ str: String) -> Void) -> String{
        var temp = "测试"
//        DispatchQueue.global().async {
            for i in 0...30{
                temp += "\(i)"
                
                if i == 29 {
//                    在GCD多线程的Block中使用block会被强制使用@escaping，否则会报错
//                    DispatchQueue.main.async {
                        block(temp)
//                    }
                }
            }
//        }
        return temp
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let str = self.block_One?("参数Str1") {
            print("\(str)")
        }
        
    }
    
    
    
    deinit {
        print("\(self.classForCoder)已释放")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
