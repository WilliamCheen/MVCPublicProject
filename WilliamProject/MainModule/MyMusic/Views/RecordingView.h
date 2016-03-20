//
//  RecordingView.h
//  WilliamProject
//
//  Created by WilliamChen on 15/11/18.
//  Copyright © 2015年 WilliamChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecordingView;
@protocol RecordingViewDelegate <NSObject>

- (void)recordViewStartRecordAction:(RecordingView *)recordView;      // 开始录音
- (void)recordViewStopRecordAction:(RecordingView *)recordView;		  // 停止此次录音
- (void)recordViewDeleteRecordAction:(RecordingView *)recordView;     // 删除此次录音

- (void)recordViewStartPlayRecordAction:(RecordingView *)recordView;  // 开始播放此次录音
- (void)recordViewPausePlayRecordAction:(RecordingView *)recordView;  // 暂停播放此次录音
- (void)recordViewSendRecordAction:(RecordingView *)recordView;       // 发送此次录音


@end

@interface RecordingView : UIView
@property (nonatomic, weak) UIView   *outsideView;
@property (nonatomic, weak) id<RecordingViewDelegate> delegate;

@end
