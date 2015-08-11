//
//  ActivityIndicatorView.h
//  myActivityIndicatorView
//
//  Created by zwj on 15/8/9.
//  Copyright (c) 2015年 zwj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WZSpinKitViewStyle) {
    WZSpinKitViewStylePlane,
    WZSpinKitViewStyleBounce,
    WZSpinKitViewStyleWave,
    WZSpinKitViewStyleWanderingCubes,
    WZSpinKitViewStylePulse,
    WZActivityIndicatorStyleRotateSquare,
    WZActivityIndicatorStyleBulb,
};

@interface WZSpinKitView : UIView

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) BOOL hidesWhenStopped;

-(instancetype)initWithStyle:(WZSpinKitViewStyle)style;
-(instancetype)initWithStyle:(WZSpinKitViewStyle)style color:(UIColor*)color;

-(void)startAnimating;
-(void)stopAnimating;

@end
