//
//  EXFlipTransition.m
//  PLTransitionExample
//
//  Created by 一维 on 2018/5/2.
//  Copyright © 2018年 一维. All rights reserved.
//

#import "EXFlipTransition.h"

@implementation EXFlipTransition
- (NSTimeInterval)duration
{
    return 1.0f;
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

    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.002;
    containerView.layer.sublayerTransform = transform;
    
    if (operation == PLTransitionEnter) {
        [containerView addSubview:toView];
    }
    
    if (operation == PLTransitionLeave) {
        [containerView insertSubview:toView belowSubview:fromView];
    }
    CGFloat factor =  operation == PLTransitionEnter ? 1 : -1;
    toView.layer.transform = CATransform3DMakeRotation(factor * M_PI_2, 0, 1, 0);
    
}

- (void)animateForOperation:(PLTransitionOperation)operation fromView:(UIView *)fromView toView:(UIView *)toView containerView:(UIView *)containerView
{
    CGFloat factor =  operation == PLTransitionEnter ? 1 : -1;
    
    [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
        fromView.layer.transform = CATransform3DMakeRotation(-factor * M_PI_2, 0, 1, 0);
    }];
    
    [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
        toView.layer.transform =  CATransform3DMakeRotation(0, 0, 1, 0);
    }];
}
@end
