//
//  ForYouViewController.m
//  WilliamProject
//
//  Created by WilliamChen on 15/11/10.
//  Copyright © 2015年 WilliamChen. All rights reserved.
//

#import "ForYouViewController.h"
#import "UIImageView+YYWebImage.h"
#import "CustomTransitionAController.h"

@interface ForYouViewController ()<UITextViewDelegate>
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) NSMutableArray *browserPhotos;
@property (nonatomic, strong) MASConstraint *topCons;
@end

@implementation ForYouViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        NSLog(@"InitWithCoder");
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"InitWithNib");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor orangeColor]];
    [button setFrame:CGRectMake(100, 80, self.view.frame.size.width - 200, 40)];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    _backView = [[UIView alloc]init];
    _backView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_backView];
    
    UIView *greenView = UIView.new;
    greenView.backgroundColor = [UIColor greenColor];
    [_backView addSubview:greenView];
    
    UIView *redView = UIView.new;
    redView.backgroundColor = [UIColor redColor];
    [_backView addSubview:redView];
    
    UIView *blueView = UIView.new;
    blueView.backgroundColor = [UIColor blueColor];
    [_backView addSubview:blueView];
    
    CGFloat padding = 10;
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
    }];
    
    [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(padding));
        self.topCons = make.top.equalTo(@(padding));
        make.right.equalTo(@(-padding));
        make.bottom.equalTo(redView.mas_top).with.offset(-padding);
        make.height.equalTo(redView);
    }];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(padding);
        make.bottom.mas_equalTo(-padding);
        make.top.mas_equalTo(greenView.mas_bottom).with.mas_offset(padding);
        make.width.mas_equalTo(blueView);
        make.right.mas_equalTo(blueView.mas_left).with.mas_offset(-padding);
    }];
    
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(greenView.mas_bottom).with.mas_offset(padding);
        make.right.mas_equalTo(-padding);
        make.bottom.mas_equalTo(-padding);
    }];
}

- (void)buttonAction
{
    self.topCons.offset = 100;
    
    [_backView setNeedsUpdateConstraints];
    [_backView updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [_backView layoutIfNeeded];
    } completion:nil];
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / 500.0;
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
    
    [UIView animateWithDuration:2 animations:^{
        _backView.layer.transform = transform;
    }];
}

- (void)deleteBarItemAction
{
    NSLog(@"DELETE");
}

- (void)viewDidAppear:(BOOL)animated
{
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
