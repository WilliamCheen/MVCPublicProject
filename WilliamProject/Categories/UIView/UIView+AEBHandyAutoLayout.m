//
//  UIView+HandyAutoLayout.m
//  ZhanYe
//
//  Created by casa on 14-8-25.
//  Copyright (c) 2014年 me.andpay. All rights reserved.
//

#import "UIView+AEBHandyAutoLayout.h"

@implementation UIView (AEBHandyAutoLayout)

- (NSLayoutConstraint *)constraintHeight:(CGFloat)height
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1.0f constant:height];
}

- (NSLayoutConstraint *)constraintWidth:(CGFloat)width
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1.0f constant:width];
}

- (NSLayoutConstraint *)constraintCenterXEqualToView:(UIView *)view
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f];
}

- (NSLayoutConstraint *)constraintCenterYEqualToView:(UIView *)view
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f];
}

- (NSLayoutConstraint *)constraintHeightEqualToView:(UIView *)view
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0.0f];
}

- (NSLayoutConstraint *)constraintWidthEqualToView:(UIView *)view
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f];
}

- (NSArray *)constraintsTop:(CGFloat)top FromView:(UIView *)view
{
    UIView *selfView = self;
    return [NSLayoutConstraint constraintsWithVisualFormat:@"V:[view]-(top)-[selfView]" options:0 metrics:@{@"top":@(top)} views:NSDictionaryOfVariableBindings(view, selfView)];
}

- (NSArray *)constraintsBottom:(CGFloat)bottom FromView:(UIView *)view
{
    UIView *selfView = self;
    return [NSLayoutConstraint constraintsWithVisualFormat:@"V:[selfView]-(bottom)-[view]" options:0 metrics:@{@"bottom":@(bottom)} views:NSDictionaryOfVariableBindings(selfView, view)];
}

- (NSArray *)constraintsLeft:(CGFloat)left FromView:(UIView *)view
{
    UIView *selfView = self;
    return [NSLayoutConstraint constraintsWithVisualFormat:@"H:[selfView]-(left)-[view]" options:0 metrics:@{@"left":@(left)} views:NSDictionaryOfVariableBindings(selfView, view)];
}

- (NSArray *)constraintsRight:(CGFloat)right FromView:(UIView *)view
{
    UIView *selfView = self;
    return [NSLayoutConstraint constraintsWithVisualFormat:@"H:[view]-(right)-[selfView]" options:0 metrics:@{@"right":@(right)} views:NSDictionaryOfVariableBindings(view, selfView)];
}

- (NSArray *)constraintsSizeEqualToView:(UIView *)view
{
    return @[
        [self constraintHeightEqualToView:view],
        [self constraintWidthEqualToView:view]
    ];
}

- (NSArray *)constraintsSize:(CGSize)size
{
    return @[
        [self constraintHeight:size.height],
        [self constraintWidth:size.width]
    ];
}

- (NSArray *)constraintsFillWidth
{
    UIView *selfView = self;
    return [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[selfView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(selfView)];
}

- (NSArray *)constraintsFillHeight
{
    UIView *selfView = self;
    return [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[selfView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(selfView)];
}

- (NSArray *)constraintsFill
{
    NSMutableArray *resultConstraints = [[NSMutableArray alloc] initWithArray:[self constraintsFillWidth]];
    [resultConstraints addObjectsFromArray:[self constraintsFillHeight]];
    return [NSArray arrayWithArray:resultConstraints];
}

- (NSArray *)constraintsAssignLeft
{
    return [self constraintsLeftInContainer:0];
}

- (NSArray *)constraintsAssignRight
{
    return [self constraintsRightInContainer:0];
}

- (NSArray *)constraintsAssignTop
{
    return [self constraintsTopInContainer:0];
}

- (NSArray *)constraintsAssignBottom
{
    return [self constraintsBottomInContainer:0];
}

- (NSArray *)constraintsTopInContainer:(CGFloat)top
{
    UIView *selfView = self;
    return [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(top)-[selfView]" options:0 metrics:@{@"top":@(top)} views:NSDictionaryOfVariableBindings(selfView)];
}

- (NSArray *)constraintsBottomInContainer:(CGFloat)bottom
{
    UIView *selfView = self;
    return [NSLayoutConstraint constraintsWithVisualFormat:@"V:[selfView]-(bottom)-|" options:0 metrics:@{@"bottom":@(bottom)} views:NSDictionaryOfVariableBindings(selfView)];
}

- (NSArray *)constraintsLeftInContainer:(CGFloat)left
{
    UIView *selfView = self;
    return [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(left)-[selfView]" options:0 metrics:@{@"left":@(left)} views:NSDictionaryOfVariableBindings(selfView)];
}

- (NSArray *)constraintsRightInContainer:(CGFloat)right
{
    UIView *selfView = self;
    return [NSLayoutConstraint constraintsWithVisualFormat:@"H:[selfView]-(right)-|" options:0 metrics:@{@"right":@(right)} views:NSDictionaryOfVariableBindings(selfView)];
}

- (NSLayoutConstraint *)constraintTopEqualToView:(UIView *)view
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
}

- (NSLayoutConstraint *)constraintBottomEqualToView:(UIView *)view
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f];
}
- (NSLayoutConstraint *)constraintLeftEqualToView:(UIView *)view
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0f];
}
- (NSLayoutConstraint *)constraintRightEqualToView:(UIView *)view
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1.0f constant:0.0f];
}
@end

@implementation UIImage (ResizeImage)

- (UIImage *)resizeImageWithSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end