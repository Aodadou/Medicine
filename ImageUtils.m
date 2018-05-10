//
//  ImageUtils.m
//  Hygieia
//
//  Created by apple on 14-9-30.
//  Copyright (c) 2014年 ytz. All rights reserved.
//

#import "ImageUtils.h"

@implementation ImageUtils

+(void)saveImageToDocument:(UIImage *)image imageName:(NSString *)imageName
{
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *filePath = [[paths objectAtIndex:0]stringByAppendingPathComponent:[NSString stringWithFormat:imageName,nil]];  // 保存文件的名称
    [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //    UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
+ (UIImage *)imageScaledToDefautSizeWithImage:(UIImage *)image{
    float defautHeight = DEFAUT_WIDTH/image.size.width*image.size.height;
    return [ImageUtils imageWithImage:image scaledToSize:CGSizeMake(DEFAUT_WIDTH, defautHeight)];
}

+(void)setViewShapeCircle:(UIView*)view{
    view.layer.cornerRadius = view.frame.size.width/2;
    view.layer.masksToBounds = YES;
}

+(void)showPhotoWithImage:(UIImage*)img AndUIImageView:(UIImageView*)imgView {
    
    imgView.image = img;
    // 把图片设置成圆形。 我这里在故事版里面设置的imageView是一个正方形(因为头像图片都是放在正方形的imageView里)
    imgView.layer.cornerRadius = imgView.frame.size.width/2;//裁成圆角
    imgView.layer.masksToBounds = YES;//隐藏裁剪掉的部分
    //  给图片加一个圆形边框
    imgView.layer.borderWidth = 2.0f;//边框宽度
    imgView.layer.borderColor = [UIColor colorWithRed:118.0 / 255 green:166.0 / 255 blue:239.0 / 255 alpha:1.0].CGColor;//边框颜色

    
//    UIGraphicsBeginImageContext(imgView.bounds.size);
//    CGContextRef ctx=UIGraphicsGetCurrentContext();
//    CGContextFillRect(ctx, CGRectMake(0, 0, imgView.bounds.size.width, imgView.bounds.size.height));
//    UIGraphicsEndImageContext();
//    //根据下面相框1的样式截取圆形图片
//    UIImage *roundCorner = [UIImage imageNamed:@"相框1.png"];
//    imgView.image = img;
//    CALayer* roundCornerLayer = [CALayer layer];
//    //roundCornerLayer.borderWidth = 2;
//    roundCornerLayer.frame = imgView.bounds;
//    roundCornerLayer.contents = (id)[roundCorner CGImage];
//    [[imgView layer] setMask:roundCornerLayer];
}
+(void)showPhotoWithImage:(UIImage *)img InUIButton:(UIButton *)bottun{
    UIGraphicsBeginImageContext(bottun.bounds.size);
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextFillRect(ctx, CGRectMake(0, 0, bottun.bounds.size.width, bottun.bounds.size.height));
    UIGraphicsEndImageContext();
    //根据下面相框1的样式截取圆形图片
    UIImage *roundCorner = [UIImage imageNamed:@"相框1.png"];
    [bottun setImage:img forState:UIControlStateNormal];
    CALayer* roundCornerLayer = [CALayer layer];
    roundCornerLayer.frame = bottun.bounds;
    roundCornerLayer.contents = (id)[roundCorner CGImage];
    [[bottun layer] setMask:roundCornerLayer];

}

+(void)setImage:(UIImage*)img ShapeImgName:(NSString*)shape ImageView:(UIImageView*)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextFillRect(ctx, CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height));
    UIGraphicsEndImageContext();
    //根据下面相框1的样式截取圆形图片
    UIImage *roundCorner = [UIImage imageNamed:shape];
//    view.image = img;
    [view setImage:img];
    CALayer* roundCornerLayer = [CALayer layer];
    
    roundCornerLayer.frame = view.bounds;
    roundCornerLayer.contents = (id)[roundCorner CGImage];
    [[view layer] setMask:roundCornerLayer];


}

//从沙盒中通过Id取得图片
+(UIImage*)readImageFromSandBoxByDeviceId:(NSString*)did{
    if (nil == did) {
        return nil;
    }
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[path objectAtIndex:0] stringByAppendingPathComponent:did ];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    UIImage *tempImage;
    
    tempImage = [UIImage imageWithData:data scale:200];
    
    if (tempImage == nil) {
        tempImage = [UIImage imageNamed:@"默认头像.png"];
    }
    return  tempImage;
}


//获得屏幕图像
+ (UIImage *)imageFromView: (UIView *) theView
{
    
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

//获得某个范围内的屏幕图像
+(UIImage *)imageFromView: (UIView *) theView   atFrame:(CGRect)r
{
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(r);
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return  theImage;//[self getImageAreaFromImage:theImage atFrame:r];
}
//全屏截图，包括window
+(UIImage *)fullScreenshots{
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    
    UIGraphicsBeginImageContext(screenWindow.frame.size);//全屏截图，包括window
    
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();

    return viewImage;
//    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    
}
@end
