//
//  JKQRTool.h
//  11-二维码扫描
//
//  Created by 蒋鹏 on 16/11/2.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JKQRTool : NSObject


/**
 白色透明，黑色变色

 @param image 原图
 @param red r
 @param green g
 @param blue b
 @return 彩色图
 */
- (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue;



/**
 生成条形码

 @param barCode 内容
 @return 条形码
 */
+ (UIImage *)generateBarCode:(NSString *)barCode;
@end
