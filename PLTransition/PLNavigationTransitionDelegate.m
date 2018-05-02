//
//  PLNavigationTransitionDelegate.m
//  PLTransition
//
//  Created by 一维 on 2018/4/25.
//  Copyright © 2018年 一维. All rights reserved.
//

#import "PLNavigationTransitionDelegate.h"
#import "PLTransitionAgent.h"
#import "PLInteractiveTransitionAgent.h"
#import "PLTransitionProtocol.h"


@implementation PLNavigationTransitionDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return self.transitionAgent;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
     return [self.interactiveTransitionAgent isInteractive] ? self.interactiveTransitionAgent : nil;
}
@end
