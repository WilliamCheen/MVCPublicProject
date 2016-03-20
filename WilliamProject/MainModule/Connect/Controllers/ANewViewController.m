//
//  ANewViewController.m
//  WilliamProject
//
//  Created by WilliamChen on 16/3/1.
//  Copyright © 2016年 WilliamChen. All rights reserved.
//

#import "ANewViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface ANewViewController ()
@property (nonatomic, strong) UIViewController *first;
@property (nonatomic, strong) UIViewController *second;
@property (nonatomic, weak) UIViewController *current;
@end

@implementation ANewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    
    self.first = [[FirstViewController alloc]init];
    self.second = [[SecondViewController alloc]init];
    
    [self addChildViewController:self.first];
    [self addChildViewController:self.second];
    
    [self.view addSubview:self.second.view];
    self.current = self.second;
    
    UISegmentedControl *seg = [[UISegmentedControl alloc]initWithItems:@[@"第一个", @"第二个"]];
    seg.frame = CGRectMake(50, self.view.height - 60, self.view.width - 100, 40);
    [seg addTarget:self action:@selector(segmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:seg];
}

- (void)segmentedControlAction:(UISegmentedControl *)seg
{
    if (seg.selectedSegmentIndex == 0) {
        if (self.current == self.first) {
            return;
        }
        
        [self transitionFromViewController:self.current toViewController:self.first duration:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.current.view.x += self.current.view.width;
            self.first.view.x += self.current.view.width;
        } completion:^(BOOL finished) {
            if (finished) {
                self.current = self.first;
            }
        }];
    }else if (seg.selectedSegmentIndex == 1){
        if (self.current == self.second) {
            return;
        }
        
        [self transitionFromViewController:self.current toViewController:self.second duration:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.current.view.x -= self.current.view.width;
            self.second.view.x -= self.current.view.width;
        } completion:^(BOOL finished) {
            if (finished) {
                self.current = self.second;
            }
        }];
    }
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
