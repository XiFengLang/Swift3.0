//
//  JKImagePickerTool.swift
//  10-自定义相册
//
//  Created by 蒋鹏 on 16/10/20.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit
import Photos

typealias JKImagePickerToolResultBlock = (UIImage?) -> ()
typealias JKImagePickerToolDismissBlock = () -> ()

class JKImagePickerTool: NSObject, UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    private var completion: JKImagePickerToolResultBlock?
    private var dismissBlock: JKImagePickerToolDismissBlock?
    
    func openPhotoLibrary(allowsEditing: Bool, completionHandle: JKImagePickerToolResultBlock?, dismiss: JKImagePickerToolDismissBlock?) -> () {
        self.completion = completionHandle
        self.dismissBlock = dismiss
        self.showImagePickerController(withSourceType: .photoLibrary, cameraCaptureMode: .photo, allowsEditing: allowsEditing)
    }
    
    func openCamara(allowsEditing: Bool, completionHandle: JKImagePickerToolResultBlock?, dismiss: JKImagePickerToolDismissBlock?) -> () {
        self.completion = completionHandle
        self.dismissBlock = dismiss
        self.showImagePickerController(withSourceType: .camera, cameraCaptureMode: .photo, allowsEditing: allowsEditing)
    }
    
    private func showImagePickerController(withSourceType type: UIImagePickerControllerSourceType, cameraCaptureMode mode: UIImagePickerControllerCameraCaptureMode, allowsEditing: Bool) -> () {
        let imagePicker = UIImagePickerController.init().then {
            $0.allowsEditing = allowsEditing
            $0.sourceType = type
            $0.modalPresentationStyle = .overFullScreen
            $0.mediaTypes = ["public.image"]
            $0.delegate = self
            
            if (type == .camera) {
                $0.cameraCaptureMode = mode
                $0.cameraDevice = .rear
                $0.cameraFlashMode = .auto
            }
        }
        UIWindow.currentViewController().present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    /// 代理协议
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        if mediaType == "public.image" {
            let edited = info[UIImagePickerControllerEditedImage]
            let original = info[UIImagePickerControllerOriginalImage]
            
            if edited != nil {
                self.completion?(edited as! UIImage?)
                self.completion = nil
            } else {
                self.completion?(original as! UIImage?)
                self.completion = nil
            }
        } else {
            self.completion?(nil)
            self.completion = nil
        }
        
        picker.dismiss(animated: true) { 
            self.dismissBlock?()
            self.dismissBlock = nil
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.completion?(nil)
        self.completion = nil
        
        picker.dismiss(animated: true) {
            self.dismissBlock?()
            self.dismissBlock = nil
        }
    }
}


