//
//  UIViewController+ZWYRotateActivityIndicatorViewController.m
//  myActivityIndicatorView
//
//  Created by zwj on 15/8/9.
//  Copyright (c) 2015年 zwj. All rights reserved.
//

#import "UIViewController+ZWYRotateActivityIndicatorViewController.h"

@implementation UIViewController (ZWYRotateActivityIndicatorViewController)

- (void)moveLayerYRotate
{
    
    CALayer *kkLayer = [[CALayer alloc]init];
    kkLayer.backgroundColor = [[UIColor grayColor]CGColor];
    kkLayer.frame = CGRectMake(100, 217, 40, 40);
    kkLayer.cornerRadius = 5;
    [self.view.layer addSublayer:kkLayer];
    
    // 以y轴进行旋转
    CABasicAnimation *rotateAnimation  = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:6.0 * M_PI];
    rotateAnimation.duration = 3;
    rotateAnimation.repeatCount = NSNotFound;
    
    [kkLayer addAnimation:rotateAnimation forKey:@"animationRotate"];
    
}


@end
