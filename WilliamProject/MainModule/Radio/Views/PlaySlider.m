//
//  PlaySlider.m
//  WilliamProject
//
//  Created by WilliamChen on 15/11/18.
//  Copyright © 2015年 WilliamChen. All rights reserved.
//

#import "PlaySlider.h"

@implementation PlaySlider

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value{
    CGRect originRect = bounds;
    originRect.origin.y = (bounds.size.height - rect.size.height)/2.0 ;
    return originRect;
}

@end
