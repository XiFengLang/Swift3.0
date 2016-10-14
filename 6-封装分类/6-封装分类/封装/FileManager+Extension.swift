//
//  FileManager+Extension.swift
//  6-封装分类
//
//  Created by 蒋鹏 on 16/10/14.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import Foundation
extension FileManager {
    
    func isDirectory(path: String) -> Bool {
        var isDirectory: ObjCBool = ObjCBool(false)
        _ = self.fileExists(atPath: path, isDirectory: &isDirectory)
        return isDirectory.boolValue
    }
    
    
    func createDirectory(atRootDirectory root:FileManager.SearchPathDirectory, folderName: String) -> String? {
        let rootPath = NSSearchPathForDirectoriesInDomains(root, .userDomainMask, true).last
        let folderPath = rootPath?.appending(folderName)
        if (self.fileExists(atPath: folderPath!) == false) {
            do {
                try self.createDirectory(atPath: folderPath!, withIntermediateDirectories: true, attributes: nil)
            } catch {
                return nil
            }
            
        }
        return folderPath
    }
    
    
    func fileSize(atPath path: String) -> UInt {
        var isDirectory: ObjCBool = ObjCBool(false)
        let exists = self.fileExists(atPath: path, isDirectory: &isDirectory)
        if (exists == false) {
            return 0
        }
        
        if (isDirectory.boolValue) {
            
            /// 带throws的方法代表可以捕获异常
            /*  
             try!代表不捕获异常
             捕获异常则使用do catch
             do {
             try <#throwing expression#>
             } catch <#pattern#> {
             <#statements#>
             }
             */
            
            let subPaths = try! self.contentsOfDirectory(atPath: path)
            
            var totalSize: UInt = 0
            for subPath in subPaths {
                let fullPath = path.appending(subPath)
                totalSize += self.fileSize(atPath: fullPath)
            }
            return totalSize
            
        } else {
            let info = try! self.attributesOfItem(atPath: path)
            return info[FileAttributeKey.size] as! UInt
        }
    }
}
