//
//  PLTransitionProtocol.h
//  PLTransition
//
//  Created by 一维 on 2018/4/25.
//  Copyright © 2018年 一维. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,PLTransitionStyle)
{
    PLTransitionStylePresent,
    PLTransitionStylePush
};

typedef NS_ENUM(NSInteger,PLTransitionOperation)
{
    PLTransitionEnter = 0,
    PLTransitionLeave = 1
};

typedef NS_ENUM(NSInteger,PLInteractiveTransitionStatus)
{
    PLInteractiveTransitionStarted,
    PLInteractiveTransitionUpdating,
    PLInteractiveTransitionFinished,
    PLInteractiveTransitionCancelled
};

typedef void (^InteractiveTransitionProgressBlock) (PLInteractiveTransitionStatus status);

@protocol PLTransitionProtocol <NSObject>

@required
- (PLTransitionStyle)transitionStyle;

@optional
- (NSTimeInterval)duration;

- (void)layoutForOperation:(PLTransitionOperation)operation
                  fromView:(UIView *)fromView
                    toView:(UIView *)toView
             containerView:(UIView *)containerView;

- (void)animateForOperation:(PLTransitionOperation)operation
                   fromView:(UIView *)fromView
                     toView:(UIView *)toView
              containerView:(UIView *)containerView;

- (void)transitionCompleted:(BOOL)completed;

- (BOOL)isInteractive;

- (CGFloat)progressUpdatingInteractiveTransition;

- (void)addGestureForViewController:(UIViewController *)viewController
                 progressBlock:(InteractiveTransitionProgressBlock)progressBlock;

- (UIViewAnimationCurve)interactiveCompletionCurve;

- (CGFloat)interactiveCompletionSpeed;
@end
