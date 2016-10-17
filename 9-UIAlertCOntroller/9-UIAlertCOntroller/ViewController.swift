//
//  ViewController.swift
//  9-UIAlertCOntroller
//
//  Created by 蒋鹏 on 16/10/13.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        let alertManager = JKAlertManager.alertManager(withStyle: .alert, title: "标题", messgae: "内容")
//        alertManager.configue(withCancelTitle: "取消", destructiveIndex: 1, otherTitles: ["title1","title2","title3"])
//        alertManager.configuePopoverControllerForActionSheetStyle(withSourceView: self.view, sourceRect: CGRect.init(x: 200, y: 200, width: 100, height: 100))
//        alertManager.showAlertController(fromVC: self) { (manager, index, title) in
//            JKLOG(title)
//        }
        
        
        let alertManager = JKAlertManager.alertManager(withStyle: .alert, title: "标题", messgae: "内容")
        alertManager.configue(withCancelTitle: "取消", destructiveIndex: -1, otherTitles: ["title1","title2","title3"])
        alertManager.configuePopoverControllerForActionSheetStyle(withSourceView: self.view, sourceRect: CGRect.init(x: 200, y: 200, width: 100, height: 100))
        alertManager.addTextField(withPlaceHolder: "账号", isSecureTextEntry: false, configuretionHandle: { (textField) in
            textField.clearButtonMode = UITextFieldViewMode.always
            }) { (textField) in
                JKLOG(textField?.text)
        }
        alertManager.addTextField(withPlaceHolder: "密码", isSecureTextEntry: true, configuretionHandle: { (textField) in
            textField.clearsOnBeginEditing = true
        }) { (textField) in
            JKLOG(textField?.text)
        }
        alertManager.showAlertController(fromVC: self) { (manager, index, title) in
            JKLOG(title)
        }
    }
}

