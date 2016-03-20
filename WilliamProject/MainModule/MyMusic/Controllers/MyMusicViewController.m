//
//  MyMusicViewController.m
//  WilliamProject
//
//  Created by WilliamChen on 15/11/10.
//  Copyright © 2015年 WilliamChen. All rights reserved.
//

#import "MyMusicViewController.h"
#import "RecordTopicViewCell.h"
#import "RecordingView.h"
#import "TestView.h"

#import "TTTopicLabel.h"

static NSString *reuseId = @"recordTopicReuseCellId";

@interface MyMusicViewController ()<UITableViewDataSource, UITableViewDelegate, RecordingViewDelegate>
@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation MyMusicViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataSource = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.toolbarHidden = NO;
    
    [self loadSubviews];
    
}

#pragma mark -RecordingViewDelegate

- (void)recordViewStartRecordAction:(RecordingView *)recordView{
    NSLog(@"===Start record");
}

- (void)recordViewStopRecordAction:(RecordingView *)recordView{
    NSLog(@"===Stop record");
}

- (void)recordViewDeleteRecordAction:(RecordingView *)recordView{
    NSLog(@"===Delete record");
}

- (void)recordViewPausePlayRecordAction:(RecordingView *)recordView{
    NSLog(@"===Pause play");
}

- (void)recordViewSendRecordAction:(RecordingView *)recordView{
    NSLog(@"===Send record");
}

- (void)recordViewStartPlayRecordAction:(RecordingView *)recordView{
    NSLog(@"===Start record");
}

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo{
    NSLog(@"Event:%@",userInfo);
}

#pragma mark -Private Method

- (void)loadSubviews{
    
//    [self.view addSubview:self.tableView];
    
    UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([RecordTopicViewCell class])
                                    bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:reuseId];
    
    CGFloat frameW = CGRectGetWidth(self.view.frame);
    RecordingView *recordingView = [[RecordingView alloc] initWithFrame:CGRectMake(0, 400, frameW - 50, 30)];
    recordingView.delegate = self;
    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:recordingView];
//    UIBarButtonItem *fItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    
//    [self setToolbarItems:@[fItem, item]];
    
//    [self.view addSubview:recordingView];
    
    
//    TestView *view = [[TestView alloc]initWithFrame:CGRectMake(100, 150, 100, 100)];
//    view.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:view];
//    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(20, -20, 50, 40);
//    [button setBackgroundColor:[UIColor blueColor]];
//    [button addTarget:self action:@selector(textButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:button];
//    view.outSideView = button;
}

- (void)textButtonClick{
    NSLog(@"JJJSSSS");
}

#pragma mark -UITableViewDateSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecordTopicViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark -Setters And Getters

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 150;
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
