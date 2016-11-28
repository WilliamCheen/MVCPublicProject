//
//  TransitionAlphaAnimator.m
//  WilliamProject
//
//  Created by WilliamChen on 16/6/8.
//  Copyright © 2016年 WilliamChen. All rights reserved.
//

#import "TransitionAlphaAnimator.h"

@implementation TransitionAlphaAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    /* Myself transition
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    toView.alpha = 0.0;
    fromView.alpha = 1.0;
    
    UIView *container = [transitionContext containerView];
    [container addSubview:toView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        toView.alpha = 1.0;
        fromView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
     */
    
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    CGRect containerFrame = containerView.frame;
    CGRect toViewStartFrame = [transitionContext initialFrameForViewController:toVC];
    CGRect toViewFinalFrame = [transitionContext finalFrameForViewController:toVC];
    CGRect fromViewFinalFrame = [transitionContext finalFrameForViewController:fromVC];
    
    if (self.presenting) {
        toViewStartFrame.origin.x = containerView.size.width;
        toViewStartFrame.origin.y = containerView.size.height;
    }
    else{
        fromViewFinalFrame = CGRectMake(containerFrame.size.width,
                                        containerFrame.size.height,
                                        toView.frame.size.width,
                                        toView.frame.size.height);
    }
    
    [containerView addSubview:toView];
    toView.frame = toViewStartFrame;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        if (self.presenting) {
            toView.frame = toViewFinalFrame;
        }
        else{
            fromView.frame = fromViewFinalFrame;
        }
        if (fromView.constraints.count) {
            [fromView layoutIfNeeded];
        }
        if (toView.constraints.count) {
            [toView layoutIfNeeded];
        }
    } completion:^(BOOL finished) {
        
        BOOL success = ![transitionContext transitionWasCancelled];
        if ((self.presenting && !success) || (!self.presenting && success)) {
            [toView removeFromSuperview];
        }
        
        [transitionContext completeTransition:success];
    }];
}

@end
