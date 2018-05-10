//
//  ImageUtils.h
//  Hygieia
//
//  Created by apple on 14-9-30.
//  Copyright (c) 2014年 ytz. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ImageUtils : NSObject
//图片的宽度
#define DEFAUT_WIDTH 400.0f


//将图片保存在沙盒中
+(void)saveImageToDocument:(UIImage *)image imageName:(NSString *)imagename;
// 处理图片
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+ (UIImage *)imageScaledToDefautSizeWithImage:(UIImage *)image ;

+(void)setViewShapeCircle:(UIView*)view;
//将图片切成圆形贴入UIImageView中
+(void)showPhotoWithImage:(UIImage*)img AndUIImageView:(UIImageView*)imgView;
+(void)showPhotoWithImage:(UIImage*)img InUIButton:(UIButton*)bottun;
+(void)setImage:(UIImage*)img ShapeImgName:(NSString*)shape ImageView:(UIImageView*)view;
//从沙盒中通过Id取得图片
+(UIImage*)readImageFromSandBoxByDeviceId:(NSString*)did;

//获得某个范围内的屏幕图像
+(UIImage *)imageFromView: (UIView *) theView   atFrame:(CGRect)r;
//获得屏幕图像
+ (UIImage *)imageFromView: (UIView *) theView;
//全屏截图，包括window
+(UIImage *)fullScreenshots;
@end
