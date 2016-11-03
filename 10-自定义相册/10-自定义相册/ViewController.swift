//
//  ViewController.swift
//  10-自定义相册
//
//  Created by 蒋鹏 on 16/10/20.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    
    var imagePicker: JKImagePickerTool?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let image = UIImage.image(named: "im_my_QR_code");
//        let image40 = image?.resize(withSize: CGSize.init(width: 20, height: 20), isOpaque: true)
//        let image60 = image?.resize(withSize: CGSize.init(width: 30, height: 30), isOpaque: true)
//        
//        let image58 = image?.resize(withSize: CGSize.init(width: 29, height: 29), isOpaque: true)
//        let image87 = image?.resize(withSize: CGSize.init(width: 43.5, height: 43.5), isOpaque: true)
//        
//        let image80 = image?.resize(withSize: CGSize.init(width: 40, height: 40), isOpaque: true)
//        let image120 = image?.resize(withSize: CGSize.init(width: 60, height: 60), isOpaque: true)
//        
//        let image180 = image?.resize(withSize: CGSize.init(width: 90, height: 90), isOpaque: true)
//
//        JKLOG("dada")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        JKAppAuthorizationRequest.requestCameraAuthorization { (bbb) in
//            if (bbb) {
//                
//                
//                weak var weakSelf = self
//                self.imagePicker = JKImagePickerTool.init()
//                self.imagePicker?.openPhotoLibrary(allowsEditing: true, completionHandle: { (image) in
//                    JKLOG(image)
//                    }, dismiss: { 
//                        weakSelf?.view.backgroundColor = UIColor.red
//                })
//            }
//        }
        
        
        // 插件才能打开
//        self.extensionContext?.open(URL.init(string: "Prefs:root=WIFI")!, completionHandler: { (bb) in
//            print(bb)
//        })
        
//        UIApplication.shared.open(URL.init(string: "Prefs:root=WIFI")!, options: [:]) { (bb) in
//            print(bb)
//        }
//        [[LSApplicationWorkspace defaultWorkspace] openSensitiveURL:url withOptions:nil];
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

