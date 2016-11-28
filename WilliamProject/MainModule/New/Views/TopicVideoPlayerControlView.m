//
//  TopicVideoPlayerControlView.m
//  WilliamProject
//
//  Created by WilliamChen on 16/4/5.
//  Copyright © 2016年 WilliamChen. All rights reserved.
//

#import "TopicVideoPlayerControlView.h"

@interface TopicVideoPlayerControlView ()
@property (nonatomic, strong) UILabel *playTimeLabel;
@property (nonatomic, strong) UILabel *durationLabel;
@property (nonatomic, strong) UISlider *playerSlider;
@property (nonatomic, assign) CGRect initFrame;
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation TopicVideoPlayerControlView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _initFrame = frame;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        self.progressView.alpha = 1.0f;
    }
    return self;
}

#pragma mark - Private

- (void)subviewsAlphaStatueWithPaly:(BOOL)isPlay
{
    CGFloat alpha = isPlay ? 0.0f : 1.0f;
    self.playTimeLabel.alpha = alpha;
    self.durationLabel.alpha = alpha;
    self.playerSlider.alpha = alpha;
    self.progressView.alpha = 1.0 - alpha;
}

- (void)sliderTouchDownAction
{
    if ([self.delegate respondsToSelector:@selector(topicVideoPlayerControlView:touchDownControlSlider:)]) {
        [self.delegate topicVideoPlayerControlView:self touchDownControlSlider:self.playerSlider];
    }
}

- (void)sliderValueChangedAction
{
    if ([self.delegate respondsToSelector:@selector(topicVideoPlayerControlView:touchMovedControlSlider:)]) {
        [self.delegate topicVideoPlayerControlView:self touchMovedControlSlider:self.playerSlider];
    }
}

- (void)sliderTouchDragEndAction
{
    if ([self.delegate respondsToSelector:@selector(topicVideoPlayerControlView:touchUpControlSlider:)]) {
        [self.delegate topicVideoPlayerControlView:self touchUpControlSlider:self.playerSlider];
    }
}

#pragma mark - Public

- (void)changeControlViewsWithPlaybackState:(MPMoviePlaybackState)playbackState
{
    CGFloat playingStatueH = 2.0f;
    CGRect desFrame = _initFrame;
    switch (playbackState) {
        case MPMoviePlaybackStatePlaying:
            desFrame.origin.y = _initFrame.origin.y - playingStatueH;
            break;
        case MPMoviePlaybackStatePaused:
            desFrame.origin.y = _initFrame.origin.y - _initFrame.size.height;
            break;
        case MPMoviePlaybackStateInterrupted:
            desFrame.origin.y = _initFrame.origin.y - _initFrame.size.height;
            break;
        case MPMoviePlaybackStateSeekingBackward:
            desFrame.origin.y = _initFrame.origin.y - _initFrame.size.height;
            break;
        case MPMoviePlaybackStateSeekingForward:
            desFrame.origin.y = _initFrame.origin.y - _initFrame.size.height;
            break;
        case MPMoviePlaybackStateStopped:
            desFrame.origin.y = _initFrame.origin.y;
            [self playDidFinished];
            break;
        default:
            break;
    }
    
    
    BOOL isPlay = (playbackState == MPMoviePlaybackStatePlaying) || (playbackState == MPMoviePlaybackStateStopped);
    [UIView animateWithDuration:0.25 animations:^{
        [self subviewsAlphaStatueWithPaly:isPlay];
        self.frame = desFrame;
    } completion:nil];
}

- (void)playDidFinished
{
    [self.progressView setProgress:0.0f];
    [self.playerSlider setValue:0.0f];
    self.playedTime = 0;
}

- (void)setPlayedTime:(NSTimeInterval)playedTime
{
    _playedTime = playedTime;
    
    NSString *showPlayedTime = [NSString stringWithFormat:@"%02d:%02d", (int)playedTime/60, (int)playedTime%60];
    self.playTimeLabel.text = showPlayedTime;
}

- (void)setVideoProgress:(float)progress
{
    if (_playerSlider) {
        [self.playerSlider setValue:progress animated:YES];
    }
    
    [self.progressView setProgress:progress animated:YES];
}

- (UIProgressView *)progressView
{
    if (_progressView == nil) {
        _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, self.width, 2)];
        _progressView.progressTintColor = [UIColor redColor];
        _progressView.trackTintColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:_progressView];
    }
    return _progressView;
}

- (UILabel *)playTimeLabel
{
    if (_playTimeLabel == nil) {
        CGFloat labelWidth = 38.0f;
        _playTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, labelWidth, self.height)];
        _playTimeLabel.textAlignment = NSTextAlignmentCenter;
        _playTimeLabel.textColor = [UIColor whiteColor];
        _playTimeLabel.font = [UIFont systemFontOfSize:9];
        [self addSubview:_playTimeLabel];
    }
    return _playTimeLabel;
}

- (UILabel *)durationLabel
{
    if (_durationLabel == nil) {
        CGFloat labelWidth = 38.0f;
        _durationLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width - labelWidth, 0, labelWidth, self.height)];
        _durationLabel.textAlignment = NSTextAlignmentCenter;
        _durationLabel.textColor = [UIColor whiteColor];
        _durationLabel.font = [UIFont systemFontOfSize:9];
        [self addSubview:_durationLabel];
    }
    return _durationLabel;
}

- (UISlider *)playerSlider
{
    if (_playerSlider == nil) {
        CGFloat labelWidth = 38.0f;
        _playerSlider = [[UISlider alloc] initWithFrame:CGRectMake(labelWidth, 0, self.width - labelWidth*2, self.height)];
        _playerSlider.maximumValue = 1;
        _playerSlider.maximumTrackTintColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
        _playerSlider.minimumTrackTintColor = [UIColor redColor];
        [_playerSlider setThumbImage:[UIImage imageNamed:@"iconSliderThumb"] forState:UIControlStateNormal];
        [_playerSlider addTarget:self action:@selector(sliderTouchDownAction) forControlEvents:UIControlEventTouchDown];
        [_playerSlider addTarget:self action:@selector(sliderValueChangedAction) forControlEvents:UIControlEventValueChanged];
        [_playerSlider addTarget:self action:@selector(sliderTouchDragEndAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_playerSlider];
    }
    return _playerSlider;
}

- (void)setVideoDuration:(NSTimeInterval)videoDuration
{
    _videoDuration = videoDuration;
    
    NSString *showTimeDuration = [NSString stringWithFormat:@"%02d:%02d", (int)videoDuration/60, (int)videoDuration%60];
    self.durationLabel.text = showTimeDuration;
}

@end
