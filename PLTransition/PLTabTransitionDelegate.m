//
//  PLTabTransitionDelegate.m
//  PLTransition
//
//  Created by 一维 on 2018/5/2.
//

#import "PLTabTransitionDelegate.h"
#import "PLTransitionAgent.h"
#import "PLInteractiveTransitionAgent.h"
#import "PLTransitionProtocol.h"

@implementation PLTabTransitionDelegate
- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
     return self.transitionAgent;
}

- (id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return [self.interactiveTransitionAgent isInteractive] ? self.interactiveTransitionAgent : nil;
}
@end
