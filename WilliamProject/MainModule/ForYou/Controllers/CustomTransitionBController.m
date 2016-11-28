//
//  CustomTransitionBController.m
//  WilliamProject
//
//  Created by WilliamChen on 16/2/16.
//  Copyright © 2016年 WilliamChen. All rights reserved.
//

#import "CustomTransitionBController.h"

@interface CustomTransitionBController ()

@end

@implementation CustomTransitionBController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    UILabel *label = [[UILabel alloc] init];
//    label.size = CGSizeMake(100, 100);
    label.center = self.view.center;
    label.text = @"B";
    label.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:label];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
}

- (void)tapAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
