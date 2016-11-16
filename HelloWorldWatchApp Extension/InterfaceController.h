//
//  InterfaceController.h
//  HelloWorldWatchApp Extension
//
//  Created by WilliamChen on 16/5/5.
//  Copyright © 2016年 WilliamChen. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface InterfaceController : WKInterfaceController
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTable *myTable;

@end
