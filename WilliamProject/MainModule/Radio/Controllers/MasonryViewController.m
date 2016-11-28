//
//  MasonryViewController.m
//  WilliamProject
//
//  Created by WilliamChen on 16/5/30.
//  Copyright © 2016年 WilliamChen. All rights reserved.
//

#import "MasonryViewController.h"
#import "PDTSimpleCalendarViewController.h"
#import "BaseMasonryView.h"
#import "MyMusicViewController.h"
#import "MWPhotoBrowser.h"
#import "TransitionAlphaAnimator.h"
#import "PhotoBrowserTransition.h"

@interface DateModel : NSObject
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) BOOL isEnable;
@property (nonatomic, copy) NSString *price;

@end

@interface MasonryViewController ()<PDTSimpleCalendarViewDelegate, UIViewControllerTransitioningDelegate, MWPhotoBrowserDelegate>
@property (nonatomic, strong) NSArray *noneableDate;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) PDTSimpleCalendarViewController *calendarController;
@end

@implementation MasonryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"管理";
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _calendarController = [[PDTSimpleCalendarViewController alloc]init];
    _calendarController.weekdayTextType = PDTSimpleCalendarViewWeekdayTextTypeVeryShort;
    _calendarController.weekdayHeaderEnabled = YES;
    _calendarController.delegate = self;
    [self addChildViewController:_calendarController];
    _calendarController.view.frame = CGRectMake(0, 100, self.view.width, 400);
    [self.view addSubview:_calendarController.view];
    [_calendarController didMoveToParentViewController:self];
    
    NSString *startDateStr = @"2016-06-01";
    NSString *endDateStr = @"2016-09-30";
    
    _dateFormatter = [[NSDateFormatter alloc]init];
    _dateFormatter.dateFormat = @"yyyy-MM-dd";
    _dateFormatter.timeZone = [NSTimeZone systemTimeZone];
    
    NSDate *startDate = [_dateFormatter dateFromString:startDateStr];
    NSDate *endDate = [_dateFormatter dateFromString:endDateStr];
    
    _calendarController.firstDate = startDate;
    _calendarController.lastDate = endDate;
    
    
    NSMutableArray *mArr = [NSMutableArray array];
    NSString *dateBegainStr = @"2016-07-";
    for (NSUInteger i = 10; i < 25; i ++) {
        NSString *dateStr = [dateBegainStr stringByAppendingFormat:@"%02lu",(unsigned long)i];
        NSDate *date = [_dateFormatter dateFromString:dateStr];
        [mArr addObject:date];
    }
    _noneableDate = [NSArray arrayWithArray:mArr];
    
    // Remove child view controller example:
    /*
    [vc willMoveToParentViewController:nil];
    [vc.view removeFromSuperview];
    [vc removeFromParentViewController];
     */
    
}

- (BOOL)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller isEnabledDate:(NSDate *)date
{
    for (NSDate * noneDate in _noneableDate) {
        if (([noneDate compare:date] == NSOrderedSame)) {
            return NO;
        }
    }
    return YES;
}


UIViewController *pController;
NSArray *photos;

- (void)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller didSelectDate:(NSDate *)date
{
    NSLog(@"SelectedDate:%@", [_dateFormatter stringFromDate:date]);
    
    /*
    pController = [[MyMusicViewController alloc]init];
    pController.modalPresentationStyle = UIModalPresentationCustom;
    pController.transitioningDelegate = self;
    pController.view.frame = CGRectMake(0, 0, self.view.width, self.view.height/2.0);
    [self presentViewController:pController animated:YES completion:nil];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor lightGrayColor];
    [button addTarget:self action:@selector(dismissAction) forControlEvents:UIControlEventTouchUpInside];
    [pController.view addSubview:button];

    button.size = CGSizeMake(100, 40);
    button.center = CGPointMake(pController.view.width/2.0, pController.view.height/2.0);
     */
    
    
    NSString *img1 = @"http://devel-test-processing.lestata.com/TaTaUploads/Topic/2016-02-25/199109651456393238391823176.jpg";
    NSString *img2 = @"http://devel-test-processing.lestata.com/TaTaUploads/Topic/2016-02-25/199109651456393238647080879.jpg";
    NSString *img3 = @"http://devel-test-processing.lestata.com/Topic/Join/199025641453972721/81713.jpg";
    
    MWPhoto *photo1 = [MWPhoto photoWithURL:[NSURL URLWithString:img1]];
    MWPhoto *photo2 = [MWPhoto photoWithURL:[NSURL URLWithString:img2]];
    MWPhoto *photo3 = [MWPhoto photoWithURL:[NSURL URLWithString:img3]];
    photos = @[photo1, photo2, photo3];
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc]initWithDelegate:self];
    browser.displayActionButton = NO;
    browser.displayNavArrows = NO;
    browser.displaySelectionButtons = NO;
    browser.zoomPhotosToFill = YES;
    browser.alwaysShowControls = NO;
    browser.enableGrid = YES;
    browser.startOnGrid = NO;
    browser.enableSwipeToDismiss = YES;
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:browser];
    nav.modalPresentationStyle = UIModalPresentationCustom;
    self.navigationController.transitioningDelegate = self;
    [self presentViewController:nav animated:YES completion:^{
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissAction)];
        [browser.view addGestureRecognizer:tap];
    }];
}

#pragma mark UITextFieldDelegate


- (void)dismissAction
{
    [pController dismissViewControllerAnimated:YES completion:nil];
}

- (void)transitionViewController:(UIViewController *)fromController toController:(UIViewController *)toController
{
    [fromController willMoveToParentViewController:nil];
    [self addChildViewController:toController];
    
    CGRect oldFrame = CGRectMake(0, 0, self.view.width, self.view.height);
    CGRect newFrame = CGRectMake(0, 0, self.view.width, self.view.height);
    
    [self transitionFromViewController:fromController toViewController:toController duration:1 options:0 animations:^{
        fromController.view.frame = oldFrame;
        toController.view.frame = newFrame;
    } completion:^(BOOL finished) {
        [fromController removeFromParentViewController];
        [toController didMoveToParentViewController:self];
    }];
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    return photos[index];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    PhotoBrowserTransition *animator = [PhotoBrowserTransition new];
    animator.transformRect = CGRectMake(200, 200, 100, 100);
    return animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    PhotoBrowserTransition *animator = [PhotoBrowserTransition new];
    animator.transformRect = CGRectMake(200, 200, 100, 100);
    return animator;
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
