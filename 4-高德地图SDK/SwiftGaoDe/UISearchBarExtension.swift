//
//  UISearchBarExtension.swift
//  SwiftGaoDe
//
//  Created by 蒋鹏 on 16/10/9.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import Foundation
import UIKit

public extension UISearchBar {
    public func jk_customSearchBar(withPlaceholder placeholder: String) -> () {
        var searchBarFrame = self.frame
        searchBarFrame.size.height = 44
        self.frame = searchBarFrame
        self.barTintColor = JKColor_RGB_Float(r: 0.937255,g: 0.937255,b: 0.956863)
        self.tintColor = UIColor.blue//JKColor_RGB(r: 12, g: 1896, b: 120)
        self.placeholder = placeholder
        self.returnKeyType = .done
        self.setImage(UIImage.init(named: "im_search_image"), for: .search, state: .normal)
        
        let image = UIImage.image(withColor: JKColor_RGB_Float(r: 0.937255,g: 0.937255,b: 0.956863), imageSize: CGSize.init(width: JKScreenWidth(), height: 66))
        self.setBackgroundImage(image, for: .any, barMetrics: .default)
        
        if let searchTextField: UITextField = self.value(forKey: "searchField") as? UITextField {
            searchTextField.font = UIFont.systemFont(ofSize: 18)
            searchTextField.leftView?.bounds = CGRect.init(x: 0, y: 0, width: 25, height: 25)
            searchTextField.autocapitalizationType = .none
        }
    }
}
