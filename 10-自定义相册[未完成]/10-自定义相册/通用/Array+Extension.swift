//
//  Array+Extension.swift
//  9-UIAlertCOntroller
//
//  Created by 蒋鹏 on 16/10/17.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import Foundation
extension Array {
    
    mutating func addObject(fromArray array:[Element]?) -> Void {
        if array != nil {
            for item in array! {
                self.append(item)
            }
        }
    }
}
