//
//  pushView.m
//  animationOne
//
//  Created by 战明 on 16/5/15.
//  Copyright © 2016年 zhanming. All rights reserved.
//

#import "pushView.h"
#import "pushButton.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
typedef NS_ENUM(NSInteger, ZMButtonType) {
    ZMButtonTypeCamera = 0,
    ZMButtonTypePicture,
    ZMButtonTypeResell
    
    
};
@interface pushView()

@property(assign,nonatomic)BOOL isAnimation;
@property(strong,nonatomic)UIVisualEffectView *myblurEffect;
@property(strong,nonatomic)UIWindow *keyWindow;
@property(strong,nonatomic)NSMutableArray<pushButton*> *btnArray;
@property(strong,nonatomic)NSMutableArray *btnRectArray;
@property(strong,nonatomic)NSMutableArray *fromRectArray;
@property(strong,nonatomic)UIButton *addBtn;

@end

@implementation pushView


-(NSMutableArray *)fromRectArray
{
    if(_fromRectArray == nil)
    {
        _fromRectArray=[NSMutableArray new];
        
    }
    return _fromRectArray;
}

-(NSMutableArray<pushButton *> *)btnArray
{
    if(_btnArray == nil)
    {
        _btnArray=[NSMutableArray new];
        
    }
    return _btnArray;
}

-(NSMutableArray *)btnRectArray
{
    if(_btnRectArray == nil)
    {
        _btnRectArray=[NSMutableArray new];
        
    }
    return _btnRectArray;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.frame=CGRectMake(0, 0, ScreenWidth,ScreenHeight);
        
        self.isAnimation=NO;
        
        
        self.backgroundColor=[UIColor clearColor];
        
        self.myblurEffect = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        self.myblurEffect.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.myblurEffect.alpha = 0.9f;
        
        [self addSubview:self.myblurEffect];
        
        //添加加号按钮
        UIButton *addbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [addbtn setBackgroundImage:[UIImage imageNamed:@"post_animate_add"] forState:UIControlStateNormal];
        
        addbtn.frame=CGRectMake(0, 0, 60, 60);
        
        addbtn.center=CGPointMake(ScreenWidth/2, ScreenHeight-44);
        
        [addbtn addTarget:self action:@selector(closePushView) forControlEvents:UIControlEventTouchUpInside];
        
        self.addBtn=addbtn;
        [self addButton];
        [self addSubview:addbtn];
        
        
        
    }
    return self;
}

//创建按钮
-(void)addButton
{
    NSUInteger buttonCount=3;
    
    for (NSUInteger i=0; i<buttonCount; i++) {
        
        
        pushButton *btn=[pushButton buttonWithType:UIButtonTypeCustom];
        
        [btn addTarget:self action:@selector(blick:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.tag=i;
        
        //使按钮的frame和加号按钮的frame一样
        btn.frame=CGRectMake(0, 0, self.addBtn.frame.size.width, self.addBtn.frame.size.width);
        btn.center=self.addBtn.center;
        
        
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"post_animate_%lu",(unsigned long)(i+1)]] forState:UIControlStateNormal];
        
        //把按钮放到数组里，以便时候使用
        [self.btnArray addObject:btn];
        
        [self addSubview:btn];
        
        
    }
}

-(void)blick:(UIButton *)btn
{
    switch (btn.tag) {
        case ZMButtonTypeCamera:
            NSLog(@"相机");
            break;
            
        case ZMButtonTypePicture:
            NSLog(@"图片");
            break;
        case ZMButtonTypeResell:
            NSLog(@"一键转卖");
            break;
        default:
            break;
    }
}

//按钮出现
-(void)pushButton
{
    
    if(!self.isAnimation)
    {
        self.isAnimation=YES;
        CGFloat margin =40;
        CGFloat width=(ScreenWidth-margin*4)/3.0;
        
        //这个是让加号旋转45度，没有难度吧
        [UIView animateWithDuration:0.3 animations:^{
            
            self.addBtn.transform=CGAffineTransformMakeRotation(-M_PI_4);
        }];
        
        
        for (NSInteger i = 0; i < self.btnArray.count; i++) {
            
            //按钮要到的位置的frame
            CGRect toValue =CGRectMake(margin*(i+1)+width*i+width/2, ScreenHeight*0.7+width/2, width, width);
            
            [self.fromRectArray addObject:[NSValue valueWithCGRect:toValue]];
            
            pushButton *menuButton = self.btnArray[i];
            
            
            
            //从小到大
            CABasicAnimation *animationScale=[CABasicAnimation animation];
            animationScale.keyPath=@"transform.scale";
            animationScale.toValue=@(1.3);
            //透明度不断增大
            CABasicAnimation *animationoPacity=[CABasicAnimation animation];
            animationoPacity.keyPath=@"opacity";
            animationoPacity.fromValue=@(0);
            animationoPacity.toValue=@(1);
            //按钮有旋转
            CABasicAnimation *animationRotation=[CABasicAnimation animation];
            animationRotation.keyPath=@"transform.rotation.z";
            
            //根据按钮的出现顺序旋转的角度也不同
            animationRotation.fromValue=@(DEGREES_TO_RADIANS(90/(self.btnArray.count-i)));
            animationRotation.toValue=@(0);
            //有弹性效果
            
            /*
             * mass:
             质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大
             * stiffness:
             刚度系数(劲度系数/弹性系数)，刚度系数越大，形变产生的力就越大，运动越快
             
             * damping:
             阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快
             
             * initialVelocity:
             初始速率，动画视图的初始速度大小
             速率为正数时，速度方向与运动方向一致，速率为负数时，速度方向与运动方向相反
             */
            
            
            CASpringAnimation *animationSpring=[CASpringAnimation animationWithKeyPath:@"position"];
            animationSpring.damping =8;
            animationSpring.stiffness = 120;
            animationSpring.mass = 0.6;
            animationSpring.initialVelocity = 0;
            animationSpring.toValue =[NSValue valueWithCGPoint:toValue.origin];
            
            
            CAAnimationGroup *animationGroup=[CAAnimationGroup animation];
            
            animationGroup.animations=@[animationoPacity,animationScale,animationRotation,animationSpring];
            animationGroup.duration=0.5;
            //让动画延迟执行
            animationGroup.beginTime=CACurrentMediaTime()+i*(0.4/self.btnArray.count);
            
            animationGroup.removedOnCompletion=NO;
            
            animationGroup.fillMode=kCAFillModeForwards;
            animationGroup.delegate=self;
            
            [menuButton.layer addAnimation:animationGroup forKey:[NSString stringWithFormat:@"animation%ld",(long)i]];
            

            
        }
    }
    
    else
    {
        [self closePushView];
    }
    
}

-(void)closePushView
{
    
    if(self.isAnimation)
    {
        self.isAnimation=NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.addBtn.transform=CGAffineTransformIdentity;
        }];
        
        for (NSInteger i = self.btnArray.count-1; i >=0; i--) {
            
            pushButton *menuButton = self.btnArray[i];
            
            CABasicAnimation *animationoPacity=[CABasicAnimation animation];
            animationoPacity.keyPath=@"opacity";
            animationoPacity.toValue=@(1);
            animationoPacity.toValue=@(0.5);
            
            CABasicAnimation *animationScale=[CABasicAnimation animation];
            
            animationScale.keyPath=@"transform.scale";
            animationScale.toValue=@(0.7);
            
            
            CABasicAnimation *animationRotation=[CABasicAnimation animation];
            
            animationRotation.keyPath=@"transform.rotation.z";
            
            //animationRotation.fromValue=@(0);
            animationRotation.toValue=@(DEGREES_TO_RADIANS(90/(self.btnArray.count-i)));
            
            CABasicAnimation *animationPosition=[CABasicAnimation animationWithKeyPath:@"position"];
            
            animationPosition.toValue =[NSValue valueWithCGPoint:self.addBtn.center];
            CAAnimationGroup *animationGroup=[CAAnimationGroup animation];
            
            animationGroup.animations=@[animationPosition,animationScale,animationoPacity];
            
            animationGroup.duration=0.23;
            
            animationGroup.beginTime=CACurrentMediaTime()+(self.btnArray.count-1-i)*(0.4/self.btnArray.count);
            
            animationGroup.removedOnCompletion=NO;
            
            animationGroup.fillMode=kCAFillModeForwards;
            if(i==0)
            {
                animationGroup.delegate=self;
            }
            
            
            [menuButton.layer addAnimation:animationGroup forKey:[NSString stringWithFormat:@"animationaClose%ld",(long)i]];
            
        }
    }
    else
    {
        [self pushButton];
    }
    
    
    
}


-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //临时方法，以后会修改
    
    pushButton *menuButton1 = self.btnArray[1];
    if([anim isEqual:[menuButton1.layer animationForKey:@"animation1"]])
    {
        
        menuButton1.center=[self.fromRectArray[1] CGRectValue].origin;
    }
    pushButton *menuButton0 = self.btnArray[0];
    if([anim isEqual:[menuButton0.layer animationForKey:@"animation0"]])
    {
        
        menuButton0.center=[self.fromRectArray[0] CGRectValue].origin;
    }
    
    
    pushButton *menuButton2 = self.btnArray[2];
    if([anim isEqual:[menuButton2.layer animationForKey:@"animation2"]])
    {
        menuButton2.center=[self.fromRectArray[2] CGRectValue].origin;
    }
    
    if([anim isEqual:[menuButton0.layer animationForKey:@"animationaClose0"]])
    {
        
        [self removeFromSuperview];
    }
    
    
    
    
}




@end
