//
//  CustomTransitionAController.m
//  WilliamProject
//
//  Created by WilliamChen on 16/2/16.
//  Copyright © 2016年 WilliamChen. All rights reserved.
//

#import "CustomTransitionAController.h"
#import "CustomTransitionBController.h"
#import "CustomAnimationTransition.h"

@interface CustomTransitionAController ()<UIViewControllerTransitioningDelegate>

@end

@implementation CustomTransitionAController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.size = CGSizeMake(150, 40);
    button.backgroundColor = [UIColor orangeColor];
    button.center = self.view.center;
    button.centerY += 150;
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc] init];
    label.size = CGSizeMake(100, 100);
    label.center = self.view.center;
    label.text = @"A";
    label.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:label];
}

- (void)buttonAction
{
    CustomTransitionBController *bController = [[CustomTransitionBController alloc]init];
    bController.modalPresentationStyle = UIModalPresentationFullScreen;
    bController.transitioningDelegate = self;
    [self presentViewController:bController animated:YES completion:NULL];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [CustomAnimationTransition new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [CustomAnimationTransition new];
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
