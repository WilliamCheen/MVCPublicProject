//
//  TestViewController.m
//  WilliamProject
//
//  Created by WilliamChen on 15/11/27.
//  Copyright © 2015年 WilliamChen. All rights reserved.
//

#import "TestViewController.h"

#import "CustomSheetView.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"测试";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(backItemClick)];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)backItemClick{
//    [self.navigationController popViewControllerAnimated:YES];
    
//    CustomSheetView *sheetView = [[CustomSheetView alloc]init];
//    [self.view addSubview:sheetView];
//    [self.view addConstraints:[sheetView constraintsFill]];
//    [sheetView show];
    
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
