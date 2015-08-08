//
//  ViewController.m
//  myActivityIndicatorView
//
//  Created by zwj on 15/8/7.
//  Copyright (c) 2015年 zwj. All rights reserved.
//

#import "ViewController.h"
//#import "WZActivityIndicatorRotateSqureViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor =  [UIColor colorWithRed: (237 / 255.0) green:(81/255.0) blue:(101/255.0) alpha:1.0];
    
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
    NSInteger cols = 4;
    NSInteger rows = 7;
    NSInteger cellWidth = self.view.frame.size.width / cols;
    NSInteger cellHeight = self.view.frame.size.height / rows;
    
    [self moveLayerRotate];
    
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
    CABasicAnimation *rotateAnimation  = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:6.0 * M_PI];
    rotateAnimation.duration = 4;
    rotateAnimation.repeatCount = NSNotFound;
    
    [kkLayer addAnimation:rotateAnimation forKey:@"animationRotate"];
    
}

@end
