//
//  ForYouViewController.m
//  WilliamProject
//
//  Created by WilliamChen on 15/11/10.
//  Copyright © 2015年 WilliamChen. All rights reserved.
//

#import "ForYouViewController.h"
#import "UIImageView+YYWebImage.h"
#import "M80AttributedLabel.h"
#import "TTTTViewController.h"
#import "CustomTransitionAController.h"

@interface ForYouViewController ()<M80AttributedLabelDelegate, UITextViewDelegate>
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
    // IMG_0058.JPG
    // Do any additional setup after loading the view.
    
//    dispatch_queue_t queue1 = dispatch_queue_create("com.xiaoyu.queue1", DISPATCH_QUEUE_SERIAL);
//    
//    dispatch_sync(queue1, ^{
//        [NSThread sleepForTimeInterval:1];
//        NSLog(@"线程任务一:%@",[NSThread currentThread]);
//    });
//    dispatch_sync(queue1, ^{
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"线程任务二:%@",[NSThread currentThread]);
//    });
//    dispatch_sync(queue1, ^{
//        [NSThread sleepForTimeInterval:3];
//        NSLog(@"线程任务三:%@",[NSThread currentThread]);
//    });
    /*
    MWPhoto *photo1 = [MWPhoto photoWithURL:[NSURL URLWithString:@"http://devel-test-processing.lestata.com/TaTaUploads/Topic/2016-01-15/199109591452841525804474938.jpg"]];
    MWPhoto *photo2 = [MWPhoto photoWithURL:[NSURL URLWithString:@"http://devel-test-processing.lestata.com/TaTaUploads/Topic/2016-01-15/199109591452841525918436279.jpg"]];
    _browserPhotos = [NSMutableArray arrayWithObjects:photo1, photo2, nil];*/
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor orangeColor]];
    [button setFrame:CGRectMake(100, 80, self.view.width - 200, 40)];
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
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(320, 320));
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
    
    M80AttributedLabel *label  = [[M80AttributedLabel alloc]initWithFrame:CGRectMake(10, self.view.height - 119, self.view.width - 20, 30)];
    label.text = @"@夏天正好，天空灰的像苦海，离开你以后，我没有，更自由，你说我们都没有错，只是忘了怎么退后，心事给了沉默，你说我们都没有错，只是忘了怎么退后，心事给了沉默";
    label.textColor = [UIColor lightGrayColor];
    label.lineSpacing = -2;
    label.linkColor = [UIColor redColor];
    label.numberOfLines = 0;
    label.delegate = self;
    label.font = [UIFont systemFontOfSize:13];
    [label addCustomLink:@"http://www.baidu.com" forRange:NSMakeRange(0, 4)];
    [self.view addSubview:label];
    [label sizeToFit];
    
//    _backView.layer.shouldRasterize = YES;
//    _backView.transform = CGAffineTransformScale(_backView.transform, 0.5, 0.5);
//    _backView.transform = CGAffineTransformRotate(_backView.transform, 0.2);
//    
//    
//    CGAffineTransform transform = CGAffineTransformIdentity;
//    transform = CGAffineTransformScale(transform, 0.5, 0.5);
//    transform = CGAffineTransformRotate(transform, M_1_PI);
//    transform = CGAffineTransformTranslate(transform, 200, 0);
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / 500.0;
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
    
    [UIView animateWithDuration:2 animations:^{
        _backView.layer.transform = transform;
    }];
}

- (void)m80AttributedLabel:(M80AttributedLabel *)label clickedOnLink:(id)linkData
{
    NSLog(@"CustomLink:%@",linkData);
    NSLog(@"Bounds:%@ \n Frame:%@", NSStringFromCGRect(_backView.bounds), NSStringFromCGRect(_backView.frame));
    
    
    
    /*
    TTTTViewController *vc = [[TTTTViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES; 
    [self.navigationController pushViewController:vc animated:YES];*/
    
    /*
    TTTTViewController *vc = [[TTTTViewController alloc]init];
    self.tabBarController.definesPresentationContext = YES;
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self.tabBarController presentViewController:vc animated:YES completion:nil];*/
    
    /*
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc]initWithDelegate:self];
    browser.displayActionButton = NO;
    browser.displayNavArrows = NO;
    browser.displaySelectionButtons = NO;
    browser.zoomPhotosToFill = YES;
    browser.alwaysShowControls = NO;
    browser.enableGrid = YES;
    browser.startOnGrid = NO;
    browser.autoPlayOnAppear = NO;
    [self.navigationController pushViewController:browser animated:YES];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(deleteBarItemAction)];
    browser.navigationItem.rightBarButtonItem = item;*/
    
    
    CustomTransitionAController *avc = [[CustomTransitionAController alloc]init];
    [self.navigationController pushViewController:avc animated:YES];
    
    
}

- (void)deleteBarItemAction
{
    NSLog(@"DELETE");
}

//- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
//{
//    return _browserPhotos.count;
//}
//
//- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
//{
//    return _browserPhotos[index];
//}

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
