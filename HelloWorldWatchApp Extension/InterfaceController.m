//
//  InterfaceController.m
//  HelloWorldWatchApp Extension
//
//  Created by WilliamChen on 16/5/5.
//  Copyright © 2016年 WilliamChen. All rights reserved.
//

#import "InterfaceController.h"
#import "MyTableRowController.h"

@interface InterfaceController()
@property (nonatomic, strong) NSArray *dataSource;
@end


@implementation InterfaceController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataSource = @[@"loveImageBlue", @"loveImageRed", @"loveImageYellow",@"loveImageBlue", @"loveImageRed", @"loveImageYellow"];
        
        [self loadTableData];
    }
    return self;
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)loadTableData
{
    [self.myTable setNumberOfRows:self.dataSource.count withRowType:@"MyTableRowController"];
    [self.dataSource enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MyTableRowController *row = [self.myTable rowControllerAtIndex:idx];
        row.headImageView.image = [UIImage imageNamed:obj];
        row.titleLabel.text = obj;
    }];
    
}

@end



