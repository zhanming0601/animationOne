//
//  ViewController.m
//  animationOne
//
//  Created by 战明 on 16/5/15.
//  Copyright © 2016年 zhanming. All rights reserved.
//

#import "ViewController.h"
#import "pushView.h"

@interface ViewController ()
@property(strong,nonatomic)pushView *myPushView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"homeBack"]];
    imageview.frame=self.view.bounds;
    
    [self.view addSubview:imageview];
    
    
    pushView *myview=[pushView new];
    
    self.myPushView=myview;
    
   
    
    
    UIButton *addbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [addbtn setImage:[UIImage imageNamed:@"post_animate_add"] forState:UIControlStateNormal];
    [addbtn sizeToFit];
    
    [self.view addSubview:addbtn];
    
    addbtn.center=CGPointMake(ScreenWidth/2, ScreenHeight-44);
    
    [addbtn addTarget:self action:@selector(pushClick) forControlEvents:UIControlEventTouchUpInside];
    //[myview pushButton];
    
    
}

//出现动画
-(void)pushClick
{
    
    [self.view addSubview:self.myPushView];
    [self.myPushView pushButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
