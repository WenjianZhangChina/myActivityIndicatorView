//
//  ActivityIndicatorView.m
//  myActivityIndicatorView
//
//  Created by zwj on 15/8/9.
//  Copyright (c) 2015年 zwj. All rights reserved.
//

#import "ActivityIndicatorView.h"

#include <tgmath.h>

static CATransform3D WZSpinKit3DRotationWithPerspective(CGFloat perspective,
                                                        CGFloat angle,
                                                        CGFloat x,
                                                        CGFloat y,
                                                        CGFloat z)
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = perspective;
    return CATransform3DRotate(transform, angle, x, y, z);
}

@interface WZActivityIndicatorView ()
@property (nonatomic, assign) WZActivityIndicatorStyle style;
@property (nonatomic, assign) BOOL stopped;
@end

@implementation WZActivityIndicatorView

-(instancetype)initWithStyle:(WZActivityIndicatorStyle)style {
    return [self initWithStyle:style color:[UIColor grayColor]];
}

-(instancetype)initWithStyle:(WZActivityIndicatorStyle)style color:(UIColor*)color {
    self = [super init];
    if (self) {
        _style = style;
        _color = color;
        
        [self sizeToFit];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationWillEnterForeground)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidEnterBackground)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
    
        switch (style){
                
            //  第一个activityIndicator模拟太阳－地球－月球的转动
            case WZActivityIndicatorStyleRevolution :{
                
                // 太阳
                CALayer *sun = [CALayer layer];
                sun.frame = CGRectMake(-60, -80, 160, 160);
                sun.backgroundColor = [[UIColor colorWithRed:1 green:0.2 blue:0 alpha:1.0]CGColor];
                sun.anchorPoint = CGPointMake(0.5, 0.5);
                sun.opacity = 1.0;
                sun.cornerRadius = CGRectGetHeight(sun.bounds) * 0.5;
                [self.layer addSublayer:sun];
                // 地球
                CALayer *earth = [CALayer layer];
                earth.frame = CGRectMake(-90, 0, 40, 40);
                earth.backgroundColor = [[UIColor colorWithRed:0.1 green:0.1 blue:0.8 alpha:1.0]CGColor];
                //earth.anchorPoint = CGPointMake(0.5, 0.5);
                earth.opacity = 1.0;
                earth.cornerRadius = CGRectGetHeight(earth.bounds) * 0.5;
                [sun addSublayer:earth];
                // 月球
                CALayer *moon = [CALayer layer];
                moon.frame = CGRectMake(-10, 0, 10, 10);
                moon.backgroundColor = [[UIColor colorWithRed:0.903 green:0.7 blue:0.5 alpha:1.0] CGColor];
                moon.opacity = 1.0;
                moon.cornerRadius = CGRectGetHeight(moon.bounds) * 0.5;
                [earth addSublayer:moon];
                // 转动动画
                CABasicAnimation *revolution  = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                revolution.fromValue = [NSNumber numberWithFloat:0.0];
                revolution.toValue = [NSNumber numberWithFloat:2.0 * M_PI];
                revolution.duration = 4;
                revolution.repeatCount = HUGE_VALF;
                
                [sun addAnimation:revolution forKey:@"revolution"];
                [earth addAnimation:revolution forKey:@"rotation"];
                break;
            }
            //  第二个activityIndicator是一个跳动的心形
            case WZActivityIndicatorStyleHeart:{
                
                // 加载图片
                UIImage *image = [UIImage imageNamed:@"heart.png"];
                CALayer *kLayer = [[CALayer alloc]init];
                kLayer.backgroundColor = [[UIColor whiteColor]CGColor];
                kLayer.frame = CGRectMake(0, 0, 40, 40);
                kLayer.contents = (id) image.CGImage;
                [self.layer addSublayer:kLayer];
                
                // 对kLayer进行放大缩小
                CABasicAnimation *XZoom  = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
                XZoom.duration = 2;
                XZoom.autoreverses = YES;
                XZoom.fromValue = [NSNumber numberWithFloat:1.0];
                XZoom.toValue = [NSNumber numberWithFloat:2.5];
                XZoom.fillMode = kCAFillModeForwards;
                XZoom.repeatCount = NSNotFound;
                
                CABasicAnimation *YZoom  = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
                YZoom.duration = 2;
                YZoom.autoreverses = YES;
                YZoom.fromValue = [NSNumber numberWithFloat:1.0];
                YZoom.toValue = [NSNumber numberWithFloat:2.5];
                YZoom.fillMode = kCAFillModeForwards;
                YZoom.repeatCount = NSNotFound;
                
                // 动画组合起来，让XY轴一起缩放
                CAAnimationGroup *zoom = [CAAnimationGroup animation];
                zoom.animations = [NSArray arrayWithObjects:XZoom, YZoom,nil];
                zoom.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                zoom.duration = 4;
                //group.fillMode = kCAFillModeForwards;
                //group.removedOnCompletion = NO;
                zoom.repeatCount = NSNotFound;
                
                [kLayer addAnimation:zoom forKey:@"zoom"];
                
                break;
            }
            //  一个旋转的圆角方块，三个轴的旋转有叠加的部分，产生炫酷的效果
            case WZActivityIndicatorStyleRotateSquare:{
                CALayer *kkLayer = [[CALayer alloc]init];
                kkLayer.backgroundColor = [[UIColor colorWithRed:0.622 green:0.403 blue:0.211 alpha:1]CGColor];
                kkLayer.frame = CGRectMake(0, 0, 40, 40);
                kkLayer.cornerRadius = 5;
                [self.layer addSublayer:kkLayer];
                
                // 以x轴进行旋转
                CABasicAnimation *rotateXAnimation  = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
                rotateXAnimation.fromValue = [NSNumber numberWithFloat:0.0];
                rotateXAnimation.toValue = [NSNumber numberWithFloat:2.0 * M_PI];
                rotateXAnimation.duration = 2;
                rotateXAnimation.repeatCount = NSNotFound;
                rotateXAnimation.repeatDuration = 3.0f;
                // 以y轴进行旋转
                CABasicAnimation *rotateYAnimation  = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
                rotateYAnimation.fromValue = [NSNumber numberWithFloat:0.0];
                rotateYAnimation.toValue = [NSNumber numberWithFloat:2.0 * M_PI];
                rotateYAnimation.duration = 2;
                rotateYAnimation.repeatCount = NSNotFound;
                rotateYAnimation.beginTime = 2.0f;
                rotateYAnimation.repeatDuration = 3.0f;
                // 以z轴进行旋转
                CABasicAnimation *rotateZAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                rotateZAnimation.fromValue = [NSNumber numberWithFloat:0.0];
                rotateZAnimation.toValue = [NSNumber numberWithFloat:2.0 * M_PI];
                rotateZAnimation.duration = 2;
                rotateZAnimation.repeatCount = NSNotFound;
                rotateZAnimation.beginTime = 4.0f;
                
                CAAnimationGroup *group = [CAAnimationGroup animation];
                group.animations = [NSArray arrayWithObjects:rotateXAnimation, rotateYAnimation, rotateZAnimation, nil];
                group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                group.duration = 6;
                group.repeatCount = NSNotFound;
                
                [kkLayer addAnimation:group forKey:@"animationXandYRotate"];
                break;
            }
            //  使用CAKeyframeAnimation模仿微软的logo动画
            case  WZActivityIndicatorStyleMicrosoft: {
                CALayer *plane = [CALayer layer];
                plane.frame = CGRectInset(self.bounds, 2.0, 2.0);
                plane.backgroundColor = color.CGColor;
                plane.anchorPoint = CGPointMake(0.5, 0.5);
                plane.anchorPointZ = 0.5;
                [self.layer addSublayer:plane];
                
                CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
                anim.removedOnCompletion = NO;
                anim.repeatCount = HUGE_VALF;
                anim.duration = 1.2;
                anim.keyTimes = @[@(0.0), @(0.5), @(1.0)];
                
                anim.timingFunctions = @[
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                         ];
                 // 关键帧
                anim.values = @[
                                [NSValue valueWithCATransform3D:WZSpinKit3DRotationWithPerspective(1.0/120.0, 0, 0, 0, 0)],
                                [NSValue valueWithCATransform3D:WZSpinKit3DRotationWithPerspective(1.0/120.0, M_PI, 0.0, 1.0,0.0)],
                                [NSValue valueWithCATransform3D:WZSpinKit3DRotationWithPerspective(1.0/120.0, M_PI, 0.0, 0.0,1.0)]
                                ];
                
                [plane addAnimation:anim forKey:@"microsoftrotation"];
                break;
            }
            
            //  红绿灯，等等等等等～
            case WZActivityIndicatorStyleLights: {
                NSTimeInterval beginTime = CACurrentMediaTime();
                
                CALayer *redLight = [CALayer layer];
                redLight.frame = CGRectMake(0, 0, 40, 40);
                redLight.backgroundColor = [[UIColor redColor]CGColor];
                redLight.anchorPoint = CGPointMake(0.5, 0.5);
                redLight.opacity = 1.0;
                redLight.cornerRadius = CGRectGetHeight(redLight.bounds) * 0.5;
                
                CALayer *greenLight = [CALayer layer];
                greenLight.frame = CGRectMake(0, 80, 40, 40);
                greenLight.backgroundColor = [[UIColor greenColor]CGColor];
                greenLight.anchorPoint = CGPointMake(0.5,0.5);
                greenLight.opacity = 1.0;
                greenLight.cornerRadius = CGRectGetHeight(greenLight.bounds) * 0.5;
                
                CALayer *yellowLight = [CALayer layer];
                yellowLight.frame = CGRectMake(0, 40, 40, 40);
                yellowLight.backgroundColor = [[UIColor yellowColor]CGColor];
                yellowLight.anchorPoint = CGPointMake(0.5,0.5);
                yellowLight.opacity = 1.0;
                yellowLight.cornerRadius = CGRectGetHeight(yellowLight.bounds) * 0.5;
                
                CAKeyframeAnimation *redOpacityAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
                redOpacityAnim.values = @[@(0.0), @(1.0),@(0.0),@(0.0),@(0.0)];
                redOpacityAnim.removedOnCompletion = NO;
                redOpacityAnim.duration = 6.0;
                redOpacityAnim.repeatCount = HUGE_VALF;
                redOpacityAnim.beginTime = beginTime;
                redOpacityAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
                CAKeyframeAnimation *greenOpacityAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
                
                greenOpacityAnim.values = @[@(0.0), @(0.0),@(0.0),@(1.0),@(0.0)];
                greenOpacityAnim.removedOnCompletion = NO;
                greenOpacityAnim.duration = 6.0;
                greenOpacityAnim.repeatCount = HUGE_VALF;
                greenOpacityAnim.beginTime = beginTime;
                greenOpacityAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
                
                CAKeyframeAnimation *yellowOpacityAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
                yellowOpacityAnim.values = @[@(0.0), @(0.0),@(1.0),@(0.0),@(0.0)];
                yellowOpacityAnim.removedOnCompletion = NO;
                yellowOpacityAnim.duration = 6.0;
                yellowOpacityAnim.repeatCount = HUGE_VALF;
                yellowOpacityAnim.beginTime = beginTime;
                yellowOpacityAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
                
                [self.layer addSublayer:redLight];
                [self.layer addSublayer:greenLight];
                [self.layer addSublayer:yellowLight];
                [redLight addAnimation:redOpacityAnim forKey:@"blink"];
                [greenLight addAnimation:greenOpacityAnim forKey:@"blink"];
                [yellowLight addAnimation:yellowOpacityAnim forKey:@"blink"];
                break;
            }
            //  跳动的圆形
            case  WZActivityIndicatorStyleBounce: {
                NSTimeInterval beginTime = CACurrentMediaTime();
                
                for (NSInteger i=0; i < 2; i+=1) {
                    CALayer *circle = [CALayer layer];
                    circle.frame = CGRectInset(self.bounds, 2.0, 2.0);
                    circle.backgroundColor = color.CGColor;
                    circle.anchorPoint = CGPointMake(0.5, 0.5);
                    circle.opacity = 0.6;
                    circle.cornerRadius = CGRectGetHeight(circle.bounds) * 0.5;
                    circle.transform = CATransform3DMakeScale(0.0, 0.0, 0.0);
                    
                    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
                    anim.removedOnCompletion = NO;
                    anim.repeatCount = HUGE_VALF;
                    anim.duration = 2.0;
                    anim.beginTime = beginTime - (1.0 * i);
                    anim.keyTimes = @[@(0.0), @(0.5), @(1.0)];
                    
                    anim.timingFunctions = @[
                                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                             ];
                    
                    anim.values = @[
                                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 0.0)],
                                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 0.0)],
                                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 0.0)]
                                    ];
                    
                    [self.layer addSublayer:circle];
                    [circle addAnimation:anim forKey:@"bounce"];
                }
                    break;
            }
            //  波浪形的长条
            case WZActivityIndicatorStyleWave: {
                NSTimeInterval beginTime = CACurrentMediaTime() + 1.2;
                CGFloat barWidth = CGRectGetWidth(self.bounds) / 5.0;
                
                for (NSInteger i=0; i < 5; i+=1) {
                    CALayer *layer = [CALayer layer];
                    layer.backgroundColor = color.CGColor;
                    layer.frame = CGRectMake(barWidth * i, 0.0, barWidth - 3.0, CGRectGetHeight(self.bounds));
                    layer.transform = CATransform3DMakeScale(1.0, 0.3, 0.0);
                    
                    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
                    anim.removedOnCompletion = NO;
                    anim.beginTime = beginTime - (1.2 - (0.1 * i));
                    anim.duration = 1.2;
                    anim.repeatCount = HUGE_VALF;
                    
                    anim.keyTimes = @[@(0.0), @(0.2), @(0.4), @(1.0)];
                    
                    anim.timingFunctions = @[
                                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                             ];
                    
                    anim.values = @[
                                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 0.4, 0.0)],
                                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 0.0)],
                                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 0.4, 0.0)],
                                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 0.4, 0.0)]
                                    ];
                    
                    [self.layer addSublayer:layer];
                    [layer addAnimation:anim forKey:@"spinkit-anim"];
                }
                break;
            }
        }
    }
    return self;
}

-(void)applicationWillEnterForeground {
    if (self.stopped) {
        [self pauseLayers];
    } else {
        [self resumeLayers];
    }
}

-(void)applicationDidEnterBackground {
    [self pauseLayers];
}

-(void)startAnimating {
    self.hidden = NO;
    self.stopped = NO;
    [self resumeLayers];
}

-(void)stopAnimating {
    if (self.hidesWhenStopped) {
        self.hidden = YES;
    }
    
    self.stopped = YES;
    [self pauseLayers];
}

-(void)pauseLayers {
    CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0.0;
    self.layer.timeOffset = pausedTime;
}

-(void)resumeLayers {
    CFTimeInterval pausedTime = [self.layer timeOffset];
    self.layer.speed = 1.0;
    self.layer.timeOffset = 0.0;
    self.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.layer.beginTime = timeSincePause;
}

-(CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(37.0, 37.0);
}

-(void)setColor:(UIColor *)color {
    _color = color;
    
    for (CALayer *l in self.layer.sublayers) {
        l.backgroundColor = color.CGColor;
    }
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
