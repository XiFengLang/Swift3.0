//
//  JKQRScanViewController.swift
//  11-二维码扫描
//
//  Created by 蒋鹏 on 16/10/18.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit
import AVFoundation

class JKQRScanViewController: JKBaseViewController,AVCaptureMetadataOutputObjectsDelegate {

    private var scanRect: CGRect?
    private var deviceInput: AVCaptureDeviceInput?
    private var session: AVCaptureSession?
    private var outPut: AVCaptureMetadataOutput?
    private var scanLineImageView: UIImageView?
    private var isOn: Bool?
    
    lazy private var myTimer: Timer? = {
        return Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(resetExposureModeAndFocusMode), userInfo: nil, repeats: true)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isOn = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "返回", style: .plain, target: nil, action: nil)
        self.navigationItem.title = "二维码/条形码"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "退出", style: .plain, target: self, action: #selector(JKQRScanViewController.jk_didClickedLeftBarButtonItem))
        
        if isiPhone() {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "闪光灯", style: .plain, target: self, action: #selector(JKQRScanViewController.jk_didClickedRightBarButtonItem))
        }
        
        let sideMargin = JKScreenWidth() * 0.4 + 100
        self.scanRect = CGRect.init(x: (JKScreenWidth() - sideMargin) * 0.5,
                                    y: (JKScreenHeight() - sideMargin) * 0.5,
                                    width: sideMargin, height: sideMargin)
        
        JKAppAuthorizationRequest.requestCameraAuthorization { (authorized) in
            if (authorized) {
                self.setupCaptureSession()
                self.startScanAnitmation()
            }else {
                self.jk_didClickedLeftBarButtonItem()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (self.session != nil) && (self.deviceInput != nil) {
            if self.session?.isRunning == false {
                self.session?.addInput(self.deviceInput)
                self.session?.addOutput(self.outPut)
                self.session?.startRunning()
            }
            
            self.myTimer?.fire()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if (self.session != nil) && (self.deviceInput != nil) {
            if (self.session?.isRunning)! {
                self.session?.stopRunning()
                self.session?.removeInput(self.deviceInput)
                self.session?.removeOutput(self.outPut)
            }
            
            self.myTimer?.invalidate()
            self.myTimer = nil
        }
    }
    
    
    private func setupCaptureSession() -> Void {
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        self.deviceInput = try? AVCaptureDeviceInput.init(device: device)
        if self.deviceInput != nil {
            self.session = AVCaptureSession.init()
            
            /// 设置读取质量
            let block = {
                if (self.session?.canSetSessionPreset(AVCaptureSessionPreset1920x1080))! {
                    self.session?.sessionPreset = AVCaptureSessionPreset1920x1080
                } else if (self.session?.canSetSessionPreset(AVCaptureSessionPreset1280x720))! {
                    self.session?.sessionPreset = AVCaptureSessionPreset1280x720
                } else {
                    self.session?.sessionPreset = AVCaptureSessionPresetPhoto
                }
            }
            
            if #available(iOS 9.0, *) {
                if (self.session?.canSetSessionPreset(AVCaptureSessionPreset3840x2160))! {
                    self.session?.sessionPreset = AVCaptureSessionPreset3840x2160
                }else {
                    block()
                }
            }else{
                block()
            }
            
            self.session?.addInput(self.deviceInput)
            self.outPut = AVCaptureMetadataOutput.init()
            self.session?.addOutput(self.outPut)
            /// 主线程刷新数据
            self.outPut?.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            /// 扫码类型
            self.outPut?.metadataObjectTypes = [AVMetadataObjectTypeEAN13Code,
                                                AVMetadataObjectTypeEAN8Code,
                                                AVMetadataObjectTypeCode128Code,
                                                AVMetadataObjectTypeQRCode]
            /// 兴趣点
            self.outPut?.rectOfInterest = CGRect.init(x: (scanRect?.origin.y)! / JKScreenHeight(),
                                                      y: (scanRect?.origin.x)! / JKScreenWidth(),
                                                      width: (scanRect?.size.height)! / JKScreenHeight(),
                                                      height: (scanRect?.size.width)! / JKScreenWidth())
            
            /// 预览图层
            let previewLayer = AVCaptureVideoPreviewLayer.init(session: self.session)
            previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            previewLayer?.frame = self.view.bounds
            self.view.layer.addSublayer(previewLayer!)
            
            self.session?.startRunning()
            
            var rect = CGRect.init(x: 0,
                                   y: 0,
                                   width: JKScreenWidth(),
                                   height: (scanRect?.origin.y)!)
            self.view.layer.addSublayer(self.layer(withFrame: rect))
            
            rect = CGRect.init(x: 0,
                               y: (scanRect?.maxY)!,
                               width: JKScreenWidth(),
                               height: JKScreenHeight() - (scanRect?.maxY)!)
            self.view.layer.addSublayer(self.layer(withFrame: rect))
            
            rect = CGRect.init(x: 0,
                               y: (scanRect?.origin.y)!,
                               width: (scanRect?.origin.x)!,
                               height: (scanRect?.size.height)!)
            self.view.layer.addSublayer(self.layer(withFrame: rect))
            
            rect = CGRect.init(x: (scanRect?.maxX)!,
                               y: (scanRect?.origin.y)!,
                               width: JKScreenWidth() - (scanRect?.maxX)!,
                               height: (scanRect?.size.height)!)
            self.view.layer.addSublayer(self.layer(withFrame: rect))
            
            let sideMargin:CGFloat = 35.0
            var halfLineWidth:CGFloat = 0.6
            
            /// 中间
            var beziePath = UIBezierPath.init()
            var shapeLayer = CAShapeLayer.init()
            
            beziePath.move(to: CGPoint.init(x: (scanRect?.origin.x)! + halfLineWidth,
                                            y: (scanRect?.origin.y)! + halfLineWidth))
            beziePath.addLine(to: CGPoint.init(x: (scanRect?.maxX)! - halfLineWidth,
                                               y: (scanRect?.origin.y)! - halfLineWidth))
            beziePath.addLine(to: CGPoint.init(x: (scanRect?.maxX)! - halfLineWidth,
                                               y: (scanRect?.maxY)! - halfLineWidth))
            beziePath.addLine(to: CGPoint.init(x: (scanRect?.origin.x)! + halfLineWidth,
                                               y: (scanRect?.maxY)! - halfLineWidth))
            beziePath.addLine(to: CGPoint.init(x: (scanRect?.origin.x)! + halfLineWidth,
                                               y: (scanRect?.origin.y)! + halfLineWidth))
            
            shapeLayer.path = beziePath.cgPath
            shapeLayer.strokeColor = UIColor.init(red: 230.0 / 255.0,
                                                  green: 230.0 / 255.0,
                                                  blue: 230.0 / 255.0,
                                                  alpha: 0.9).cgColor
            shapeLayer.lineWidth = halfLineWidth * 2.0
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.lineJoin = kCALineJoinMiter
            self.view.layer.addSublayer(shapeLayer)
            
            
            beziePath = UIBezierPath.init()
            shapeLayer = CAShapeLayer.init()
            halfLineWidth = 3.0
            
            /// 左上角
            beziePath.move(to: CGPoint.init(x: (scanRect?.origin.x)! + halfLineWidth,
                                            y: (scanRect?.origin.y)! + sideMargin))
            beziePath.addLine(to: CGPoint.init(x: (scanRect?.origin.x)! + halfLineWidth,
                                               y: (scanRect?.origin.y)! + halfLineWidth))
            beziePath.addLine(to: CGPoint.init(x: (scanRect?.origin.x)! + sideMargin,
                                               y: (scanRect?.origin.y)! + halfLineWidth))
            
            /// 右上角
            beziePath.move(to: CGPoint.init(x: (scanRect?.maxX)! - sideMargin,
                                            y: (scanRect?.origin.y)! + halfLineWidth))
            beziePath.addLine(to: CGPoint.init(x: (scanRect?.maxX)! - halfLineWidth,
                                               y: (scanRect?.origin.y)! + halfLineWidth))
            beziePath.addLine(to: CGPoint.init(x: (scanRect?.maxX)! - halfLineWidth,
                                               y: (scanRect?.origin.y)! + sideMargin))
            
            /// 右下角
            beziePath.move(to: CGPoint.init(x: (scanRect?.maxX)! - halfLineWidth,
                                            y: (scanRect?.maxY)! - sideMargin))
            beziePath.addLine(to: CGPoint.init(x: (scanRect?.maxX)! - halfLineWidth,
                                               y: (scanRect?.maxY)! - halfLineWidth))
            beziePath.addLine(to: CGPoint.init(x: (scanRect?.maxX)! - sideMargin,
                                               y: (scanRect?.maxY)! - halfLineWidth))
            
            /// 左下角
            beziePath.move(to: CGPoint.init(x: (scanRect?.origin.x)! + sideMargin,
                                            y: (scanRect?.maxY)! - halfLineWidth))
            beziePath.addLine(to: CGPoint.init(x: (scanRect?.origin.x)! + halfLineWidth,
                                               y: (scanRect?.maxY)! - halfLineWidth))
            beziePath.addLine(to: CGPoint.init(x: (scanRect?.origin.x)! + halfLineWidth,
                                               y: (scanRect?.maxY)! - sideMargin))
            
            shapeLayer.path = beziePath.cgPath
            shapeLayer.strokeColor = UIColor.init(red: 12.0 / 255.0,
                                                  green: 196.0 / 255.0,
                                                  blue: 120.0 / 255.0,
                                                  alpha: 1).cgColor
            shapeLayer.lineWidth = halfLineWidth * 2.0
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.lineJoin = kCALineJoinMiter
            self.view.layer.addSublayer(shapeLayer)
            
            let _ = UILabel.init().then(block: { (label) in
                label.textColor = UIColor.white
                label.text = "将二维码/条形码放入框内，即可自动扫描"
                label.sizeToFit()
                label.center = CGPoint.init(x: JKScreenWidth() * 0.5,
                                            y: (scanRect?.maxY)! + 10 + label.frame.height * 0.5)
                self.view.addSubview(label)
            })
            
            
        } else {
            JKLOG("初始化出错")
            self.jk_didClickedLeftBarButtonItem()
        }
    }
    
    private func startScanAnitmation() -> Void {
        let baseView = UIView.init(frame: scanRect!).then { (view) in
            view.backgroundColor = UIColor.clear
            view.clipsToBounds = true
        }
        self.view.addSubview(baseView)
        
        let startFrame = CGRect.init(x: 3, y: -4, width: (scanRect?.width)! - 6, height: 8)
        self.scanLineImageView = UIImageView.init(frame: startFrame).then(block: { (imageView) in
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage.init(named: "JKQRScanLine")
        })
        self.view.addSubview(self.scanLineImageView!)
        
        let animation = CABasicAnimation.init(keyPath: "transform.translation.y")
        animation.duration = 1.5
        animation.repeatCount = MAXFLOAT
        animation.fromValue = "-4"
        animation.toValue = NSString.init(format: "%f", (self.scanRect?.height)! + 4.0)
        self.scanLineImageView?.layer.add(animation, forKey: "JKQRScanAnimationKey")
    }
    
    func layer(withFrame frame: CGRect) -> CALayer {
        return CALayer.init().then(block: { (layer) in
            layer.frame = frame
            layer.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5).cgColor
        })
    }
    
    
    /// leftBarButtonItem退出
    @objc private func jk_didClickedLeftBarButtonItem() -> Void {
        if ((self.navigationController?.viewControllers.count)! > 1) {
            _ = self.navigationController?.popViewController(animated: true)
        }else{
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    /// RightBarButtonItem闪光灯
    @objc private func jk_didClickedRightBarButtonItem() -> Void {
        self.isOn = !self.isOn!
        if (self.deviceInput?.device.hasTorch)! && (self.deviceInput?.device.hasFlash)! {
            try! self.deviceInput?.device.lockForConfiguration()
            if self.isOn == true {
                self.deviceInput?.device.torchMode = AVCaptureTorchMode.on
                self.deviceInput?.device.flashMode = AVCaptureFlashMode.on
            }else {
                self.deviceInput?.device.torchMode = AVCaptureTorchMode.off
                self.deviceInput?.device.flashMode = AVCaptureFlashMode.off
            }
            self.deviceInput?.device.unlockForConfiguration()
        }
    }
    
    
    /// 自动对焦、曝光
    @objc private func resetExposureModeAndFocusMode() -> () {
        if self.deviceInput == nil {
            return
        }
        
        if self.deviceInput?.device == nil {
            return
        }
        
        do {
            try self.deviceInput?.device.lockForConfiguration()
            self.session?.beginConfiguration()
            
            if (self.deviceInput?.device.isFocusModeSupported(.continuousAutoFocus))! {
                self.deviceInput?.device.focusMode = .continuousAutoFocus
            } else if (self.deviceInput?.device.isFocusModeSupported(.autoFocus))! {
                self.deviceInput?.device.focusMode = .autoFocus
            } else if (self.deviceInput?.device.isFocusModeSupported(.locked))! {
                self.deviceInput?.device.focusMode = .locked
            }else {
                JKLOG("聚焦模式修改失败")
            }
            
            if (self.deviceInput?.device.isFocusPointOfInterestSupported)! {
                self.deviceInput?.device.focusPointOfInterest = CGPoint.init(x: 0.5, y: 0.5)
            }
            
            if (self.deviceInput?.device.isExposureModeSupported(.continuousAutoExposure))! {
                self.deviceInput?.device.exposureMode = .continuousAutoExposure
            } else if (self.deviceInput?.device.isExposureModeSupported(.autoExpose))! {
                self.deviceInput?.device.exposureMode = .autoExpose
            } else if (self.deviceInput?.device.isExposureModeSupported(.custom))! {
                self.deviceInput?.device.exposureMode = .custom
            } else if (self.deviceInput?.device.isExposureModeSupported(.locked))! {
                self.deviceInput?.device.exposureMode = .locked
            }else {
                JKLOG("曝光模式修改失败")
            }
            
            if (self.deviceInput?.device.isExposurePointOfInterestSupported)! {
                self.deviceInput?.device.exposurePointOfInterest = CGPoint.init(x: 0.5, y: 0.5)
            }
            
            self.deviceInput?.device.unlockForConfiguration()
            self.session?.commitConfiguration()
            
        } catch {
            JKLOG("锁定设备过程error，错误信息：\(error.localizedDescription)");
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        if metadataObjects.count > 0 {
            let obj = metadataObjects.first as! AVMetadataMachineReadableCodeObject
            JKLOG(obj.stringValue)
            self.session?.stopRunning()
            self.session?.removeInput(self.deviceInput)
            self.session?.removeOutput(self.outPut)
            self.jk_didClickedLeftBarButtonItem()
        }
    }
}

