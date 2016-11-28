//
//  RadioViewController.m
//  WilliamProject
//
//  Created by WilliamChen on 15/11/10.
//  Copyright © 2015年 WilliamChen. All rights reserved.
//

#import "RadioViewController.h"
#import "SVPullToRefresh.h"
#import "MasonryViewController.h"
#import "PDTSimpleCalendar.h"
#import "RadioTableViewCell.h"
#import "MJRefresh.h"

@interface RadioViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *table;
}
@property (nonatomic, strong) NSMutableArray *datasource;

@end

@implementation RadioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _datasource = [NSMutableArray array];
    
    table = [[UITableView alloc]initWithFrame:self.view.bounds];
    table.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    table.dataSource = self;
    table.delegate = self;
    [self.view addSubview:table];
    [table registerClass:[RadioTableViewCell class] forCellReuseIdentifier:@"cellReuse"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!table.pullToRefreshView) {
        __weak RadioViewController *weakSelf = self;
        [table addPullToRefreshWithActionHandler:^{
            [weakSelf refreshData];
        }];
        [table addInfiniteScrollingWithActionHandler:^{
            [weakSelf loadMoreData];
        }];
    }
    [table triggerPullToRefresh];
}

- (void)refreshData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_datasource removeAllObjects];
        for (NSUInteger i = 0; i < 20; i ++) {
            [_datasource addObject:@1];
        }
        [table.pullToRefreshView stopAnimating];
        [table reloadData];
    });
}

- (void)loadMoreData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (NSUInteger i = 0; i < 20; i ++) {
            [_datasource addObject:@1];
        }
        [table.infiniteScrollingView stopAnimating];
        [table reloadData];
        
        if (_datasource.count >= 100) {
            [table.mj_footer endRefreshingWithNoMoreData];
        }
        else {
            [table.mj_footer endRefreshing];
        }
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RadioTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellReuse" forIndexPath:indexPath];
    cell.textLabel.text = @"SVPullToRefresh";
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.datasource removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [table deselectRowAtIndexPath:indexPath animated:YES];
    
    
    MasonryViewController *vc = [[MasonryViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    NSLog(@"Table Section:%@", NSStringFromUIEdgeInsets(tableView.contentInset));
    
    
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
