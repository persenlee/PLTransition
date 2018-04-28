//
//  EXHomeTransition.m
//  PLTransitionExample
//
//  Created by 一维 on 2018/4/25.
//  Copyright © 2018年 一维. All rights reserved.
//

#import "EXHomeTransition.h"
#import <UIKit/UIKit.h>
@interface EXHomeTransition()
{
    CGRect _originFromViewFrame;
    CGRect _originToViewFrame;
    CGPoint _startPoint;
    CGFloat _progress;
}
@property (nonatomic, strong)   UIPanGestureRecognizer *panGR;
@property (nonatomic, copy)     InteractiveTransitionProgressBlock progressBlock;
@property (nonatomic, strong)   UIViewController *viewController;
@end

@implementation EXHomeTransition
- (NSTimeInterval)duration
{
    return 0.32f;
}

- (PLTransitionStyle)transitionStyle
{
    return PLTransitionStylePush;
}

- (void)transitionCompleted:(BOOL)completed
{
    if (!completed) {
        
    }
}

- (void)layoutForOperation:(PLTransitionOperation)operation fromView:(UIView *)fromView toView:(UIView *)toView containerView:(UIView *)containerView
{
    _originToViewFrame = toView.frame;
    _originFromViewFrame = fromView.frame;
    
    if (operation == PLTransitionEnter) {
        toView.frame = CGRectMake(CGRectGetMidX(_originToViewFrame), CGRectGetMidY(_originToViewFrame), 0, 0);
        toView.alpha = 0;
        [containerView addSubview:toView];
    }
    
    if (operation == PLTransitionLeave) {
        [containerView insertSubview:toView belowSubview:fromView];
    }
    
}

- (void)animateForOperation:(PLTransitionOperation)operation fromView:(UIView *)fromView toView:(UIView *)toView containerView:(UIView *)containerView
{
    if (operation == PLTransitionEnter) {
        toView.alpha = 1;
        toView.frame = _originToViewFrame;
    }
    
    if (operation == PLTransitionLeave) {
        CGRect frame =  fromView.frame;
        frame.origin.x = CGRectGetMaxX(frame);
        fromView.frame = frame;
    }
}

- (BOOL)isInteractive
{
    return YES;
}

- (void)addGestureForViewController:(UIViewController *)viewController progressBlock:(InteractiveTransitionProgressBlock)progressBlock
{
    self.viewController = viewController;
    UIView *view = viewController.view;
    if(![view.gestureRecognizers containsObject:self.panGR]) {
        [view addGestureRecognizer:self.panGR];
    }
    self.progressBlock = progressBlock;
}



- (CGFloat)progressUpdatingInteractiveTransition
{
    return _progress;
} 

- (UIPanGestureRecognizer *)panGR
{
    if (!_panGR) {
        _panGR = [[UIPanGestureRecognizer alloc] init];
        [_panGR addTarget:self action:@selector(swipeBackAction:)];
    }
    return _panGR;
}

- (void)swipeBackAction:(UIPanGestureRecognizer *)gr
{
    UIView *view = self.viewController.view;

    CGPoint point =  [gr locationInView:view.superview];
    CGPoint velocity = [gr velocityInView:view];
    
    switch (gr.state) {
        case UIGestureRecognizerStateBegan:
        {
            if (point.x > CGRectGetMidX(view.bounds) || velocity.x < 0) {
                return;
            }
            _startPoint = point;
            self.progressBlock(PLInteractiveTransitionStarted);
            [self.viewController.navigationController popViewControllerAnimated:YES];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGFloat offsetX = point.x - _startPoint.x;
            _progress = offsetX /  CGRectGetWidth(view.bounds);
            _progress = MIN(MAX(0, _progress),0.99);
            self.progressBlock(PLInteractiveTransitionUpdating);
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            CGFloat offsetX = point.x - _startPoint.x;
            CGFloat halfWidth = CGRectGetWidth(view.bounds) / 2;
            CGFloat progress = offsetX / halfWidth;
            if (progress >= 1) {
                _progress = 1;
                self.progressBlock(PLInteractiveTransitionFinished);
            } else {
                self.progressBlock(PLInteractiveTransitionCancelled);
            }
        }
            break;
        default:
        {
            self.progressBlock(PLInteractiveTransitionCancelled);
        }
            break;
    }
}
@end
