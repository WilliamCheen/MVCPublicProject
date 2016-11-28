//
//  BaseMasonryView.m
//  WilliamProject
//
//  Created by WilliamChen on 16/5/30.
//  Copyright © 2016年 WilliamChen. All rights reserved.
//

#import "BaseMasonryView.h"
#import "View+MASShorthandAdditions.h"

@implementation BaseMasonryView

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIView *redView = [[UIView alloc]init];
        redView.backgroundColor = [UIColor redColor];
        [self addSubview:redView];
        
        UIView *orangeView = [[UIView alloc]init];
        orangeView.backgroundColor = [UIColor orangeColor];
        [self addSubview:orangeView];
        
        UIView *blueView = [[UIView alloc]init];
        blueView.backgroundColor = [UIColor blueColor];
        [self addSubview:blueView];
        
        CGFloat padding = 10;
        UIView *superView = self;
        [redView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.mas_left).offset(padding);
            make.top.equalTo(superView.mas_top).offset(padding);
            make.right.equalTo(superView.mas_right).offset(-padding);
            make.height.equalTo(redView.mas_width);
        }];
        
        [orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.mas_left).offset(padding);
            make.top.equalTo(redView.mas_bottom).offset(padding);
            make.right.equalTo(blueView.mas_left).offset(-padding);
            make.bottom.equalTo(superView.mas_bottom).offset(-padding);
        }];
        
        [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(superView.mas_right).offset(-padding);
            make.top.equalTo(redView.mas_bottom).offset(padding);
            make.bottom.equalTo(superView.mas_bottom).offset(-padding);
            make.width.equalTo(orangeView.mas_width);
        }];
    }
    return self;
}

@end
