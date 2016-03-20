//
//  RadioViewController.m
//  WilliamProject
//
//  Created by WilliamChen on 15/11/10.
//  Copyright © 2015年 WilliamChen. All rights reserved.
//

#import "RadioViewController.h"
#import "TestViewController.h"
#import "PlaySlider.h"

@interface RadioViewController ()
@property (nonatomic, strong) UIView *testView;
@end

@implementation RadioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(20, 100, self.view.width - 40, 20)];
    [slider setThumbImage:[UIImage imageNamed:@"slider_thumb"] forState:UIControlStateNormal];
    [self.view addSubview:slider];
    
    _testView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    _testView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_testView];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 10, 30, 30);
    button.backgroundColor = [UIColor orangeColor];
    [button addTarget:self
               action:@selector(buttonClick:)
     forControlEvents:UIControlEventTouchUpInside];
    [_testView addSubview:button];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}


- (void)buttonClick:(UIButton *)button{
//    TestViewController *testVC = [[TestViewController alloc]init];
//    testVC.view.backgroundColor = [UIColor orangeColor];
//    [self.navigationController pushViewController:testVC animated:NO];
    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    
//    UIWindow *window =[[[UIApplication sharedApplication] delegate] window];
//    CGRect rect = [_testView convertRect:button.frame toView:window];
//    
//    UIView *view = [[UIView alloc]initWithFrame:rect];
//    view.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view];
    
    UIStoryboard *st = [UIStoryboard storyboardWithName:@"SizeClass" bundle:[NSBundle mainBundle]];
    UIViewController *vc = [st instantiateViewControllerWithIdentifier:@"SizeClassViewController"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
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
