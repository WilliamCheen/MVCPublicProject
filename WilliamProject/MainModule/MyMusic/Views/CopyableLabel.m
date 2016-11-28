//
//  CopyableLabel.m
//  WilliamProject
//
//  Created by WilliamChen on 16/6/13.
//  Copyright © 2016年 WilliamChen. All rights reserved.
//

#import "CopyableLabel.h"

@implementation CopyableLabel

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return action == @selector(copy:);
}

- (void)copy:(id)sender
{
    if (self.text.length) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.text;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
