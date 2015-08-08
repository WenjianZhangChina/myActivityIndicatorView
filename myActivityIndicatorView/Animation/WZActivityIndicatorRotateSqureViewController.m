//
//  WZActivityIndicatorRotateSqureViewController.m
//  myActivityIndicatorView
//
//  Created by zwj on 15/8/8.
//  Copyright (c) 2015年 zwj. All rights reserved.
//

#import "WZActivityIndicatorRotateSqureViewController.h"

@implementation WZActivityIndicatorRotateSqureViewController

- (void)moveLayerRotate
{
    
    CALayer *kkLayer = [[CALayer alloc]init];
    kkLayer.backgroundColor = [[UIColor grayColor]CGColor];
    kkLayer.frame = CGRectMake(50, 217, 40, 40);
    kkLayer.cornerRadius = 5;
    [self.view.layer addSublayer:kkLayer];
    
    // 以x轴进行旋转
    CABasicAnimation *rotateAnimation  = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:6.0 * M_PI];
    rotateAnimation.duration = 3;
    rotateAnimation.repeatCount = NSNotFound;
    
    [kkLayer addAnimation:rotateAnimation forKey:@"animationRotate"];
    
}

@end
