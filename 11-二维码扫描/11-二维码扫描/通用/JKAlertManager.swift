//
//  JKAlertManager.swift
//  9-UIAlertCOntroller
//
//  Created by 蒋鹏 on 16/10/13.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit

fileprivate class JKAlertView: UIView {
    fileprivate var alertManager: JKAlertManager?
}



typealias JKAlertManagerBlock = (_ actionIndex: NSInteger, _ actionTitle: String?) -> ()
typealias JKAlertTextFieldTextChangeBlock = (_ textField: UITextField?) -> ()
typealias JKAlertActionBlock = (_ tempAlertManager: JKAlertManager?,_ actionIndex: Int,_ actionTitle: String?) -> ()

@available(iOS 8.0, *)
class JKAlertManager: NSObject {
    weak private var contentView: JKAlertView?
    private var cancelIndex_temp: Int?
    private var destructiveIndex_temp: Int?
    private var cancelTitle: String?
    private var destructiveTitle: String?
    private var block: JKAlertManagerBlock?
    
    lazy private var textFieldChangedBlockMutDict: [String: JKAlertTextFieldTextChangeBlock]? = {
        return [String: JKAlertTextFieldTextChangeBlock]()
    }()
    
    lazy private var otherTitles: [String]? = {
        return [String]()
    }()
    
    public var alertController: UIAlertController?
    
    
    public var textFields: [UITextField]? {
        get { return self.alertController?.textFields }
    }
    
    public var cancelIndex: Int {
        get { return self.cancelIndex_temp! }
    }
    public var destructiveIndex: Int {
        get { return self.destructiveIndex_temp! }
    }
    
    public var iPad: Bool {
        get { return UIDevice.current.userInterfaceIdiom == .pad }
    }
    
    
    override private init() {
        super.init()
        self.cancelIndex_temp = -1
        self.destructiveIndex_temp = -2
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldTextDidChaged(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    /// 私有
    @objc private func textFieldTextDidChaged(_ notification: Notification) -> Void {
        let textField = notification.object as! UITextField
        let pointer = NSString.init(format: "%p", textField)
        let textChangeBlock = self.textFieldChangedBlockMutDict?[pointer as String]
        textChangeBlock?(textField)
    }
    
    /// 初始化方法
    public class func alertManager(withStyle style: UIAlertControllerStyle, title: String?, messgae: String?) -> JKAlertManager {
        return JKAlertManager.init().then(block: { (manager) in
            manager.alertController = UIAlertController.init(title: title, message: messgae, preferredStyle: style)
        })
    }
    
    public func configue(withCancelTitle cancelTitle: String?, destructiveIndex: Int, otherTitles: [String]?) -> Void {
        self.cancelTitle = cancelTitle
        self.destructiveIndex_temp = destructiveIndex
        self.addCancelAction()
        
        self.otherTitles?.addObject(fromArray: otherTitles)
        if self.destructiveIndex >= 0 && self.destructiveIndex < (self.otherTitles?.count)! {
            self.destructiveTitle = self.otherTitles?[destructiveIndex]
        }
        self.addOtherActions()
    }
    
    public func configuePopoverControllerForActionSheetStyle(withSourceView sourceView: UIView?, sourceRect: CGRect) -> Void {
        if self.iPad == true && self.alertController != nil {
            assert(self.alertController?.preferredStyle == UIAlertControllerStyle.actionSheet, "\nJKAlertManagerError: 不能在UIAlertControllerStyleAlert类型中设置PopoverController\n")
            let popoerController = self.alertController?.popoverPresentationController
            if popoerController != nil {
                popoerController?.sourceView = sourceView
                popoerController?.sourceRect = sourceRect
                popoerController?.permittedArrowDirections = .any
            }
        }
    }
    
    public func addTextField(withPlaceHolder placeHolder: String?, isSecureTextEntry: Bool, configuretionHandle:((UITextField) -> Void)?, textChangeBlock: JKAlertTextFieldTextChangeBlock?) -> Void {
        if self.alertController != nil {
            weak var weakSelf = self
            self.alertController?.addTextField(configurationHandler: { (textField) in
                guard let strongSelf = weakSelf else { return }
                textField.placeholder = placeHolder
                textField.isSecureTextEntry = isSecureTextEntry
                configuretionHandle?(textField)
                if textChangeBlock != nil {
                    let pointer = NSString.init(format: "%p", textField)
                    strongSelf.textFieldChangedBlockMutDict!.updateValue(textChangeBlock!, forKey: pointer as String)
                }
            })
        }
    }
    
    
    public func showAlertController(fromVC controller: UIViewController, actionBlock: JKAlertActionBlock?) -> Void {
        let alertView = JKAlertView.init(frame: CGRect.zero)
        controller.view.addSubview(alertView)
        self.contentView = alertView
        alertView.alertManager = self
        
        controller.present(self.alertController!, animated: true, completion: nil)
        
        
        /// 解除循环引用
        weak var weakSelf = self
        self.block = { (actionIndex,actionTitle) in
            guard let strongSelf = weakSelf else { return }
            actionBlock?(strongSelf,actionIndex,actionTitle)
            NotificationCenter.default.removeObserver(strongSelf)
            strongSelf.alertController = nil
            strongSelf.textFieldChangedBlockMutDict = nil
            strongSelf.otherTitles = nil
            strongSelf.contentView?.removeFromSuperview()
            strongSelf.block = nil
        }
    }
    
    
    /// 添加Actions
    private func addCancelAction() -> Void {
        if self.cancelTitle != nil {
            let cancelAction = UIAlertAction.init(title: self.cancelTitle, style: .cancel, handler: { (action) in
                self.block?(self.cancelIndex, self.cancelTitle)
            })
            self.alertController?.addAction(cancelAction)
        }
    }
    
    private func addOtherActions() -> Void {
        for (index,item) in self.otherTitles!.enumerated() {
            if self.destructiveIndex == index {
                self.addDestructiveAction()
                continue
            }
            
            let action = UIAlertAction.init(title: item, style: .default, handler: { (act) in
                self.block?(index, item)
            })
            self.alertController?.addAction(action)
        }
    }
    
    private func addDestructiveAction() -> Void {
        if self.destructiveTitle != nil {
            let action = UIAlertAction.init(title: self.destructiveTitle, style: .destructive, handler: { (act) in
                self.block?(self.destructiveIndex, self.destructiveTitle)
            })
            self.alertController?.addAction(action)
        }
    }
    
    deinit {
        JKLOG("JKAlertManager已释放")
    }
}
