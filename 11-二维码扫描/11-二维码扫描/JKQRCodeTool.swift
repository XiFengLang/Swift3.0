//
//  JKQRCodeTool.swift
//  11-二维码扫描
//
//  Created by 蒋鹏 on 16/10/19.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//  识别二维码图片的工具

import UIKit

class JKQRCodeTool: NSObject {
    
    
    /// 识别图片二维码
    class func jk_recognizeQRCodeImage(_ image: UIImage?, completionHandle: @escaping((String?, NSError?) -> Void)) -> Void {
        
        if image == nil || image?.cgImage == nil {
            completionHandle(nil,NSError.init(domain: "JKQRCodeToolError:图片为空，无法识别", code: 9301, userInfo: ["reason":"JKQRCodeToolError:图片为空，无法识别"]))
        } else {
            /// 可用于人脸识别 CIDetectorTypeFace  CIDetectorTypeText CIDetectorTypeQRCode
            let detector = CIDetector.init(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
            /// 扫描获取的特征组
            let features = detector?.features(in: CIImage.init(cgImage: (image?.cgImage)!))
            /// 获取扫描结果
            if features != nil && (features?.count)! > 0 {
                let feature:CIQRCodeFeature = features?.first as! CIQRCodeFeature
                completionHandle(feature.messageString, nil)
            } else {
                completionHandle(nil,NSError.init(domain: "JKQRCodeToolError:无法识别图片内容", code: 9302, userInfo: ["reason":"JKQRCodeToolError:无法识别图片内容"]))
            }
        }
    }
    
    
    ///  生成黑白二维码
    private class func jk_QRCodeImage(withString content: String?, completionHandle: @escaping((CIImage?, NSError?) -> Void)) -> Void{
        if content == nil || content == "" {
            completionHandle(nil,NSError.init(domain: "JKQRCodeToolError:内容为空，无法生成二维码", code: 9303, userInfo: ["reason":"JKQRCodeToolError:内容为空，无法生成二维码"]))
        } else {
            let data = content?.data(using: .utf8)
            /// 创建二维码滤镜   CICode128BarcodeGenerator条形码 CIQRCodeGenerator二维码
            let filter = CIFilter.init(name: "CIQRCodeGenerator")
            filter?.setDefaults()
            /// 数据源
            filter?.setValue(data, forKey: "inputMessage")
            /// L M Q H 修正质量
            filter?.setValue("H", forKey: "inputCorrectionLevel")
            /// 黑白色的图片
            let ciImage = filter?.outputImage
            
            
            if ciImage == nil {
                completionHandle(nil,NSError.init(domain: "JKQRCodeToolError:无法生成二维码", code: 9304, userInfo: ["reason":"JKQRCodeToolError:无法生成二维码"]))
            } else {
                completionHandle(ciImage,nil)
            }
        }
    }
    
    
    /// 生成彩色的二维码
    class func jk_QRCodeImage(withString content: String?, rgbColor: CIColor, size: CGSize, completionHandle: @escaping((UIImage?, NSError?) -> Void)) -> Void{
        self.jk_QRCodeImage(withString: content) { (ciImage, error) in
            if (error != nil) {
                completionHandle(nil, error)
            }else {
                
                /// 创建颜色滤镜
                let colorFilter = CIFilter.init(name: "CIFalseColor")
                colorFilter?.setDefaults()
                colorFilter?.setValue(ciImage, forKey: "inputImage")
                /// 替换黑色
                colorFilter?.setValue(rgbColor, forKey: "inputColor0")
                /// 默认白色，可自行替换
                colorFilter?.setValue(CIColor.init(color: UIColor.white), forKey: "inputColor1")
                let codeImage = colorFilter?.outputImage
                self.jk_resize(ciImage: codeImage!, size: size, completionHandle: completionHandle)
            }
        }
    }
    
    /// 生成二维码图片
    class func jk_QRCodeImage(withString content: String?, size: CGSize, completionHandle: @escaping((UIImage?, NSError?) -> Void)) -> Void{
        self.jk_QRCodeImage(withString: content) { (ciImage, error) in
            if (error != nil){
                completionHandle(nil, error)
            }else {
                self.jk_resize(ciImage: ciImage!, size: size, completionHandle: completionHandle)
            }
        }
    }
    
    
    /// 用CIImage重绘UIImage
    class func jk_resize(ciImage: CIImage, size: CGSize, completionHandle: @escaping((UIImage?, NSError?) -> Void)) -> Void {
        let width = size.width * UIScreen.main.scale
        let height = size.height * UIScreen.main.scale
        
        /// 计算合适的缩放比例
        let scale = min(width, height) / min(ciImage.extent.width, ciImage.extent.height)
        
        /// RGB彩色
        let colorSpaceRef = CGColorSpaceCreateDeviceRGB()
        var contextRef = CGContext.init(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpaceRef, bitmapInfo:CGImageAlphaInfo.noneSkipFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue)
        
        /// 黑白灰
//        let colorSpaceRef = CGColorSpaceCreateDeviceGray()
//        var contextRef = CGContext.init(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpaceRef, bitmapInfo:CGImageAlphaInfo.none.rawValue)
        
        
        let context = CIContext.init(options: nil)
        var imageRef = context.createCGImage(ciImage, from: ciImage.extent)
        contextRef?.interpolationQuality = CGInterpolationQuality.init(rawValue: CGInterpolationQuality.none.rawValue)!
        contextRef?.scaleBy(x: scale, y: scale)
        contextRef?.draw(imageRef!, in: ciImage.extent)
        let newImage = contextRef?.makeImage()
        
        contextRef = nil
        imageRef = nil
        completionHandle(UIImage.init(cgImage: newImage!),nil)
    }
    
    
    /// 添加LOGO小图
    class func jk_addLogo(logo: UIImage?, forQRCodeImage QRImage: UIImage?, completionHandle: @escaping((UIImage?, NSError?) -> Void)) -> Void {
        if logo == nil || logo?.size == CGSize.zero {
            completionHandle(nil,NSError.init(domain: "JKQRCodeToolError:Logo图片内容为空", code: 9305, userInfo: ["reason":"JKQRCodeToolError:Logo图片内容为空"]))
        }else if QRImage == nil || QRImage?.size == CGSize.zero {
            completionHandle(nil,NSError.init(domain: "JKQRCodeToolError:二维码图片内容为空", code: 9306, userInfo: ["reason":"JKQRCodeToolError:二维码图片内容为空"]))
        }else {
            
            let qrImageBounds = CGRect.init(x: 0, y: 0,
                                            width: (QRImage?.size.width)!,
                                            height: (QRImage?.size.height)!)
            let logoSize = CGSize.init(width: qrImageBounds.size.width * 0.25,
                                       height: qrImageBounds.size.height * 0.25)
            let x = (qrImageBounds.width - logoSize.width) * 0.5
            let y = (qrImageBounds.height - logoSize.height) * 0.5
            
            
            UIGraphicsBeginImageContext(qrImageBounds.size)
            QRImage?.draw(in: qrImageBounds)
            logo?.draw(in: CGRect.init(x: x, y: y,
                                       width: logoSize.width,
                                       height: logoSize.height))
            let resultImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            if resultImage != nil {
                completionHandle(resultImage,nil)
            } else {
                completionHandle(nil,NSError.init(domain: "JKQRCodeToolError:添加LOGO，合成图片失败", code: 9307, userInfo: ["reason":"JKQRCodeToolError:添加LOGO，合成图片失败"]))
            }
        }
    }
    

}


