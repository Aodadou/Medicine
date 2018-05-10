//
//  UIViewController+BarButton.m
//  MedicineBox
//
//  Created by 吴杰平 on 2017/10/12.
//  Copyright © 2017年 jxm. All rights reserved.
//

#import "UIViewController+BarButton.h"
#import "ImageUtils.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SystemVersion [[UIDevice currentDevice] systemVersion].integerValue

@implementation UIViewController (BarButton)

- (void)addLeftBarButtonWithImage:(UIImage *)image action:(SEL)action

{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,0,44,44)];
    
    view.backgroundColor = [UIColor clearColor];
    
    
    
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    firstButton.frame = CGRectMake(0, 0, 44, 44);
    
    [firstButton setImage:image forState:UIControlStateNormal];
    
    [firstButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    
    if (SystemVersion >= 11) {
        
        firstButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
        
        [firstButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5 *SCREEN_WIDTH /375.0,0,0)];
        
    }
    
    
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:firstButton];
    
    
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
}

//右侧一个图片按钮的情况

- (void)addRightBarButtonWithFirstImage:(UIImage *)firstImage action:(SEL)action

{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,0,44,44)];
    
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    firstButton.frame = CGRectMake(0, 0, 44, 44);
    
    [view addSubview:firstButton];
    
    [firstButton setImage:firstImage forState:UIControlStateNormal];
    
    [ImageUtils setViewShapeCircle:firstButton];
    
    [firstButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    if (SystemVersion >= 11) {
        
        firstButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
        
        [firstButton setImageEdgeInsets:UIEdgeInsetsMake(0,0,0, -5 * SCREEN_WIDTH /375.0)];
        
    }
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    
    
    //        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
    //        let rightButton = UIButton(type: .custom)
    //        rightButton.frame = CGRect(x: 10, y: 0, width: 40, height: 40)
    //        rightButton.setImage(image, for: .normal)
    //        ImageUtils.setViewShapeCircle(rightButton);
    //        rightView.addSubview(rightButton)
    //        self.view.addSubview(rightView)
    //        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightView)
}

//右侧为文字item的情况

- (void)addRightBarButtonItemWithTitle:(NSString *)itemTitle action:(SEL)action

{
    
    
    UIButton *rightbBarButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,88,44)];
    
    [rightbBarButton setTitle:itemTitle forState:(UIControlStateNormal)];
    
    [rightbBarButton setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    
    rightbBarButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [rightbBarButton addTarget:self action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    if (SystemVersion >= 11) {
        
        rightbBarButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
        
        [rightbBarButton setTitleEdgeInsets:UIEdgeInsetsMake(0,0,0, -5 * SCREEN_WIDTH/375.0)];
        
    }
    
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightbBarButton];
    
}

//左侧为文字item的情况

- (void)addLeftBarButtonItemWithTitle:(NSString *)itemTitle action:(SEL)action

{
    
    UIButton *leftbBarButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,44,44)];
    
    [leftbBarButton setTitle:itemTitle forState:(UIControlStateNormal)];
    
    [leftbBarButton setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    
    leftbBarButton.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [leftbBarButton addTarget:self action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    if (SystemVersion >= 11) {
        
        leftbBarButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
        
        [leftbBarButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -5  *SCREEN_WIDTH/375.0,0,0)];
        
    }
    
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftbBarButton];
    
}

//右侧两个图片item的情况

- (void)addRightTwoBarButtonsWithFirstImage:(UIImage *)firstImage firstAction:(SEL)firstAction secondImage:(UIImage *)secondImage secondAction:(SEL)secondAction

{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,0,80,44)];
    
    view.backgroundColor = [UIColor clearColor];
    
    
    
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    firstButton.frame = CGRectMake(44, 6, 30, 30);
    
    [firstButton setImage:firstImage forState:UIControlStateNormal];
    
    [firstButton addTarget:self action:firstAction forControlEvents:UIControlEventTouchUpInside];
    
    if (SystemVersion >= 11) {
        
        firstButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
        
        [firstButton setImageEdgeInsets:UIEdgeInsetsMake(0,0,0, -5 * SCREEN_WIDTH/375.0)];
        
    }
    
    [view addSubview:firstButton];
    
    
    
    UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    secondButton.frame = CGRectMake(6, 6, 30, 30);
    
    [secondButton setImage:secondImage forState:UIControlStateNormal];
    
    [secondButton addTarget:self action:secondAction forControlEvents:UIControlEventTouchUpInside];
    
    if (SystemVersion >= 11) {
        
        secondButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
        
        [secondButton setImageEdgeInsets:UIEdgeInsetsMake(0,0,0, -5 * SCREEN_WIDTH/375.0)];
        
    }
    
    [view addSubview:secondButton];
    
    
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
    
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
}


@end
