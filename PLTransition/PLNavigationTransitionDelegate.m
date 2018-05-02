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

@interface PLNavigationTransitionDelegate()
@property (nonatomic, strong) PLTransitionAgent *transitionAgent;
@property (nonatomic, strong) PLInteractiveTransitionAgent *interactiveTransitionAgent;
@end

@implementation PLNavigationTransitionDelegate

- (instancetype)init
{
    self = [super init];
    if (self) {
         _transitionAgent = [[PLTransitionAgent alloc] init];
    }
    return self;
}

- (instancetype)initWithTransition:(id<PLTransitionProtocol>)transition
{
    self = [self init];
    if (self) {
        [self setupWithTransition:transition];
    }
    return self;
}

- (void)setupWithTransition:(id<PLTransitionProtocol>)transition
{
    _transitionAgent.animator = transition;
    if ([transition respondsToSelector:@selector(isInteractive)] && [transition isInteractive]) {
        _interactiveTransitionAgent = [[PLInteractiveTransitionAgent alloc] init];
        _interactiveTransitionAgent.animator = transition;
    }
}

- (void)setInteractiveTransitionViewController:(NSArray<UIViewController *> *)interactiveTransitionViewController
{
    _interactiveTransitionViewController = interactiveTransitionViewController;
    for (UIViewController *viewController in interactiveTransitionViewController) {
        [self.interactiveTransitionAgent handleProgressForViewController:viewController];
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return self.transitionAgent;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
     return [self.interactiveTransitionAgent isInteractive] ? self.interactiveTransitionAgent : nil;
}
@end
