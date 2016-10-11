//
//  ViewController.swift
//  7-[搬运]令人眼前一亮的初始化方式
//
//  Created by 蒋鹏 on 16/10/11.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // 常规写法
    lazy var myLabel: UILabel = {
        let label = UILabel()
        label.text = "myLabel"
        label.font = UIFont.systemFont(ofSize: 18)
        label.frame = CGRect.init(x: 100, y: 100, width: 100, height: 50)
        return label
    }()
    
    // 仿写
    lazy var label: UILabel = {
        $0.text = "myLabel"
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.frame = CGRect.init(x: 100, y: 160, width: 100, height: 50)
        return $0
    }(UILabel())

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        
        
/*
         // 引用
         Swift 自动为内联函数提供了参数名称缩写功能，您可以直接通过$0,$1,$2来顺序调用闭包的参数。
         
         如果您在闭包表达式中使用参数名称缩写，您可以在闭包参数列表中省略对其的定义，并且对应参数名称缩写的类型会通过函数类型进行推断。 in关键字也同样可以被省略，因为此时闭包表达式完全由闭包函数体构成：
         
         reversed = sorted(names, { $0 > $1 } )
         在这个例子中，$0和$1表示闭包中第一个和第二个参数。

         
         // 缺点：$0不会自动联想出属性,而Then协议库中的$0可自动联想属性（推荐）
 */
        
        let _: UISwitch = {
            view.addSubview($0)
            $0.backgroundColor = UIColor.white
            $0.center = self.view.center
            return $0
        }(UISwitch())
        
        
        let _: UILabel = {
            view.addSubview($0)
            $0.text = "测试"
            $0.font = UIFont.systemFont(ofSize: 18)
            var tempCenter = self.view.center
            tempCenter.y += 30
            $0.center = tempCenter
            $0.bounds = CGRect.init(x: 0, y: 0, width: 100, height: 50)
            return $0
        }(UILabel())
        
        // (UISwitch())  (UISwitch())实则是向Block传一个初始化过的对象
        // 而Block内部则用$0取参数

        // 常规，Block内部创建对象
        let _ = { () -> UILabel in
            let label = UILabel()
            view.addSubview(label)
            label.text = "myLabel"
            label.font = UIFont.systemFont(ofSize: 18)
            var tempCenter = self.view.center
            tempCenter.y += 90
            label.center = tempCenter
            label.bounds = CGRect.init(x: 0, y: 0, width: 100, height: 50)
            return label
        }()
        
        // 常规懒加载
        view.addSubview(myLabel)
        
        // 改写的懒加载
        view.addSubview(label)
        
        
        self.view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(push)))
        
        
    }
    
    func push() {
        self.present(JKViewController.init(), animated: true, completion: nil)
    }
    
    
}


// 使用Then协议库(推荐)
extension ViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 2种写法代码一样
        
        // 1.0 带参数，可自行命名
        let  _ = UILabel().then_Any { (label) in
            label.backgroundColor = .blue
            label.font = UIFont.systemFont(ofSize: 18)
            label.textAlignment = .center
            label.text = "Then协议库写法_1.0"
            label.frame = CGRect.init(x: 20, y: 200, width: 150, height: 40)
            
            // 不会循环引用(已测试)
            self.view.addSubview(label)
        }
        
        // 1.1 (推荐)无参数，无需命名，用$取参数，可自动联想属性(推荐)
        let _ = UILabel().then_Any {
            $0.backgroundColor = .blue
            $0.font = UIFont.systemFont(ofSize: 18)
            $0.textAlignment = .center
            $0.text = "Then库写法_1.1"
            $0.frame = CGRect.init(x: 200, y: 260, width: 150, height: 40)
            self.view.addSubview($0)
        }
        
        
        // 2.0 带参数，可自行命名
        let label_AnyO = UILabel().then { (label) in
            label.backgroundColor = .blue
            label.font = UIFont.systemFont(ofSize: 18)
            label.textAlignment = .center
            label.text = "Then库写法_2.0"
            label.frame = CGRect.init(x: 200, y: 260, width: 150, height: 40)
        }
        self.view.addSubview(label_AnyO)
        
        
        // 2.1 (推荐)无参数，无需命名，用$取参数，可自动联想属性
        let _ = UILabel().then {
            $0.backgroundColor = .blue
            $0.font = UIFont.systemFont(ofSize: 18)
            $0.textAlignment = .center
            $0.text = "Then库写法_2.1"
            $0.frame = CGRect.init(x: 200, y: 260, width: 150, height: 40)
            self.view.addSubview($0)
        }
    }
}
