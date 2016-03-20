//
//  TestView.m
//  WilliamProject
//
//  Created by WilliamChen on 15/11/20.
//  Copyright © 2015年 WilliamChen. All rights reserved.
//

#import "TestView.h"

@implementation TestView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    NSLog(@"HitPoint:%@",NSStringFromCGPoint(point));
    
    if (self.outSideView != nil) {
        CGRect rect = self.outSideView.frame;
        if (CGRectContainsPoint(rect, point)) {
            NSLog(@"Contain Handle");
            
            if ([self.outSideView isKindOfClass:[UIButton class]]) {
                UIButton *subBtn = (UIButton *)self.outSideView;
                return subBtn;
            }
        }
    }
    
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"CurrentPoint:%@",NSStringFromCGPoint(point));
    return YES;
}

@end
