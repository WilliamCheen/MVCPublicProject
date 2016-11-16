//
//  MyTableRowController.h
//  WilliamProject
//
//  Created by WilliamChen on 16/5/5.
//  Copyright © 2016年 WilliamChen. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface MyTableRowController : NSObject
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceImage *headImageView;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *titleLabel;

@end
