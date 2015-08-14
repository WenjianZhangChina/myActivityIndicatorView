//
//  ViewController.m
//  myActivityIndicatorView
//
//  Created by zwj on 15/8/7.
//  Copyright (c) 2015年 zwj. All rights reserved.
//

#import "ActivityIndicatorView.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)insertSpinner:(WZActivityIndicatorView*)spinner
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
    
    [self insertSpinner:[[WZActivityIndicatorView alloc] initWithStyle:WZActivityIndicatorStyleMicrosoft color:[UIColor whiteColor]]
                atIndex:3
        backgroundColor:[UIColor colorWithRed:0.827 green:0.329 blue:0 alpha:1.0]];
    
    [self insertSpinner:[[WZActivityIndicatorView alloc] initWithStyle:WZActivityIndicatorStyleBounce color:[UIColor whiteColor]]
                atIndex:5
        backgroundColor:[UIColor colorWithRed:0.173 green:0.243 blue:0.314 alpha:1.0]];
    
    [self insertSpinner:[[WZActivityIndicatorView alloc] initWithStyle:WZActivityIndicatorStyleWave color:[UIColor whiteColor]]
                atIndex:6
        backgroundColor:[UIColor colorWithRed:0.102 green:0.737 blue:0.612 alpha:1.0]];
    
    [self insertSpinner:[[WZActivityIndicatorView alloc] initWithStyle:WZActivityIndicatorStyleLights color:[UIColor whiteColor]]
                atIndex:4
        backgroundColor:[UIColor colorWithRed:0.903 green:0.9 blue:0.99 alpha:1.0]];
    
    [self insertSpinner:[[WZActivityIndicatorView alloc] initWithStyle:WZActivityIndicatorStyleRotateSquare color:[UIColor redColor]]
                atIndex:2
        backgroundColor:[UIColor colorWithRed:0.900 green:0.873 blue:0.522 alpha:1]];
    
    [self insertSpinner:[[WZActivityIndicatorView alloc] initWithStyle:WZActivityIndicatorStyleHeart color:[UIColor redColor]]
                atIndex:1
        backgroundColor:[UIColor whiteColor]];
    
    [self insertSpinner:[[WZActivityIndicatorView alloc] initWithStyle:WZActivityIndicatorStyleRevolution color:[UIColor redColor]]
                atIndex:0 backgroundColor:[UIColor whiteColor]];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    scrollView.contentSize = CGSizeMake(7 * CGRectGetWidth(screenBounds), CGRectGetHeight(screenBounds));
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
