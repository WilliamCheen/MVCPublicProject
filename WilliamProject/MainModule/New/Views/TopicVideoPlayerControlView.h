//
//  TopicVideoPlayerControlView.h
//  WilliamProject
//
//  Created by WilliamChen on 16/4/5.
//  Copyright © 2016年 WilliamChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@class TopicVideoPlayerControlView;
@protocol TopicVideoPlayerControlViewDelegate <NSObject>
- (void)topicVideoPlayerControlView:(TopicVideoPlayerControlView *)controlView touchDownControlSlider:(UISlider *)slider;
- (void)topicVideoPlayerControlView:(TopicVideoPlayerControlView *)controlView touchMovedControlSlider:(UISlider *)slider;
- (void)topicVideoPlayerControlView:(TopicVideoPlayerControlView *)controlView touchUpControlSlider:(UISlider *)slider;
@end

@interface TopicVideoPlayerControlView : UIView
@property (nonatomic, assign) NSTimeInterval videoDuration;
@property (nonatomic, assign) NSTimeInterval playedTime;
@property (nonatomic, weak) id<TopicVideoPlayerControlViewDelegate>delegate;

- (void)setVideoProgress:(float)progress;
- (void)changeControlViewsWithPlaybackState:(MPMoviePlaybackState)playbackState;
- (void)playDidFinished;

@end
