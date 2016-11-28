//
//  NewsTestController.m
//  WilliamProject
//
//  Created by WilliamChen on 16/3/28.
//  Copyright © 2016年 WilliamChen. All rights reserved.
//

#import "NewsTestController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "TopicVideoPlayerControlView.h"
#import "UIImageView+AFNetworking.h"
#import <AVKit/AVKit.h>

@interface NewsTestController ()<TopicVideoPlayerControlViewDelegate>
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) MPMoviePlayerController *playerController;
@property (nonatomic, strong) UIImageView *thumbImageView;
@property (nonatomic, strong) TopicVideoPlayerControlView *playControlView;
@property (nonatomic, assign) float playRatio;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIImage *thumbImage;
@property (nonatomic, strong) UIBarButtonItem *pauseControlItem;
@property (nonatomic, strong) UIBarButtonItem *playControlItem;
@end

@implementation NewsTestController

#pragma mark - Event Response

- (void)fastForwardAction
{
    NSTimeInterval newTime = self.playControlView.playedTime + 15;
    if (newTime <= self.playControlView.videoDuration) {
        self.playerController.currentPlaybackTime = newTime;
    }
}

- (void)rewindAction
{
    NSTimeInterval newTime = self.playControlView.playedTime - 15;
    if (newTime > 0) {
        self.playerController.currentPlaybackTime = newTime;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    /*
    CALayer *imageLayer = [[CALayer alloc]init];
    imageLayer.frame = CGRectMake(0, 0, 200, 200);
    imageLayer.position = self.view.center;
    imageLayer.contents = (__bridge id)[UIImage imageNamed:@"TextPic.jpg"].CGImage;
    imageLayer.contentsGravity = kCAGravityCenter;
    imageLayer.contentsScale = [UIScreen mainScreen].scale;
    imageLayer.masksToBounds = YES;
    [self.view.layer addSublayer:imageLayer];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    
    _shapeLayer = [[CAShapeLayer alloc]init];
    _shapeLayer.path = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:50 startAngle:0 endAngle:M_PI*2 clockwise:YES].CGPath;
    _shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
    _shapeLayer.fillColor = nil;
    _shapeLayer.strokeColor = [UIColor blueColor].CGColor;
    _shapeLayer.lineWidth = 5.0f;
    _shapeLayer.strokeStart = 0.0;
    _shapeLayer.strokeEnd = 0.0;
    [self.view.layer addSublayer:_shapeLayer];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
     */
    AVAssetResourceLoader;
    UIBarButtonItem *fseek = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(fastForwardAction)];
    UIBarButtonItem *bseek = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(rewindAction)];
    _pauseControlItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPause target:self action:@selector(playerAction)];
    _playControlItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(playerAction)];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *itGap = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    itGap.width = 30;
    
    self.navigationController.toolbar.tintColor = [UIColor orangeColor];
    self.navigationController.toolbarHidden = NO;
    self.toolbarItems = @[space, bseek, itGap, _pauseControlItem, itGap, fseek, space];
    
    
    // Video URL :http://devel-test.lestata.com/TaTaUploads/Video/2016-04-01/199109661459499188851495631.mp4
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, self.view.height - 200, self.view.width - 100, 50);
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"播放" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(playerAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
    
    [self addNotification];
    
    
    
//    NSURL *URL = [NSURL URLWithString:@"http://download.wavetlan.com/SVV/Media/HTTP/MP4/ConvertedFiles/MediaCoder/MediaCoder_test1_1m9s_AVC_VBR_256kbps_640x480_24fps_MPEG2Layer3_CBR_160kbps_Stereo_22050Hz.mp4"];
    
    
    [self.playerController requestThumbnailImagesAtTimes:@[@0.1] timeOption:MPMovieTimeOptionExact];
    
    
    _thumbImageView = [[UIImageView alloc]init];
    _thumbImageView.size = CGSizeMake(100, 100);
    _thumbImageView.center = CGPointMake(self.view.centerX, 125);
    [self.view addSubview:_thumbImageView];
    
    
    
    
//    [_playerController.view addSubview:_thumbImageView];
    
    NSString *imageURLString = @"http://devel-test-processing.lestata.com/tatadev/Topic/Join/2016-03-31/1da51c3d85a4a11badcc36a9ef5c9496.jpg";
    [_thumbImageView setImageWithURL:[NSURL URLWithString:imageURLString]];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UIGraphicsBeginImageContextWithOptions(self.view.size, YES, 0.0);
        [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        
        _thumbImageView.image = image;
    });
}

- (void)updatePlayState:(BOOL)isPlaying
{
    NSMutableArray *barItems = self.toolbarItems.mutableCopy;
    if (barItems.count >=4) {
        UIBarButtonItem *index2Item = barItems[3];
        if (isPlaying && index2Item != _pauseControlItem) {
            [barItems replaceObjectAtIndex:3 withObject:_pauseControlItem];
            [self setToolbarItems:barItems animated:NO];
        }
        else if (!isPlaying && index2Item != _playControlItem){
            [barItems replaceObjectAtIndex:3 withObject:_playControlItem];
            [self setToolbarItems:barItems animated:NO];
        }
    }
}

- (MPMoviePlayerController *)playerController
{
    if (_playerController == nil) {
        NSURL *URL = [NSURL URLWithString:@"http://devel-test.lestata.com/tatadev/Topic/Join/2016-03-31/d0ebcd95565093b9cec74bc6719b25db.mp4"];
//        NSURL *URL = [NSURL URLWithString:@"http://devel2.lestata.com/radio/mp3/1478150940/79832.mp3"];
        _playerController = [[MPMoviePlayerController alloc]initWithContentURL:URL];
        _playerController.view.frame = CGRectMake(50, 200, self.view.width - 100, self.view.width - 100);
        _playerController.view.clipsToBounds = YES;
        _playerController.controlStyle = MPMovieControlStyleNone;
        
        [self.view addSubview:_playerController.view];
        
        CGRect controlFrame = CGRectMake(0, _playerController.view.height, _playerController.view.width, 20);
        _playControlView = [[TopicVideoPlayerControlView alloc]initWithFrame:controlFrame];
        _playControlView.delegate = self;
        [_playerController.view addSubview:_playControlView];
    }
    return _playerController;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (_playerController && _playerController.playbackState != MPMoviePlaybackStateStopped) {
        [_playerController stop];
    }
}

- (void)sliderValueChanged:(UISlider *)slider
{
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformScale(transform, 1+slider.value, 1+slider.value);
    _playerController.view.transform = transform;
}

- (void)playerAction
{
    if (self.playerController.playbackState == MPMoviePlaybackStatePlaying){
        [self.playerController pause];
        
        [self updatePlayState:NO];
        _thumbImageView.image = [UIImage imageNamed:@"user_frobidden"];
        
    }else{
        [self.playerController play];
        
        [self updatePlayState:YES];
        _thumbImageView.image = _thumbImage;
    }
}

- (void)topicVideoPlayerControlView:(TopicVideoPlayerControlView *)controlView touchDownControlSlider:(UISlider *)slider
{
    [self.playerController pause];
}

- (void)topicVideoPlayerControlView:(TopicVideoPlayerControlView *)controlView touchMovedControlSlider:(UISlider *)slider
{
    NSTimeInterval seekTime = (slider.value * controlView.videoDuration);
    controlView.playedTime = seekTime;
}

- (void)topicVideoPlayerControlView:(TopicVideoPlayerControlView *)controlView touchUpControlSlider:(UISlider *)slider
{
    NSTimeInterval seekTime = (slider.value * controlView.videoDuration);
    self.playerController.currentPlaybackTime = seekTime;
    [self timerAction];
}

- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playDurationAvailalbel:) name:MPMovieDurationAvailableNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadStatusChanged:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playFinishedHandle:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playStatusHandle:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(thumbImageDidGetHandle:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieReadyForDisplayChanged:) name:MPMoviePlayerReadyForDisplayDidChangeNotification object:nil];
}

- (void)dealloc
{
    [self removeNofication];
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    NSLog(@"%@ Dealloc调用", NSStringFromClass([self class]));
}

- (void)removeNofication
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMovieDurationAvailableNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerReadyForDisplayDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:nil];
}

- (void)movieReadyForDisplayChanged:(NSNotification *)notification
{
    MPMoviePlayerController *player = (MPMoviePlayerController *)notification.object;
    if (player.loadState == MPMovieLoadStatePlayable) {
//        _thumbImageView.hidden = YES;
    }
}

- (void)thumbImageDidGetHandle:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    UIImage *image = userInfo[MPMoviePlayerThumbnailImageKey];
    NSLog(@"%@", image);
    _thumbImage = image;
    _thumbImageView.image = image;
}

- (void)playDurationAvailalbel:(NSNotification *)notification
{
    MPMoviePlayerController *player = (MPMoviePlayerController *)notification.object;
    _playControlView.videoDuration = player.duration;
}

- (void)playFinishedHandle:(NSNotification *)notification
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    if (_thumbImageView.hidden) {
        _thumbImageView.hidden = NO;
    }
    
    [_playerController.view removeFromSuperview];
    _playerController = nil;
    [_playControlView changeControlViewsWithPlaybackState:MPMoviePlaybackStateStopped];
}

- (void)playStatusHandle:(NSNotification *)notification
{
    MPMoviePlayerController *player = (MPMoviePlayerController *)notification.object;
    MPMoviePlaybackState playstate = player.playbackState;
    
    switch (playstate) {
        case MPMoviePlaybackStatePlaying:
        {
            if (!_timer) {
                _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
            }
            else{
                [_timer setFireDate:[NSDate date]];
            }
        }
            break;
        case MPMoviePlaybackStatePaused:
        {
            if (_timer && _timer.valid) {
                [_timer setFireDate:[NSDate distantFuture]];
            }
        }
            break;
        case MPMoviePlaybackStateInterrupted:
        {
            if (_timer && _timer.valid) {
                [_timer setFireDate:[NSDate distantFuture]];
            }
        }
            break;
        case MPMoviePlaybackStateSeekingBackward:
            break;
        case MPMoviePlaybackStateSeekingForward:
            break;
        case MPMoviePlaybackStateStopped:
        {
            if (_timer && _timer.valid) {
                [_timer invalidate];
                _timer = nil;
            }
            
            if (_playerController) {
                [_playerController.view removeFromSuperview];
                _playerController = nil;
            }
            
            if (_thumbImageView.hidden) {
                _thumbImageView.hidden = NO;
            }
        }
            break;
            
        default:
            break;
    }
    
    [_playControlView changeControlViewsWithPlaybackState:playstate];
}

- (void)timerAction
{
    [_playControlView setVideoProgress:_playerController.currentPlaybackTime/_playControlView.videoDuration];
    _playControlView.playedTime = _playerController.currentPlaybackTime;
}

- (void)loadStatusChanged:(NSNotification *)notification
{
    MPMoviePlayerController *player = (MPMoviePlayerController *)notification.object;
    NSLog(@"LoadStatus:%@", @(player.loadState));
}

//- (void)timerAction
//{
//    static float progress = 0;
//    progress += 0.005;
//    
//    if (progress >= 1.0) {
//        [_timer invalidate];
//        _timer = nil;
//        [_shapeLayer removeFromSuperlayer];
//    }
//    
//    [self animatProgressViewToProgress:progress];
//}

- (void)animatProgressViewToProgress:(float)progress
{
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    animation.fromValue = @(self.shapeLayer.strokeEnd);
//    animation.toValue = @(progress);
//    animation.duration = 0.2;
//    animation.fillMode = kCAFillModeForwards;
    
    self.shapeLayer.strokeEnd = progress;
//    [self.shapeLayer addAnimation:animation forKey:@"animationProgress"];
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
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
