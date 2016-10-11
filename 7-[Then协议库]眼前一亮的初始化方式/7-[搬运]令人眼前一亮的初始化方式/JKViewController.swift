//
//  JKViewController.swift
//  7-[搬运]令人眼前一亮的初始化方式
//
//  Created by 蒋鹏 on 16/10/11.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit

class JKViewController: UIViewController {

    var label: UILabel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Push", style: .plain, target: self, action: #selector(push))
        // Do any additional setup after loading the view.
        
        self.view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(push)))
    }
    
    func push() {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let  label_T = UILabel().then_Any { (label) in
            label.backgroundColor = .blue
            label.font = UIFont.systemFont(ofSize: 18)
            label.textAlignment = .center
            label.text = "Then协议库写法_1"
            label.frame = CGRect.init(x: 20, y: 200, width: 150, height: 40)
            self.view.addSubview(label)
        }
        self.label = label_T
        
        let label_AnyO = UILabel().then { (label) in
            label.backgroundColor = .blue
            label.font = UIFont.systemFont(ofSize: 18)
            label.textAlignment = .center
            label.text = "Then库写法_2"
            label.frame = CGRect.init(x: 200, y: 260, width: 150, height: 40)
        }
        self.view.addSubview(label_AnyO)
        
    }
    
    
    deinit {
        print("已释放")
    }

}
