

#import "Bolloon.h"

@implementation Bolloon

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self != nil){
        
    }
    return self;
}

- (void)setFrame:(CGFloat)x Y:(CGFloat)y Width:(CGFloat)width Height:(CGFloat)height {
    CGRect rect = CGRectMake(x, y, width, height);
    self.frame = rect;
}

- (id)initWithString:(NSString *)info frame:(CGRect)frame is:(BOOL) isUp{
    self = [super initWithFrame:frame];
    if(self != nil){
        NSDictionary *nameAttribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
        CGSize strSize = [info boundingRectWithSize:CGSizeMake(500, 100) options: NSStringDrawingTruncatesLastVisibleLine  attributes:nameAttribute context:nil].size;
        
        self.back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.info = [[UILabel alloc] init];
        self.info.numberOfLines = 0;
        self.info.font = [UIFont systemFontOfSize:14];
        self.info.textAlignment = NSTextAlignmentCenter;
        self.info.textColor = [UIColor whiteColor];
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        
        self.info.text = info;
        if (isUp){
            NSString *p = [[NSBundle mainBundle] resourcePath];
            NSString *path = [p stringByAppendingString:@"/气泡.png"];
            
            self.back.image = [UIImage imageWithContentsOfFile:path];
            self.info.frame = CGRectMake(0, 0.35 * height, width, strSize.height);
        }else{
            NSString *p = [[NSBundle mainBundle] resourcePath];
            NSString *path = [p stringByAppendingString:@"/下气泡.png"];
            
            self.back.image = [UIImage imageWithContentsOfFile:path];
            self.info.frame = CGRectMake(0, 0.5 * height, width, strSize.height);
        }
        [self addSubview:self.back];
        [self addSubview:self.info];
    }
    return self;
}

@end
