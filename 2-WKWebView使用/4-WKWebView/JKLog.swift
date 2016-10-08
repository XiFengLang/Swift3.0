//
//  JKLog.swift
//  4-WKWebView
//
//  Created by 蒋鹏 on 16/9/28.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import Foundation
import UIKit

func iOS8()->Bool{return((UIDevice.current.systemVersion as NSString).floatValue >= 8.0)}
func iOS10()->Bool{return((UIDevice.current.systemVersion as NSString).floatValue >= 10.0)}



func JKLOG<T>(_ log : T,className: String = #file,methodName: String = #function, lineNumber: Int = #line){
    #if DEBUG
        let filePath = className as NSString
        let filePath_copy = filePath.lastPathComponent as NSString
        let fileName = filePath_copy.deletingPathExtension
        NSLog("\n******[第\(lineNumber)行][\(fileName)  \(methodName)] ******\n \(log)")
    #endif
}
