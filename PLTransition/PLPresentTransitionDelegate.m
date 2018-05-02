//
//  PLPresentTransitionDelegate.m
//  PLTransition
//
//  Created by 一维 on 2018/4/25.
//  Copyright © 2018年 一维. All rights reserved.
//

#import "PLPresentTransitionDelegate.h"
#import "PLTransitionAgent.h"
#import "PLInteractiveTransitionAgent.h"
#import "PLTransitionProtocol.h"

@interface PLPresentTransitionDelegate()
@property (nonatomic, strong) PLTransitionAgent *transitionAgent;
@property (nonatomic, strong) PLInteractiveTransitionAgent *interactiveTransitionAgent;
@end

@implementation PLPresentTransitionDelegate
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

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self.transitionAgent;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self.transitionAgent;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return self.interactiveTransitionAgent;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return [self.interactiveTransitionAgent isInteractive] ? self.interactiveTransitionAgent : nil;
}
@end
