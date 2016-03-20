//
//  RecordingView.m
//  WilliamProject
//
//  Created by WilliamChen on 15/11/18.
//  Copyright © 2015年 WilliamChen. All rights reserved.
//

#import "RecordingView.h"

//=============== AnimateView ===============//
//===========================================//
//===========================================//
//===========================================//

@class AnimateView;
@protocol AnimateViewDelegate <NSObject>

- (void)animateViewDidSendRecord:(AnimateView *)animateView;    // 发送录音
- (void)animateViewDidPausePlay:(AnimateView *)animateView;		// 暂停播放
- (void)animateViewDidStartPlay:(AnimateView *)animateView;		// 开始播放
- (void)animateViewDidStopRecord:(AnimateView *)animateView;    // 停止录音

@end

@interface AnimateView : UIView

- (void)setStateRecording;
- (void)setEndedRecording;
- (void)setStateWaitPlay;
- (void)setStateAlwaysRecording;

@end

@interface AnimateView ()
@property (nonatomic, strong) UIButton *sendBtn;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, assign) BOOL      isAlways;
@property (nonatomic, weak) id<AnimateViewDelegate> delegate;
@end

@implementation AnimateView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configureSubviews];
    }
    return self;
}

- (void)configureSubviews{
    [self addSubview:self.playBtn];
    [self addSubview:self.sendBtn];
}

- (void)buttonClick{
    NSLog(@"SDFSDFSDF");
}

#pragma mark -Event Response

- (void)playButtonClick{
    if (self.isAlways) {
        [self setEndedRecording];
        
        if ([self.delegate respondsToSelector:@selector(animateViewDidStopRecord:)]) {
            [self.delegate animateViewDidStopRecord:self];
        }
        
        self.isAlways = NO;
        return;
    }
    
    if (!self.playBtn.selected){
        [self setStateWaitPlay];
        
        if ([self.delegate respondsToSelector:@selector(animateViewDidStartPlay:)]) {
            [self.delegate animateViewDidStartPlay:self];
        }
        
        NSLog(@"开始播放");
    }
    else {
        [self setEndedRecording];
        
        if ([self.delegate respondsToSelector:@selector(animateViewDidPausePlay:)]) {
            [self.delegate animateViewDidPausePlay:self];
        }
        
        NSLog(@"停止播放");
    }
}

- (void)sendRecordButtonAction{
    if ([self.delegate respondsToSelector:@selector(animateViewDidSendRecord:)]) {
        [self.delegate animateViewDidSendRecord:self];
    }
}


#pragma mark -Public Method

- (void)setStateAlwaysRecording{
    self.playBtn.highlighted = YES;
    self.playBtn.enabled = YES;
    
    self.playBtn.selected = NO;
    
    self.isAlways = YES;
}

- (void)setStateRecording{
    [self configueBackgroundImages];
    
    self.playBtn.selected = NO;
    self.playBtn.enabled = NO;
    
    self.playBtn.highlighted = NO;
    
    self.isAlways = NO;
}

- (void)setEndedRecording{
    self.playBtn.highlighted = NO;
    self.playBtn.enabled = YES;
    self.playBtn.selected = NO;
    
    [self cleanBackgroundImages];
}

- (void)setStateWaitPlay{
    self.playBtn.highlighted = NO;
    self.playBtn.selected = YES;
    
    self.playBtn.enabled = YES;
}

- (void)configueBackgroundImages{
    [self.playBtn setBackgroundImage:[UIImage imageNamed:@"topic_record_hl"] forState:UIControlStateDisabled];
    [self.playBtn setBackgroundImage:[UIImage imageNamed:@"topic_record_stop"] forState:UIControlStateHighlighted];
}

- (void)cleanBackgroundImages{
    [self.playBtn setBackgroundImage:nil forState:UIControlStateDisabled];
    [self.playBtn setBackgroundImage:nil forState:UIControlStateHighlighted];
}


#pragma mark -Setters And Getters

- (UIButton *)sendBtn{
    if (_sendBtn == nil) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendBtn.frame = CGRectMake(0, 9, 40, 40);
        _sendBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [_sendBtn addTarget:self action:@selector(sendRecordButtonAction) forControlEvents:UIControlEventTouchUpInside];

        [_sendBtn setBackgroundImage:[UIImage imageNamed:@"topic_recorc_send"] forState:UIControlStateNormal];
    }
    return _sendBtn;
}

- (UIButton *)playBtn{
    if (_playBtn == nil) {
        CGFloat frameH = CGRectGetHeight(self.frame) / 2.0;
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    	_playBtn.frame = CGRectMake(0, frameH - 40 - 5, 40, 40);
    	_playBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        [_playBtn setBackgroundImage:[UIImage imageNamed:@"topic_record_play"] forState:UIControlStateNormal];
        [_playBtn setBackgroundImage:[UIImage imageNamed:@"topic_record_pause"] forState:UIControlStateSelected];
        [_playBtn setBackgroundImage:[UIImage imageNamed:@"topic_record_hl"] forState:UIControlStateDisabled];
        [_playBtn setBackgroundImage:[UIImage imageNamed:@"topic_record_stop"] forState:UIControlStateHighlighted];
        
        [_playBtn addTarget:self action:@selector(playButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

@end

//============== RecordingView ==============//
//===========================================//
//===========================================//
//===========================================//

#pragma mark -

@interface RecordingView () <AnimateViewDelegate>
@property (nonatomic, strong) AnimateView *animateView;
@property (nonatomic, strong) UILabel     *alertLab;
@property (nonatomic, strong) UIButton    *recordBtn;
@property (nonatomic, strong) UIButton    *deleteBtn;
@property (nonatomic, assign) BOOL         canAlwaysRecord; // 是否可以一直录音
@property (nonatomic, assign) BOOL         isReal;          // 是否是真的录音开始
@end

@implementation RecordingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureSubviews];
    }
    return self;
}

#pragma mark -AnimateViewDelegate

- (void)animateViewDidPausePlay:(AnimateView *)animateView{
    if ([self.delegate respondsToSelector:@selector(recordViewPausePlayRecordAction:)]) {
        [self.delegate recordViewPausePlayRecordAction:self];
    }
}

- (void)animateViewDidSendRecord:(AnimateView *)animateView{
    if ([self.delegate respondsToSelector:@selector(recordViewSendRecordAction:)]) {
        [self.delegate recordViewSendRecordAction:self];
    }
}

- (void)animateViewDidStartPlay:(AnimateView *)animateView{
    if ([self.delegate respondsToSelector:@selector(recordViewStartPlayRecordAction:)]) {
        [self.delegate recordViewStartPlayRecordAction:self];
    }
}

- (void)animateViewDidStopRecord:(AnimateView *)animateView{
    if ([self.delegate respondsToSelector:@selector(recordViewStopRecordAction:)]) {
        [self.delegate recordViewStopRecordAction:self];
    }
}

#pragma mark -Event Response

- (void)startRecording{				// 按下录音后立刻回应，按下时间太短则不算能真正开始录音
    
    // 在延迟0.5秒后开始真正的录音
    
    self.isReal = YES;
    [self performSelector:@selector(realStartRecording) withObject:nil afterDelay:0.5];
}

// 真正开始录音

- (void)realStartRecording{
    if (self.isReal) {
        [self alertLabelChanged];
        [self.animateView setStateRecording];
        self.canAlwaysRecord = NO;
        
        // 传递开始录音事件
        
        if ([self.delegate respondsToSelector:@selector(recordViewStartRecordAction:)]) {
            [self.delegate recordViewStartRecordAction:self];
        }
        
        // 动画弹出录音控制View
        
        if (![self.subviews containsObject:self.animateView]) {
            [self addSubview:self.animateView];
            
            [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:20 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                self.recordBtn.alpha = 0;
                self.deleteBtn.alpha = 1;
                
                CGSize realSize = CGSizeMake(50, 128);
                CGFloat centerYOffSet = (128 - 50) / 2.0;
                self.animateView.bounds = CGRectMake(0, 0, realSize.width, realSize.height);
                self.animateView.center = CGPointMake(self.recordBtn.center.x, self.recordBtn.center.y - centerYOffSet);
            } completion:nil];
        }
    }
    else {
        
        // 不是真正录音的处理
        
    }
}

- (void)endedRecording{
    self.isReal = NO;  // 判断是否真的录音用
    
    if (self.canAlwaysRecord) {
        
    }else{
        [self.animateView setEndedRecording];
        
        if ([self.delegate respondsToSelector:@selector(recordViewStopRecordAction:)]) {
            [self.delegate recordViewStopRecordAction:self];
        }
    }
}

- (void)outSideRecording{
    self.canAlwaysRecord = YES;   // 可以自动一直录音
    [self.animateView setStateAlwaysRecording];
}

- (void)deleteButtonAction{
    [self alertLabelRecover];
    
    if ([self.delegate respondsToSelector:@selector(recordViewDeleteRecordAction:)]) {
        [self.delegate recordViewDeleteRecordAction:self];
    }
    
    if ([self.subviews containsObject:self.animateView]) {
        [UIView animateWithDuration:0.5 animations:^{
            self.recordBtn.alpha = 1;
            self.deleteBtn.alpha = 0;
            self.animateView.alpha = 0.2;
            
            self.animateView.bounds = CGRectZero;  // Temp Bounds
            self.animateView.center = self.recordBtn.center; // Temp Center
        } completion:^(BOOL finished) {
            
            self.animateView.bounds = CGRectMake(0, 0, 40, 100);  // Temp Bounds
            CGFloat centerYOffset = (100 - 40) / 2.0;             // Temp Center
            
            self.animateView.center = CGPointMake(self.recordBtn.center.x, self.recordBtn.center.y - centerYOffset);
            self.animateView.alpha = 1;
            [self.animateView removeFromSuperview];
        }];
    }
}

#pragma mark -Override

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (self.outsideView != nil) {
        CGRect rect = self.outsideView.frame;
        if (CGRectContainsPoint(rect, point)) {
            NSLog(@"Contain Handle");
            
            return self.outsideView;
//            if ([self.outsideView isKindOfClass:[UIButton class]]) {
//                UIButton *subBtn = (UIButton *)self.outsideView;
//                return subBtn;
//            }
        }
    }
    
    return self;
}

#pragma mark -Private Method

- (void)configureSubviews{
    [self addSubview:self.alertLab];
    [self alertLabelRecover];
    
    [self addSubview:self.recordBtn];
    [self addSubview:self.deleteBtn];
    
    self.outsideView = self.animateView;
}

- (void)alertLabelRecover{
    self.alertLab.text = @"轻点并按住来录制和发送";
    self.alertLab.backgroundColor = [UIColor clearColor];
}

- (void)alertLabelChanged{
    self.alertLab.text = nil;
    self.alertLab.backgroundColor = [UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1.0];
}

#pragma mark -Setters And Getter

- (AnimateView *)animateView{
    if (_animateView == nil) {
        _animateView = [[AnimateView alloc]init];
        _animateView.layer.cornerRadius = 25;
        _animateView.clipsToBounds = YES;
        _animateView.delegate = self;
        _animateView.bounds = CGRectMake(0, 0, 40, 100);  // Temp Bounds
        CGFloat centerYOffset = (100 - 40) / 2.0;
        
        // Temp Center
        _animateView.center = CGPointMake(self.recordBtn.center.x, self.recordBtn.center.y - centerYOffset);
        _animateView.backgroundColor = [UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1.0];
    }
    return _animateView;
}

- (UILabel *)alertLab{
    if (_alertLab == nil) {
        CGFloat frameH = CGRectGetHeight(self.frame);
        CGFloat frameW = CGRectGetWidth(self.frame) - 63;
        _alertLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frameW, frameH)];
        _alertLab.font = [UIFont systemFontOfSize:13];
        _alertLab.textAlignment = NSTextAlignmentCenter;
        _alertLab.textColor = [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1.0];
        _alertLab.layer.cornerRadius = CGRectGetHeight(self.frame) / 2.0;
        _alertLab.clipsToBounds = YES;
    }
    return _alertLab;
}

- (UIButton *)recordBtn{
    if (_recordBtn == nil) {
        _recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_recordBtn setBackgroundImage:[UIImage imageNamed:@"topic_record_icon"] forState:UIControlStateNormal];
        
        CGFloat frameH = CGRectGetHeight(self.frame);
        CGFloat frameW = CGRectGetWidth(self.frame);
        _recordBtn.bounds = CGRectMake(0, 0, frameH, frameH);
        _recordBtn.center = CGPointMake(frameW - 25, frameH / 2.0);
        
        [_recordBtn addTarget:self action:@selector(startRecording) forControlEvents:UIControlEventTouchDown];
        [_recordBtn addTarget:self action:@selector(endedRecording) forControlEvents:UIControlEventTouchUpInside];
        [_recordBtn addTarget:self action:@selector(outSideRecording) forControlEvents:UIControlEventTouchDragOutside];
    }
    return _recordBtn;
}

- (UIButton *)deleteBtn{
    if (_deleteBtn == nil) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat frameH = CGRectGetHeight(self.frame);
        _deleteBtn.frame = CGRectMake( 1 , 1, frameH - 2, frameH - 2);
        [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"topic_record_delete"] forState:UIControlStateNormal];
        _deleteBtn.alpha = 0;
        [_deleteBtn addTarget:self action:@selector(deleteButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

@end
