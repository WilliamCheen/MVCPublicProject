//
//  RootTabBarController.m
//  WilliamProject
//
//  Created by WilliamChen on 15/11/9.
//  Copyright © 2015年 WilliamChen. All rights reserved.
//

#import "RootTabBarController.h"

#import "ForYouViewController.h"
#import "NewViewController.h"
#import "RadioViewController.h"
#import "ConnectViewController.h"
#import "MyMusicViewController.h"

@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.tintColor = [UIColor orangeColor];
    
    ForYouViewController *forYouVC = [[ForYouViewController alloc]init];
    UITabBarItem *item1 = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:0];
    forYouVC.tabBarItem = item1;
    UINavigationController *forYouNav = [[UINavigationController alloc]initWithRootViewController:forYouVC];
    forYouVC.title = @"For You";
    
    ConnectViewController *connectVC = [[ConnectViewController alloc]init];
    UITabBarItem *item2 = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemDownloads tag:1];
    connectVC.tabBarItem = item2;
    UINavigationController *connectNav = [[UINavigationController alloc]initWithRootViewController:connectVC];
    connectVC.title = @"Connect";
    
    MyMusicViewController *myMusicVC = [[MyMusicViewController alloc]init];
    UITabBarItem *item3 = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemMostViewed tag:2];
    myMusicVC.tabBarItem = item3;
    UINavigationController *myMusicNav = [[UINavigationController alloc]initWithRootViewController:myMusicVC];
    myMusicVC.title = @"My Music";
    
    RadioViewController *radioVC = [[RadioViewController alloc]init];
    UITabBarItem *item4 = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemHistory tag:3];
    radioVC.tabBarItem = item4;
    UINavigationController *radioNav = [[UINavigationController alloc]initWithRootViewController:radioVC];
    radioVC.title = @"Radio";

    NewViewController *newVC = [[NewViewController alloc]init];
    UITabBarItem *item5 = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:4];
    newVC.tabBarItem = item5;
    UINavigationController *newNav = [[UINavigationController alloc]initWithRootViewController:newVC];
    newVC.title = @"New";

    self.viewControllers = @[forYouNav, newNav, radioNav, connectNav, myMusicNav];
    
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
