//
//  ViewController.m
//  myActivityIndicatorView
//
//  Created by zwj on 15/8/7.
//  Copyright (c) 2015年 zwj. All rights reserved.
//

#import "ActivityIndicatorView.h"
#import "ViewController.h"
#import "Defines.h"
#import "BulbLayer.h"
#import "BulbView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    //self.view.backgroundColor =  [UIColor colorWithRed: (237 / 255.0) green:(81/255.0) blue:(101/255.0) alpha:1.0];
    
    /*
     let cols = 4
     let rows = 7
     let cellWidth = Int(self.view.frame.width / CGFloat(cols))
     let cellHeight = Int(self.view.frame.height / CGFloat(rows))
     
     for var i = 0; i < activityTypes.count; i++ {
     let x = i % cols * cellWidth
     let y = i / cols * cellHeight
     let frame = CGRect(x: x, y: y, width: cellWidth, height: cellHeight)
     let activityIndicatorView = NVActivityIndicatorView(frame: frame,
     type: activityTypes[i])
     
     self.view.addSubview(activityIndicatorView)
     activityIndicatorView.startAnimation()
     */
    /*
    NSInteger cols = 4;
    NSInteger rows = 7;
    NSInteger cellWidth = self.view.frame.size.width / cols;
    NSInteger cellHeight = self.view.frame.size.height / rows;
    
    for (int i = 0; i <2; i++) {
        int x = i % cols *cellWidth;
        int y = i / cols *cellHeight;
        CGRect frame = CGRectMake(x, y, cellWidth, cellHeight);
        
    }
    
    [self moveLayerRotate];
    [self moveLayerYRotate];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)moveLayerRotate
{
    
    CALayer *kkLayer = [[CALayer alloc]init];
    kkLayer.backgroundColor = [[UIColor grayColor]CGColor];
    kkLayer.frame = CGRectMake(50, 217, 40, 40);
    kkLayer.cornerRadius = 5;
    [self.view.layer addSublayer:kkLayer];
    
    // 以x轴进行旋转
    CABasicAnimation *rotateAnimation  = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:6.0 * M_PI];
    rotateAnimation.duration = 4;
    rotateAnimation.repeatCount = NSNotFound;
    
    [kkLayer addAnimation:rotateAnimation forKey:@"animationRotate"];
    
}

-(void)insertSpinner:(WZSpinKitView*)spinner
             atIndex:(NSInteger)index
     backgroundColor:(UIColor*)backgroundColor
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = CGRectGetWidth(screenBounds);
    
    UIView *panel = [[UIView alloc] initWithFrame:CGRectOffset(screenBounds, screenWidth * index, 0.0)];
    panel.backgroundColor = backgroundColor;
    
    spinner.center = CGPointMake(CGRectGetMidX(screenBounds), CGRectGetMidY(screenBounds));
    [panel addSubview:spinner];
    
    UIScrollView *scrollView = (UIScrollView*)self.view;
    [scrollView addSubview:panel];
}

-(void)loadView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.pagingEnabled = YES;
    scrollView.alwaysBounceVertical = NO;
    scrollView.alwaysBounceHorizontal = YES;
    scrollView.backgroundColor = [UIColor darkGrayColor];
    self.view = scrollView;
    
    [self insertSpinner:[[WZSpinKitView alloc] initWithStyle:WZSpinKitViewStylePlane color:[UIColor whiteColor]]
                atIndex:0
        backgroundColor:[UIColor colorWithRed:0.827 green:0.329 blue:0 alpha:1.0]];
    
    [self insertSpinner:[[WZSpinKitView alloc] initWithStyle:WZSpinKitViewStyleBounce color:[UIColor whiteColor]]
                atIndex:1
        backgroundColor:[UIColor colorWithRed:0.173 green:0.243 blue:0.314 alpha:1.0]];
    
    [self insertSpinner:[[WZSpinKitView alloc] initWithStyle:WZSpinKitViewStyleWave color:[UIColor whiteColor]]
                atIndex:2
        backgroundColor:[UIColor colorWithRed:0.102 green:0.737 blue:0.612 alpha:1.0]];
    
    [self insertSpinner:[[WZSpinKitView alloc] initWithStyle:WZSpinKitViewStyleWanderingCubes color:[UIColor whiteColor]]
                atIndex:3
        backgroundColor:[UIColor colorWithRed:0.161 green:0.502 blue:0.725 alpha:1.0]];
    
    [self insertSpinner:[[WZSpinKitView alloc] initWithStyle:WZSpinKitViewStylePulse color:[UIColor whiteColor]]
                atIndex:4
        backgroundColor:[UIColor colorWithRed:0.498 green:0.549 blue:0.553 alpha:1.0]];
    
    [self insertSpinner:[[WZSpinKitView alloc] initWithStyle:WZActivityIndicatorStyleRotateSquare color:[UIColor redColor]] atIndex:5 backgroundColor:[UIColor whiteColor]];
    
    [self insertSpinner:[[WZSpinKitView alloc] initWithStyle:WZActivityIndicatorStyleBulb color:[UIColor redColor]] atIndex:6 backgroundColor:[UIColor whiteColor]];
    
   

    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    scrollView.contentSize = CGSizeMake(7 * CGRectGetWidth(screenBounds), CGRectGetHeight(screenBounds));
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
