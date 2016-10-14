//
//  JKAlertManager.swift
//  9-UIAlertCOntroller
//
//  Created by 蒋鹏 on 16/10/13.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit

class JKAlertView: UIView {
    fileprivate var alertManager: JKAlertManager?
}


typealias JKAlertManagerBlock = (_ actionIndex: NSInteger?, _ actionTitle: String?) -> ()

@available(iOS 8.0, *)
class JKAlertManager: NSObject {
    weak private var contentView: JKAlertView?
    private var cancelIndex_temp: Int?
    private var destructiveIndex_temp: Int?
    private var cancelTitle: String?
    private var destructiveTitle: String?
    private var block: JKAlertManagerBlock?
    lazy private var textFieldChangedBlockMutDict: [NSString: JKAlertManagerBlock]? = {
        return [NSString: JKAlertManagerBlock]()
    }()
    
    
    public var title: String?
    public var message: String?
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
        
    }
    
    
    class func alertManager(withStyle style: UIAlertControllerStyle, title: String?, messgae: String?) -> JKAlertManager {
        return JKAlertManager.init().then(block: { (manager) in
            manager.alertController = UIAlertController.init(title: title, message: messgae, preferredStyle: style)
        })
    }
    
}
