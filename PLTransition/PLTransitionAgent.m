//
//  PLTransitionAgent.m
//  PLTransition
//
//  Created by 一维 on 2018/4/25.
//  Copyright © 2018年 一维. All rights reserved.
//

#import "PLTransitionAgent.h"
#import "PLTransitionProtocol.h"
#import "PLTransitionDefine.h"

static NSTimeInterval const kDefaultTransitionDuration = 0.25f;

@implementation PLTransitionAgent
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if ([self.animator respondsToSelector:@selector(duration)]) {
        return [self.animator duration];
    } else {
        return kDefaultTransitionDuration;
    }
    
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{

    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    UIView *fromView;
    UIView *toView;
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        if (@available(iOS 8.0, *)) {
            fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        }
        if (@available(iOS 8.0, *)) {
            toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        }
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    
    BOOL isEnter = NO;
    if ([self.animator transitionStyle] == PLTransitionStylePresent) {
        isEnter = (toViewController.presentingViewController == fromViewController);
    } else if ([self.animator transitionStyle] == PLTransitionStylePush) {
        NSInteger fromIndex = [fromViewController.navigationController.viewControllers indexOfObject:fromViewController];
        NSInteger toIndex = [toViewController.navigationController.viewControllers indexOfObject:toViewController];
        isEnter = toIndex > fromIndex;
    }
    
    PLTransitionOperation operation = isEnter ? PLTransitionEnter : PLTransitionLeave;
    
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect toFrame = [transitionContext finalFrameForViewController:toViewController];
    
    fromView.frame = fromFrame;
    toView.frame = toFrame;
    
    
    if ([self.animator respondsToSelector:@selector(layoutForOperation:fromView:toView:containerView:)])
    {
        [self.animator layoutForOperation:operation
                                 fromView:fromView
                                   toView:toView
                            containerView:containerView];
    }
   
    if ([self.animator respondsToSelector:@selector(animateForOperation:fromView:toView:containerView:)])
    {
        NSTimeInterval duration = [self transitionDuration:transitionContext];
        [UIView animateKeyframesWithDuration:duration
                                       delay:0
                                     options:UIViewKeyframeAnimationOptionLayoutSubviews
                                  animations:^{
                                      [self.animator animateForOperation:operation
                                                                fromView:fromView
                                                                  toView:toView
                                                           containerView:containerView];
                                }
                                  completion:^(BOOL finished) {
                                      BOOL wasCancelled = [transitionContext transitionWasCancelled];
                                      [transitionContext completeTransition:!wasCancelled];
    }];
        
    }
    
}


//- (id<UIViewImplicitlyAnimating>)interruptibleAnimatorForTransition:(id<UIViewControllerContextTransitioning>)transitionContext
//{
//    return nil;
//}

- (void)animationEnded:(BOOL)transitionCompleted
{
    if ([self.animator respondsToSelector:@selector(transitionCompleted:)]) {
        [self.animator transitionCompleted:transitionCompleted];
    }
}
@end
