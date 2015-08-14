//
//  ActivityIndicatorView.h
//  myActivityIndicatorView
//
//  Created by zwj on 15/8/9.
//  Copyright (c) 2015年 zwj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WZActivityIndicatorStyle) {
    WZActivityIndicatorStyleRevolution,
    WZActivityIndicatorStyleHeart,
    WZActivityIndicatorStyleRotateSquare,
    WZActivityIndicatorStyleMicrosoft,
    WZActivityIndicatorStyleLights,
    WZActivityIndicatorStyleBounce,
    WZActivityIndicatorStyleWave,
};

@interface WZActivityIndicatorView : UIView

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) BOOL hidesWhenStopped;

-(instancetype)initWithStyle:(WZActivityIndicatorStyle)style;
-(instancetype)initWithStyle:(WZActivityIndicatorStyle)style color:(UIColor*)color;

-(void)startAnimating;
-(void)stopAnimating;

@end
