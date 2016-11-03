//
//  JKAppAuthorizationRequest.swift
//  11-二维码扫描
//
//  Created by 蒋鹏 on 16/10/18.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import Contacts
import AddressBook

typealias JKAppAuthorizationRequestResult = (_ authorized: Bool) -> Void


class JKAppAuthorizationRequest: NSObject {
    
    /// 相册授权
    class func requestPhotoLibraryAuthorization(_ result: @escaping(JKAppAuthorizationRequestResult)) -> Void {
        PHPhotoLibrary.requestAuthorization { (status) in
            if (status == .authorized){
                DispatchQueue.main.async(execute: { result(true) })
            }else {
                let authorized = PHPhotoLibrary.authorizationStatus()
                if (authorized == .authorized){
                    DispatchQueue.main.async(execute: { result(true) })
                }else {
                    DispatchQueue.main.async(execute: { result(false) })
                    self.showAlert(withTitle: "请在iPhone的\"[设置]-[隐私]-[照片]\"中允许\"APP\"访问相册。")
                }
            }
        }
    }
    
    /// 相机授权
    class func requestCameraAuthorization(_ result: @escaping(JKAppAuthorizationRequestResult)) -> Void {
        AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo) { (status) in
            if (status == true){
                DispatchQueue.main.async(execute: { result(true) })
            }else {
                let authorized = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
                if (authorized == .authorized){
                    DispatchQueue.main.async(execute: { result(true) })
                }else {
                    DispatchQueue.main.async(execute: { result(false) })
                    self.showAlert(withTitle: "请在iPhone的\"[设置]-[隐私]-[相机]\"中允许\"APP\"使用相机。")
                }
            }
        }
    }
    
    
    /// 麦克风授权
    class func requestAudioAuthorization(_ result: @escaping(JKAppAuthorizationRequestResult)) -> Void {
        AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeAudio) { (status) in
            if (status == true){
                DispatchQueue.main.async(execute: { result(true) })
            }else {
                let authorized = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeAudio)
                if (authorized == .authorized){
                    DispatchQueue.main.async(execute: { result(true) })
                }else {
                    DispatchQueue.main.async(execute: { result(false) })
                    self.showAlert(withTitle: "请在iPhone的\"[设置]-[隐私]-[麦克风]\"中允许\"APP\"访问麦克风。")
                }
            }
        }
    }
    
    /// 麦克风+相机授权（拍视频）
    class func requestVideoAuthorization(_ result: @escaping(JKAppAuthorizationRequestResult)) -> Void {
        self.requestAudioAuthorization { (authorized) in
            if (authorized) {
                self.requestCameraAuthorization(result)
            }else {
                DispatchQueue.main.async(execute: { result(false) })
            }
        }
    }
    
    /// 通讯录授权
    class func requestAddressBookAuthorization(_ result: @escaping(JKAppAuthorizationRequestResult)) -> Void {
        if #available(iOS 9.0, *) {
            CNContactStore.init().requestAccess(for: .contacts) { (authorized, error) in
                if (authorized) {
                    DispatchQueue.main.async(execute: { result(true) })
                }else{
                    let status = CNContactStore.authorizationStatus(for: .contacts)
                    if (status == CNAuthorizationStatus.authorized){
                        DispatchQueue.main.async(execute: { result(true) })
                    }else{
                        DispatchQueue.main.async(execute: { result(false) })
                        self.showAlert(withTitle: "请在iPhone的\"[设置]-[隐私]-[通讯录]\"中允许\"APP\"访问通讯录。")
                    }
                }
            }
        } else {
            ABAddressBookRequestAccessWithCompletion(ABAddressBookCreate() as ABAddressBook!, { (granted, error) in
                if (granted) {
                    DispatchQueue.main.async(execute: { result(true) })
                }else{
                    let authorized = ABAddressBookGetAuthorizationStatus()
                    if (authorized == ABAuthorizationStatus.authorized){
                        DispatchQueue.main.async(execute: { result(true) })
                    }else{
                        DispatchQueue.main.async(execute: { result(false) })
                        self.showAlert(withTitle: "请在iPhone的\"[设置]-[隐私]-[通讯录]\"中允许\"APP\"访问通讯录。")
                    }
                }
            })
        }
    }
    
    private class func showAlert(withTitle title: String?) -> Void {
        DispatchQueue.main.async(execute: {
            let alertManager = JKAlertManager.alertManager(withStyle: .alert, title: title, messgae: nil)
            alertManager.configue(withCancelTitle: "好的", destructiveIndex: 0, otherTitles: ["前往设置"])
            alertManager.showAlertController(fromVC: UIWindow.currentViewController(), actionBlock: { (manager, index, str) in
                if (index != manager?.cancelIndex){
                    UIApplication.shared.open(withUrl: UIApplicationOpenSettingsURLString, completionHandler: { (successed) in
                        
                    })
                }
            })
        })
    }
}



