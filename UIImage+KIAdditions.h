#import <UIKit/UIKit.h>

@interface UIImage (KIAdditions)

///*垂直翻转*/
//- (UIImage *)flipVertical;
//
///*水平翻转*/
//- (UIImage *)flipHorizontal;

/*改变size*/
- (UIImage *)resizeToWidth:(CGFloat)width height:(CGFloat)height;

/*裁切*/
- (UIImage *)cropImageWithX:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height;

+(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;
@end
