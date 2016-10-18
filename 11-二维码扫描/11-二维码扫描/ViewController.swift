//
//  ViewController.swift
//  11-二维码扫描
//
//  Created by 蒋鹏 on 16/10/18.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        JKAppAuthorizationRequest.requestAudioAuthorization { (bbb) in
            JKLOG(bbb)
        }
        
        
        JKAppAuthorizationRequest.requestPhotoLibraryAuthorization { (bbb) in

        }
        
        
        JKAppAuthorizationRequest.requestCameraAuthorization { (bbb) in
            JKLOG(bbb)
            let nav = UINavigationController.init(rootViewController: JKQRScanViewController.init())
            self.present(nav, animated: true, completion: nil)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

