//
//  CustomAnimationTransition.m
//  WilliamProject
//
//  Created by WilliamChen on 16/2/16.
//  Copyright © 2016年 WilliamChen. All rights reserved.
//

#import "CustomAnimationTransition.h"

@implementation CustomAnimationTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    UIView *fromView;
    UIView *toView;
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    }else{
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    
    fromView.frame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect orFrame = [transitionContext finalFrameForViewController:toViewController];
    CGRect anFrame = CGRectOffset(orFrame, 0, orFrame.size.height);
    toView.frame = anFrame;
    
    fromView.alpha = 1.0f;
    toView.alpha = 0.0f;
    
    [containerView addSubview:toView];
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:transitionDuration animations:^{
        fromView.alpha = 0.0f;
        toView.alpha = 1.0f;
        toView.frame = orFrame;
    } completion:^(BOOL finished) {
        BOOL wasCanceled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCanceled];
    }];
}

@end
