//
//  pushButton.m
//  animationOne
//
//  Created by 战明 on 16/5/15.
//  Copyright © 2016年 zhanming. All rights reserved.
//

#import "pushButton.h"

@implementation pushButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    self.imageView.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
    self.imageView.center=CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    self.titleLabel.frame=CGRectMake(CGRectGetMidX(self.imageView.frame), CGRectGetMaxY(self.imageView.frame), self.frame.size.width, 20);
}

@end
