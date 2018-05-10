

#import <UIKit/UIKit.h>
#import "UIImage+KIAdditions.h"

@class KICropImageMaskView;
@interface KICropImageView : UIView <UIScrollViewDelegate> {
    @private
    UIScrollView        *_scrollView;
    UIImageView         *_imageView;
    KICropImageMaskView *_maskView;
    UIImage             *_image;
    UIEdgeInsets        _imageInset;
    CGSize              _cropSize;
}

- (void)setImage:(UIImage *)image;
- (void)setCropSize:(CGSize)size;

- (UIImage *)cropImage;

@end

@interface KICropImageMaskView : UIView {
    @private CGRect  _cropRect;
}
- (void)setCropSize:(CGSize)size;
- (CGSize)cropSize;
@end