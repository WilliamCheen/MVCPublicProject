//
//  NewViewController.m
//  WilliamProject
//
//  Created by WilliamChen on 15/11/10.
//  Copyright © 2015年 WilliamChen. All rights reserved.
//

#import "NewViewController.h"
#import "SVPullToRefresh.h"
#import "NewsTestController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "NewsViewCell.h"

@interface NewViewController ()<UIToolbarDelegate, UITableViewDataSource, UITableViewDelegate, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIToolbar   *segContainerBar;
@property (nonatomic, strong) NSArray     *cities;
@property (nonatomic, strong) UISegmentedControl *segControl;

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.cities = @[@"北京",@"上海",@"广州",@"南京",@"青岛",@"郑州",@"湖南",@"南京",@"青岛",@"郑州",@"湖南"];
    self.navigationController.toolbarHidden = NO;
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[NewsViewCell class] forCellReuseIdentifier:@"CellID"];

	[self.view addSubview:self.segContainerBar];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:self.segControl];
    self.segContainerBar.items = @[item];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"TransparentPixel"]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Pixel"] forBarMetrics:UIBarMetricsDefault];
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.view.frame = [UIScreen mainScreen].bounds;

    UIEdgeInsets edgeInset = self.tableView.contentInset;
    if (edgeInset.top < 108) {
        edgeInset.top = 108;
        self.tableView.contentInset = edgeInset;
        self.tableView.scrollIndicatorInsets = edgeInset;
        
        if (!_tableView.pullToRefreshView) {
            __weak NewViewController *weakSelf = self;
            [_tableView addPullToRefreshWithActionHandler:^{
                NSLog(@"下拉刷新");
                [weakSelf performSelector:@selector(hidRefreshView) withObject:nil afterDelay:1];
            }];
            
            _tableView.contentOffset = CGPointMake(0, -108);
        }
    }
}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar{
    return  UIBarPositionTopAttached;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_tableView triggerPullToRefresh];
    
    
}

#pragma mark EventResponse

- (void)segmentControlAction
{
    
    [_tableView triggerPullToRefresh];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"OffSet:%@",NSStringFromCGPoint(scrollView.contentOffset));
}

- (void)hidRefreshView
{
    [_tableView.pullToRefreshView stopAnimating];
}

#pragma mark -UITableViewDateSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.cities.count;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID" forIndexPath:indexPath];
//    [cell configureCellWithString:self.cities[indexPath.row]];
    cell.textLabel.text = self.cities[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"Image_header"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsTestController *vc = [[NewsTestController alloc]init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - DZNEmptyDataSetSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"user_frobidden"];
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
    
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
    
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *title = @"您已经被屏蔽";
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont italicSystemFontOfSize:16],
                                NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    return [[NSAttributedString alloc]initWithString:title attributes:attribute];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -100;
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *title = @"您好，由于用户多次举报，您涉嫌传播非法图片或者非法文章行为，在本平台核实后已决定将您屏蔽，如非本人操作，请进行申述";
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont italicSystemFontOfSize:13],
                                NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    return [[NSAttributedString alloc]initWithString:title attributes:attribute];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    NSString *buttonTitle = @"联系她她管理员";
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.lineSpacing = 5.0f;
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont italicSystemFontOfSize:13],
                                NSForegroundColorAttributeName:[UIColor blueColor],
                                NSUnderlineStyleAttributeName:@(NSUnderlineStyleThick),
                                NSParagraphStyleAttributeName:style,
                                NSStrokeColorAttributeName:[UIColor blueColor]};
    return [[NSAttributedString alloc]initWithString:buttonTitle attributes:attribute];
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView
{
    return YES;
}

#pragma mark - Setter And Getter

- (UISegmentedControl *)segControl{
    if (_segControl == nil) {
        _segControl = [[UISegmentedControl alloc]initWithItems:@[@"热门",@"精选",@"排行"]];
        _segControl.frame = CGRectMake(20, 7, CGRectGetWidth(self.view.frame) - 40, 30);
        _segControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _segControl.selectedSegmentIndex = 0;
        [_segControl addTarget:self action:@selector(segmentControlAction) forControlEvents:UIControlEventValueChanged];
    }  
    return _segControl;
}

- (UIToolbar *)segContainerBar{
    if (_segContainerBar == nil) {
        _segContainerBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 44)];
        _segContainerBar.delegate = self;
    }
    return _segContainerBar;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 80;
    }
    return _tableView;
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
