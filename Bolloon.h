

#import <UIKit/UIKit.h>

@interface Bolloon : UIView
@property (nonatomic, strong) UILabel *info;
@property (nonatomic, strong) UIImageView *back;

-(id)initWithString:(NSString *) info frame:(CGRect)frame is:(BOOL) isUp;

-(void)setFrame:(CGFloat) x Y:(CGFloat)y Width:(CGFloat)width Height:(CGFloat)height;
@end
