//
//  PhotoBrowserTransition.m
//  WilliamProject
//
//  Created by WilliamChen on 16/6/12.
//  Copyright © 2016年 WilliamChen. All rights reserved.
//

#import "PhotoBrowserTransition.h"

@implementation PhotoBrowserTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    
    UIView *fromView;
    UIView *toView;
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    }
    else{
        fromView = fromVC.view;
        toView = toVC.view;
    }
    
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect toFrame = [transitionContext finalFrameForViewController:toVC];
    
    BOOL isPresenting = (toVC.presentingViewController == fromVC);
    if (isPresenting) {
        fromView.frame = fromFrame;
        toView.frame = self.transformRect;
    }
    else{
        fromView.frame = fromFrame;
        toView.frame = toFrame;
    }
    
    if (isPresenting) {
        [containerView addSubview:toView];
    }
    else{
        [containerView insertSubview:toView belowSubview:fromView];
    }
    
    NSTimeInterval animationDuration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:animationDuration animations:^{
        if (isPresenting) {
            toView.frame = toFrame;
        }
        else{
            fromView.frame = self.transformRect;
        }
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        if (wasCancelled) {
            [toView removeFromSuperview];
        }
        [transitionContext completeTransition:!wasCancelled];
    }];
    
}

@end
