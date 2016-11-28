//
//  MyMusicViewController.m
//  WilliamProject
//
//  Created by WilliamChen on 15/11/10.
//  Copyright © 2015年 WilliamChen. All rights reserved.
//

#import "MyMusicViewController.h"
#import "UIImageView+WebCache.h"

@interface MyMusicViewController ()<UIAlertViewDelegate>
@property (nonatomic, assign) NSInteger food;
@end

@implementation MyMusicViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor lightGrayColor];
    [button setTitle:@"测试" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
        make.height.equalTo(@44.0);
    }];
}

- (void)buttonAction
{
    if (_food == 0) {
        _food = 50;
        NSInteger personNum = 5;
        for (int i = 0; i < personNum; i ++) {
            NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
            [thread setName:[NSString stringWithFormat:@"%d号人员", i + 1]];
            [thread start];
        }
    }
}

- (void)run
{
    while (true) {
        @synchronized (self) {
            if (_food > 0) {
                [NSThread sleepForTimeInterval:0.5];
                _food --;
                NSLog(@"%@ 夹走了菜，还剩余%d", [NSThread currentThread].name, _food);
            }
            else {
                NSLog(@"完毕");
                break;
            }
        }
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
