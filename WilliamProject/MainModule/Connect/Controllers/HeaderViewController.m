//
//  HeaderViewController.m
//  WilliamProject
//
//  Created by WilliamChen on 16/3/1.
//  Copyright © 2016年 WilliamChen. All rights reserved.
//

#import "HeaderViewController.h"

@interface HeaderViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIPageViewController *pageController;
@end

@implementation HeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 60;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ReuseId"];
//    [self.view addSubview:_tableView];
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, 300)];
    _headerView.backgroundColor = [UIColor orangeColor];
//    [self.view insertSubview:_headerView belowSubview:_tableView];
    
    CGRect tableHeaderFrame = _headerView.bounds;
    tableHeaderFrame.size.height += 64;
    UIView *tableHeaderView = [[UIView alloc]initWithFrame:tableHeaderFrame];
    tableHeaderView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = tableHeaderView;
    
    _pageController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _pageController.dataSource = self;
    _pageController.delegate = self;
    
    UIViewController* vc1 = [[UIViewController alloc]init];
    vc1.view.backgroundColor = [UIColor greenColor];
    UIViewController* vc2 = [[UIViewController alloc]init];
    vc2.view.backgroundColor = [UIColor blueColor];
    UIViewController* vc3 = [[UIViewController alloc]init];
    vc3.view.backgroundColor = [UIColor redColor];
    
    UIViewController* vc4 = [[UIViewController alloc]init];
    vc4.view.backgroundColor = [UIColor darkGrayColor];
    UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:vc4];
    _dataArray = @[vc1,vc2,vc3,nav].mutableCopy;
    
    [_pageController setViewControllers:@[vc1] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [self addChildViewController:_pageController];
    _pageController.view.frame = self.view.bounds;
    [self.view addSubview:_pageController.view];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger num = [_dataArray indexOfObject:viewController];
    num++;
    if(num == _dataArray.count){
        UIViewController* vc = [[UIViewController alloc]init];
        vc.view.backgroundColor = [UIColor brownColor];
        [self presentViewController:vc animated:YES completion:^{
            
        }];
        return nil;
    }
    return _dataArray[num];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger num = [_dataArray indexOfObject:viewController];
    num --;
    if ((num == 0) || (num == NSNotFound) || num == _dataArray.count-1) {
        return nil;
    }
    num --;
    return _dataArray[num];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY >= 0 && offsetY <= 64+_headerView.height) {
        _headerView.y  = -offsetY + 64;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReuseId"];
    cell.textLabel.text = @"测试";
    return cell;
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
