//
//  NetworkManager.swift
//  3网络请求
//
//  Created by 蒋鹏 on 16/9/23.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
    
    /*
     https://segmentfault.com/a/1190000006946983
    @escaping 逃逸闭包常用于异步的操作，可能这个闭包在函数返回之后才会被执行。
    @noescape swift3.0弃用，默认非逃逸闭包，当此函数结束后，这个闭包的生命周期也将结束
    */
    /*
    @autoclosure   可理解为将表达式代码自动转换成闭包格式(把一句表达式自动地封装成一个闭包),慎用
    http://swifter.tips/autoclosure/
    func logIfTrue( predicate: @autoclosure () -> Bool) {
        if predicate() {
            print("True")
        }
    }
     就可以直接写：
     logIfTrue(2 > 1)
    */
    

    
    
    public class func GET(withUrl urlStr: String, paramters: [String : String]?, success: @escaping ((_ responseObject: [String : AnyObject]?) -> ()), failure: @escaping ((_ error: Error?) -> ())) {
        let Url = URL.init(string: urlStr)
        
        var request = URLRequest.init(url: Url!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 10.0)
        request.allHTTPHeaderFields = ["Content-Type":"application/json"]
        

        if (paramters != nil) {
            let paramters_temp : [String : String] = paramters!
            //if (JSONSerialization.isValidJSONObject(paramters_temp)) {
                let body = try? JSONSerialization.data(withJSONObject: paramters_temp, options: .prettyPrinted)
                // let body = try? JSONSerialization.data(withJSONObject: paramters!, options: .prettyPrinted)
            
                if (body != nil){
                    request.httpBody = body
                }
            //}
        }
        
        let session : URLSession = URLSession.shared
        
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            
            if (error != nil) {
                NSLog((error?.localizedDescription)!)
                failure(error!)
            }else if let data_copy = data {
                if let result = try? JSONSerialization.jsonObject(with: data_copy, options: []) as? [String:AnyObject] {
                    success(result)
                }else{
                    assert(false, "Json解析出错,Code:0700")
                }
            }
        })
        
        dataTask.resume()
    }
    
    
    
    
    public class func POST(withUrl urlStr: String, paramters: [String : String]?, success: @escaping((_ responseObject: [String : AnyObject]?) -> ()),failure:@escaping((_ error: Error?) -> ())){
        let Url = URL.init(string: urlStr)
        var request = URLRequest.init(url: Url!, cachePolicy: .
            reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        request.httpMethod = "POST"
        let mutStr = NSMutableString.init()
        
        
        if (paramters != nil) {
            for (key,value) in paramters!{
                let newVlaue = value.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                mutStr.appendFormat("&%@=%@", key, newVlaue!);
            }
            let body = (mutStr.copy() as! String).data(using: .utf8)
            request.httpBody = body
        }
        //request.allHTTPHeaderFields = ["Content-Type":"application/json"]
        
        let session = URLSession.shared
        

        let dataTask = session.dataTask(with: request) { (data, responce, error) in
            if (error != nil) {
                NSLog((error?.localizedDescription)!)
                failure(error!)
            }else if let data_copy = data {
                if let result = try? JSONSerialization.jsonObject(with: data_copy, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:AnyObject] {
                    success(result)
                }else{
                    assert(false, "Json解析出错,Code:0701")
                }
            }
        }
        dataTask.resume()
    }
    
}
