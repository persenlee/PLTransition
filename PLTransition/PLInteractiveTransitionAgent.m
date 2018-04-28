//
//  PLInteractiveTransitionAgent.m
//  PLTransition
//
//  Created by 一维 on 2018/4/25.
//

#import "PLInteractiveTransitionAgent.h"
#import "PLTransitionProtocol.h"
#import "PLTransitionDefine.h"

@interface PLInteractiveTransitionAgent()
@property (nonatomic, assign, getter=isInteractive) BOOL interactive;
@end

@implementation PLInteractiveTransitionAgent

- (void)handleProgressForViewController:(UIViewController *)viewController
{
    if ([self.animator respondsToSelector:@selector(addGestureForViewController:progressBlock:)]) {
        WS(weakSelf)
        [self.animator addGestureForViewController:viewController
                                     progressBlock:^(PLInteractiveTransitionStatus status)
         {
             SS(strongSelf)
             switch (status) {
                 case PLInteractiveTransitionStarted:
                 {
                     strongSelf.interactive = YES;
                 }
                     break;
                 case PLInteractiveTransitionUpdating:
                 {
                     CGFloat progress = [strongSelf.animator progressUpdatingInteractiveTransition];
                     [strongSelf updateInteractiveTransition:progress];
                 }
                     break;
                 case PLInteractiveTransitionFinished:
                 {
                     [strongSelf finishInteractiveTransition];
                     strongSelf.interactive = NO;
                 }
                     break;
                 case PLInteractiveTransitionCancelled:
                 {
                     [strongSelf cancelInteractiveTransition];
                     strongSelf.interactive = NO;
                 }
                     break;
                 default:
                     break;
             }
         }];
    }
}

//- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext
//{
//}

- (BOOL)wantsInteractiveStart
{
    return [super wantsInteractiveStart];
}

- (UIViewAnimationCurve)completionCurve
{
    if ([self.animator respondsToSelector:@selector(interactiveCompletionCurve)]) {
        return [self.animator interactiveCompletionCurve];
    } else {
        return [super completionCurve];
    }
}

- (CGFloat)completionSpeed
{
    if ([self.animator respondsToSelector:@selector(interactiveCompletionSpeed)]) {
        return [self.animator interactiveCompletionSpeed];
    } else {
        return [super completionSpeed];
    }
}
@end
