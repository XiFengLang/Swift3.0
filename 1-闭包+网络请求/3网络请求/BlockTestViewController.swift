//
//  BlockTestViewController.swift
//  3网络请求
//
//  Created by 蒋鹏 on 16/9/26.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit


typealias JKTestBlock = ((_ text:String) -> String)?

class BlockTestViewController: UIViewController {
    
    //  ((_ block携带的参数及类型)  -> 返回类型)?这里必须可选
    var block: JKTestBlock
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        self.blockTest()
        self.networkRequest()
        
        typealias RuntimeBlock = (_ text:String) -> Void
        let myBlock = { (str: String) in
            print(str)
        }
        
        // 编译时会报错，Showing Recent Issues Command failed due to signal: Segmentation fault: 11
        //objc_setAssociatedObject(self, "key", myBlock, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        
        // 解决方案
        objc_setAssociatedObject(self, "key", myBlock as AnyObject, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        
        let tempBlock:RuntimeBlock = objc_getAssociatedObject(self, "key") as! RuntimeBlock
        tempBlock("Swift-Runtime-objc_setAssociatedObject")
    }
    
    // Block 闭包
    final func blockTest() {
        
        // 1.block在函数方法中的应用
        self.blockFunc(withStr: "参数Str0") { (text) in
            print("block携带的text:\(text)")
        }
        self.blockFunc(withStr: "参数", compltion: nil)
        
        
        // 2.属性Block
        self.block = {(text) -> String in
            return text
        }
        if let str = self.block?("参数Str1") {
            print("\(str)")
        }
        
        
        
        
        // 3.方法（函数）内部的Block，用于精简代码（内部可复用）
        let privateBlock = {(text:String) -> String? in
            return text
        }
        let str_copy  = privateBlock("参数Str2")
        if (str_copy != nil) {
            print(str_copy)
        }
        
        
 /*
         类型3.1    -> String
         let privateBlock = {(text:String) -> String in
            return text
         }
         
         
         报错
         if let str_copy = privateBlock("参数Str2") {
         print("\(str_copy)")
         }
         
         
         可用，但是会警告
         if let str_copy : String = privateBlock("参数Str2") {
            print("\(str_copy)")
         }
         
         正确写法，-> String并没有带?,所以Blcok一定会返回有效值，就不用再做判断
         let str_copy  = privateBlock("参数Str2")
         print(str_copy)
         
         
         
         
         类型3.2    -> String?
         let privateBlock = {(text:String) -> String? in
            return nil
         }
         
         必须做判断，有可能返回空值
         let str_copy  = privateBlock("参数Str2")
         if (str_copy != nil) {
            print(str_copy)
         }
         
         
         类型3.3   text:String?   -> String?都可选
         let privateBlock = {(text:String?) -> String? in
            return text  无需加!解包 or ?可选
         }
         
         
         类型3.4   text:String?   -> String
         let privateBlock = {(text:String?) -> String in
            return text!   必须解包
         }
         print(str_copy)
         
         http://www.jianshu.com/p/3a8e45af7fdd
         http://www.cnblogs.com/kenshincui/p/5594951.html
         
 */
        
        
        
        
        
        
        
    }
    
    
    //  -> Void  等同-> ()
    final func blockFunc(withStr string: String, compltion block:((_ text:String) -> ())?) {
        block?("text")
    }
    
    /*  这种写法不能给Block传nil，即compltion: nil,必须实现代码
     final func block(withStr string: String, compltion block:(_ text:String) -> Void) {
     print("传进来的参数string:\(string) ")
        block("text")
     }
     */
    
    
    
    
    
    
    // 封装网络请求
    private func networkRequest() {
         let urlStr = "http://120.25.226.186:32812/login?username=520it&pwd=520it&type=JSON"
         let paramter = ["key":"value"]
        
         NetworkManager.GET(withUrl: urlStr, paramters: paramter, success: { (respond : [String : AnyObject]?) in
                print(respond)
            }, failure: { (error) in
                print(error?.localizedDescription)
         })
        

        
        let urlStr_Post = "http://121.201.65.64:8801/friends/alias/?fid=1051&token=MTA3NiNhMzY0Zjc0ZjAwY2Y4M2UyNzgwNjY5MWVkOGI1MWViZTZkOWI5Zjg3"
        let param_Post = ["alias":"2货",
                          "os":"iOS"]
        
        NetworkManager.POST(withUrl: urlStr_Post, paramters: param_Post, success: { (respond : [String : AnyObject]?) in
                print(respond)
            }) { (error) in
                print(error?.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 等同dealloc
    deinit {
        print("\(self.classForCoder)已释放")
    }

}
