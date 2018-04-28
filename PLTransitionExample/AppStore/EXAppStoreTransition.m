//
//  EXAppStoreTransition.m
//  PLTransitionExample
//
//  Created by 一维 on 2018/4/26.
//  Copyright © 2018年 一维. All rights reserved.
//

#import "EXAppStoreTransition.h"
#import "EXAppStoreArticleViewController.h"
#import <Masonry.h>

@interface EXAppStoreTransition()
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

@implementation EXAppStoreTransition

- (NSTimeInterval)duration
{
    return 0.85f;
}

- (PLTransitionStyle)transitionStyle
{
    return PLTransitionStylePresent;
}

- (void)transitionCompleted:(BOOL)completed
{
//    [self.cardView removeFromSuperview];
    if (!completed) {
        
    }
}

- (void)layoutForOperation:(PLTransitionOperation)operation fromView:(UIView *)fromView toView:(UIView *)toView containerView:(UIView *)containerView
{
    _originToViewFrame = toView.frame;
    _originFromViewFrame = fromView.frame;
    
    if (operation == PLTransitionEnter) {

        toView.frame = self.originCardViewFrame;
        [containerView addSubview:toView];
        toView.layer.cornerRadius = 16.f;
        toView.layer.masksToBounds = YES;
        EXAppStoreArticleViewController *articleVC = (EXAppStoreArticleViewController *)[toView nextResponder];
        [articleVC animateForTransition:NO];
    }
    
    if (operation == PLTransitionLeave) {

    }
    
}

- (void)animateForOperation:(PLTransitionOperation)operation fromView:(UIView *)fromView toView:(UIView *)toView containerView:(UIView *)containerView
{
    if (operation == PLTransitionEnter) {
        EXAppStoreArticleViewController *articleVC =  (EXAppStoreArticleViewController *)[toView nextResponder];
        [UIView animateWithDuration:[self duration] delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            toView.frame = self->_originToViewFrame;
            toView.layer.cornerRadius = 0.f;
            [articleVC animateForTransition:YES];
        } completion:^(BOOL finished) {
            
        }];
        
    }
    
    if (operation == PLTransitionLeave) {
//         [UIView animateWithDuration:[self duration] delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            fromView.frame = self.originCardViewFrame;
            fromView.layer.cornerRadius = 16.f;
            EXAppStoreArticleViewController *articleVC = (EXAppStoreArticleViewController *)[fromView nextResponder];
             [articleVC animateForTransition:NO];
//         } completion:^(BOOL finished) {
//             
//         }];
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
            _startPoint = point;
            self.progressBlock(PLInteractiveTransitionStarted);
            [self.viewController dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGFloat offsetX = point.x - _startPoint.x;
            _progress = ABS(offsetX) /  CGRectGetWidth(view.bounds);
            if (_progress > 0.63 && _progress <= 0.7) {
                _progress = 0.63;
            } else if (_progress > 0.7) {
                _progress = 1;
                self.progressBlock(PLInteractiveTransitionFinished);
            }
            self.progressBlock(PLInteractiveTransitionUpdating);
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            CGFloat offsetX = point.x - _startPoint.x;
            CGFloat progress = ABS(offsetX) /  CGRectGetWidth(view.bounds);
            if (progress >= 0.7) {
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
