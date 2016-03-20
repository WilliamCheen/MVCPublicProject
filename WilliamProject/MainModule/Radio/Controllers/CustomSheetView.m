//
//  CustomSheetView.m
//  WilliamProject
//
//  Created by WilliamChen on 15/11/27.
//  Copyright © 2015年 WilliamChen. All rights reserved.
//

#import "CustomSheetView.h"

@interface CustomSheetView ()
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) NSLayoutConstraint *bottomCons;
@end

@implementation CustomSheetView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        // Add Subviews
        
        [self configureSubviews];
    }
    return self;
}

- (void)configureSubviews
{
    [self addSubview:self.titleView];
    
    [self addConstraints:[self.titleView constraintsLeftInContainer:0]];
    [self addConstraints:[self.titleView constraintsRightInContainer:0]];
    self.bottomCons = [self.titleView constraintBottomEqualToView:self];
    self.bottomCons.constant = 200;
    [self addConstraint:self.bottomCons];
    [self addConstraint:[self.titleView constraintHeight:200]];
}

- (void)show
{
    self.bottomCons.constant = 0;

    [UIView animateWithDuration:2 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self layoutIfNeeded];
    } completion:nil];
}

- (UIView *)titleView
{
    if (_titleView == nil) {
        _titleView = [[UIView alloc]init];
        _titleView.backgroundColor = [UIColor orangeColor];
        _titleView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _titleView;
}

@end
