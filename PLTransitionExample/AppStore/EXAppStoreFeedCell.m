//
//  EXAppStoreFeedCell.m
//  PLTransitionExample
//
//  Created by 一维 on 2018/4/26.
//  Copyright © 2018年 一维. All rights reserved.
//

#import "EXAppStoreFeedCell.h"
#import "EXAppStoreCardView.h"
#import <Masonry.h>

@interface EXAppStoreFeedCell()

@end

@implementation EXAppStoreFeedCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (EXAppStoreCardView *)cardView
{
    if (!_cardView) {
        _cardView = [[EXAppStoreCardView alloc] init];
        _cardView.layer.cornerRadius = 12;
        _cardView.layer.masksToBounds = YES;
//        _cardView.layer.shadowColor =
    }
    return _cardView;
}

- (void)setupSubviews
{
    [self.contentView addSubview:self.cardView];
    [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.top.bottom.mas_equalTo(0);
    }];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.cardView addGestureRecognizer:tapGR];
    UILongPressGestureRecognizer *pressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressAction:)];
    pressGR.minimumPressDuration = 0.15;
    [self.cardView addGestureRecognizer:pressGR];
    [tapGR requireGestureRecognizerToFail:pressGR];
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR
{
    if (tapGR.state == UIGestureRecognizerStateEnded) {
        [self cardViewPressAnimation];
    }
}
- (void)pressAction:(UILongPressGestureRecognizer *)gr
{
    if (gr.state == UIGestureRecognizerStateBegan) {
        [UIView animateWithDuration:0.15
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
            self.cardView.transform = CGAffineTransformMakeScale(0.95, 0.95);
                       } completion:^(BOOL finished) {
            
        }];
    } else if(gr.state == UIGestureRecognizerStateEnded
              || gr.state ==  UIGestureRecognizerStateCancelled
              || gr.state == UIGestureRecognizerStateFailed){
        [UIView animateWithDuration:0.15
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
            self.cardView.transform = CGAffineTransformIdentity;
                       } completion:^(BOOL finished) {
            
        }];
        self.didTapAction();
    }
}


- (void)cardViewPressAnimation
{
    [UIView animateWithDuration:0.15
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.cardView.transform = CGAffineTransformMakeScale(0.95, 0.95);
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                             self.cardView.transform = CGAffineTransformIdentity;
                         } completion:^(BOOL finished) {
                             self.didTapAction();
                         }];
                     }];
}
@end
