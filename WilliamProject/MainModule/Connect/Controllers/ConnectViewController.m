//
//  ConnectViewController.m
//  WilliamProject
//
//  Created by WilliamChen on 15/11/10.
//  Copyright © 2015年 WilliamChen. All rights reserved.
//

#import "ConnectViewController.h"
#import "PSTAlertController.h"
#import "HeaderViewController.h"
#import "ANewViewController.h"

@interface ConnectViewController ()
@property (nonatomic, strong) UIView *animateView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UINavigationController *navigation;
@end

@implementation ConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    _animateView = [[UIView alloc]init];
    _animateView.center = self.view.center;
    _animateView.bounds = CGRectMake(0, 0, 100, 100);
    _animateView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_animateView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 70, 100, 40);
    [button setBackgroundColor:[UIColor orangeColor]];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.textLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 150, 80, 20)];
    self.textLabel.font = [UIFont systemFontOfSize:13];
    self.textLabel.text = @"下载中...";
    [self.view addSubview:self.textLabel];
}

- (void)buttonClick:(UIButton *)button{
//    [UIView animateWithDuration:1 animations:^{
//        _animateView.bounds = CGRectMake(0, 0, 150, 150);
//    }];
    
    /*
    PSTAlertController *controller = [PSTAlertController alertControllerWithTitle:@"密码提示" message:@"多的是你不知道的事" preferredStyle:PSTAlertControllerStyleActionSheet];
    PSTAlertAction *action1 = [PSTAlertAction actionWithTitle:@"确定" handler:^(PSTAlertAction * _Nonnull action) {
        NSLog(@"DongZhi");
    }];
    PSTAlertAction *action2 = [PSTAlertAction actionWithTitle:@"取消" style:PSTAlertActionStyleCancel handler:nil];
    [controller addAction:action1];
    [controller addAction:action2];
    [controller showWithSender:nil controller:self animated:YES completion:nil];*/
    
//    ANewViewController *headVC = [[ANewViewController alloc]init];
//    headVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:headVC animated:YES];
    
//    if (button.selected) {
//        self.textLabel.textColor = [UIColor orangeColor];
//    }else{
//        self.textLabel.textColor = [UIColor whiteColor];
//    }
//    
//    button.selected = !button.selected;
    
    
    
    
    UIViewController *viewController = [[UIViewController alloc]init];
    viewController.view.backgroundColor = [UIColor orangeColor];
    viewController.edgesForExtendedLayout = UIRectEdgeNone;
    _navigation = [[UINavigationController alloc]initWithRootViewController:viewController];
//    _navigation.navigationBarHidden = YES;
    [self presentViewController:_navigation animated:YES completion:^{
        UIButton *buttonDis = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonDis.backgroundColor = [UIColor redColor];
        buttonDis.center = CGPointMake(200, 200);
        [buttonDis addTarget:self action:@selector(dimissAction:) forControlEvents:UIControlEventTouchUpInside];
        [viewController.view addSubview:buttonDis];
    }];
}

- (void)dimissAction:(UIButton *)item
{
    [_navigation dismissViewControllerAnimated:YES completion:nil];
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
