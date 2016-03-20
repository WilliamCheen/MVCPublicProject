//
//  SecondViewController.m
//  WilliamProject
//
//  Created by WilliamChen on 16/3/1.
//  Copyright © 2016年 WilliamChen. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)loadView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 80, [UIScreen mainScreen].bounds.size.width, 300)];
    view.backgroundColor = [UIColor orangeColor];
    self.view = view;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"SecondViewDidAppear");
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
