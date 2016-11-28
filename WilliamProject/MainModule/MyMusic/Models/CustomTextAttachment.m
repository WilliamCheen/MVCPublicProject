//
//  CustomTextAttachment.m
//  WilliamProject
//
//  Created by WilliamChen on 16/8/27.
//  Copyright © 2016年 WilliamChen. All rights reserved.
//

#import "CustomTextAttachment.h"

@implementation CustomTextAttachment

- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex
{
    CGSize imgSize = self.image.size;
    if (!CGSizeEqualToSize(imgSize, CGSizeZero)) {
        CGFloat height = (imgSize.height / imgSize.width) * (textContainer.size.width - 10);
        return CGRectMake(0, 0, SCREEN_WIDTH, height);
    }
    return CGRectZero;
}

@end
