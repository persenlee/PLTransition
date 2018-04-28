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
    return 0.35f;
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

//        toView.frame = self.originCardViewFrame;
        [containerView addSubview:toView];
        
        self.cardView = [[EXAppStoreCardView alloc] init];
        self.cardView.layer.cornerRadius = 16;
//        self.cardView.frame = self.originCardViewFrame;
        [containerView addSubview:self.cardView];
        [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.originCardViewFrame.origin.x);
            make.right.mas_equalTo(self.originCardViewFrame.origin.y);
            make.size.mas_equalTo(self.originCardViewFrame.size);
        }];
    }
    
    if (operation == PLTransitionLeave) {

    }
    
}

- (void)animateForOperation:(PLTransitionOperation)operation fromView:(UIView *)fromView toView:(UIView *)toView containerView:(UIView *)containerView
{
    if (operation == PLTransitionEnter) {
        self.cardView.layer.cornerRadius = 0;
//        self.cardView.frame = CGRectMake(0, 0, CGRectGetWidth(_originToViewFrame), 520);
        [self.cardView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.width.mas_equalTo(CGRectGetWidth(self->_originToViewFrame));
            make.height.mas_equalTo(520);
        }];
//        toView.frame = _originToViewFrame;
        
        [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self.cardView layoutIfNeeded];
        } completion:^(BOOL finished) {
            EXAppStoreArticleViewController *toViewController = (EXAppStoreArticleViewController *)[toView nextResponder];
            [toViewController addCardView:self.cardView];
        }];
        
    }
    
    if (operation == PLTransitionLeave) {
        fromView.frame = self.originCardViewFrame;
    }
    
}

- (BOOL)isInteractive
{
    return YES;
}

//- (void)addGestureForViewController:(UIViewController *)viewController progressBlock:(InteractiveTransitionProgressBlock)progressBlock
//{
//    self.viewController = viewController;
//    UIView *view = viewController.view;
//    if(![view.gestureRecognizers containsObject:self.panGR]) {
//        [view addGestureRecognizer:self.panGR];
//    }
//    self.progressBlock = progressBlock;
//}



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
            if (_progress > 0.4 && _progress <= 0.6) {
                _progress = 0.4;
            } else if (_progress > 0.6) {
                _progress = 1;
            }
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
