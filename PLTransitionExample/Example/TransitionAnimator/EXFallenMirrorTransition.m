//
//  EXFallenMirrorTransition.m
//  PLTransitionExample
//
//  Created by 一维 on 2018/5/2.
//  Copyright © 2018年 一维. All rights reserved.
//

#import "EXFallenMirrorTransition.h"

static const NSInteger kRowsNumber = 5;
static const NSInteger kColumnsNumber = 5;

@interface EXFallenMirrorTransition()
@property (nonatomic, strong) NSMutableArray *mirrorViews;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@end

@implementation EXFallenMirrorTransition
- (instancetype)init
{
    self = [super init];
    if (self) {
        _mirrorViews = [NSMutableArray arrayWithCapacity:kColumnsNumber * kRowsNumber];
    }
    return self;
}

- (NSTimeInterval)duration
{
    return 2.0f;
}

- (PLTransitionStyle)transitionStyle
{
    return PLTransitionStylePush;
}

- (void)transitionCompleted:(BOOL)completed
{
    if (completed) {
        for (UIView *view in self.mirrorViews) {
            [view removeFromSuperview];
        }
        [self.mirrorViews removeAllObjects];
    }
}

- (void)layoutForOperation:(PLTransitionOperation)operation fromView:(UIView *)fromView toView:(UIView *)toView containerView:(UIView *)containerView
{
    
    [containerView addSubview:toView];
    
    CGFloat width = CGRectGetWidth(fromView.frame) / kColumnsNumber;
    CGFloat height = CGRectGetHeight(fromView.frame) / kRowsNumber;
    
    for (NSInteger i = 0; i < kRowsNumber; i++) {
        for (NSInteger j= 0; j < kColumnsNumber; j++) {
            CGRect frame = CGRectMake(width * j, height * i, width, height);
            UIView *view = [fromView resizableSnapshotViewFromRect:frame
                                                afterScreenUpdates:NO
                                                     withCapInsets:UIEdgeInsetsZero];
            view.frame = frame;
            CGFloat angle = (arc4random() % 4) / 10.f;
            view.transform = CGAffineTransformMakeRotation(angle);
            [self.mirrorViews addObject:view];
            [containerView addSubview:view];
        }
    }

    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:containerView];
    UIDynamicBehavior *containerBehavior = [[UIDynamicBehavior alloc] init];
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:self.mirrorViews];
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:self.mirrorViews];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    collisionBehavior.collisionMode = UICollisionBehaviorModeBoundaries;
    [containerBehavior addChildBehavior:gravityBehavior];
    [containerBehavior addChildBehavior:collisionBehavior];
    
    for (UIView *view in self.mirrorViews) {
            UIDynamicItemBehavior *itemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:@[view]];
            itemBehaviour.elasticity = (rand() % 5) / 8.0;
            itemBehaviour.density = (rand() % 5 / 3.0);
            [containerBehavior addChildBehavior:itemBehaviour];
    }
    [self.animator addBehavior:containerBehavior];
    
    [fromView removeFromSuperview];

}

- (void)animateForOperation:(PLTransitionOperation)operation fromView:(UIView *)fromView toView:(UIView *)toView containerView:(UIView *)containerView
{
    for (UIView *view in self.mirrorViews) {
        view.alpha = 0;
    }
}


@end
