//
//  EXAppStoreCardView.m
//  PLTransitionExample
//
//  Created by 一维 on 2018/4/26.
//  Copyright © 2018年 一维. All rights reserved.
//

#import "EXAppStoreCardView.h"
#import <Masonry.h>

@interface EXAppStoreCardView()
@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, strong) UILabel *cardTitleLabel;
@property (nonatomic, strong) UILabel *appTitleLabel;
@property (nonatomic, strong) UILabel *appKindLabel;
@property (nonatomic, strong) UIImageView *appIconView;
@property (nonatomic, strong) UIButton *buyButton;
@property (nonatomic, strong) UIView *bottomContentView;
@end

@implementation EXAppStoreCardView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    [self addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [self addSubview:self.bottomContentView];
    [self.bottomContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(100);
    }];
    
    [self addSubview:self.cardTitleLabel];
    [self.cardTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(36);
        make.bottom.equalTo(self.bottomContentView.mas_top).offset(-36);
    }];
    [self setupBottomContentView];
}

- (void)setupBottomContentView
{
    [self.bottomContentView addSubview:self.buyButton];
    [self.buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-36);
        make.size.mas_equalTo(CGSizeMake(80, 32));
    }];
    
    [self.bottomContentView addSubview:self.appIconView];
    [self.appIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(36);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [self.bottomContentView addSubview:self.appTitleLabel];
    [self.appTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomContentView.mas_centerY).offset(-2);
        make.left.equalTo(self.appIconView.mas_right).offset(12);
        make.right.equalTo(self.buyButton.mas_left).offset(-12);
    }];
    
    [self.bottomContentView addSubview:self.appKindLabel];
    [self.appKindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomContentView.mas_centerY).offset(2);
        make.left.equalTo(self.appIconView.mas_right).offset(12);
    }];
    
  
}

- (UIImageView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIImageView alloc] init];
        _backgroundView.image = [UIImage imageNamed:@"background"];
    }
    return _backgroundView;
}

- (UIImageView *)appIconView
{
    if (!_appIconView) {
        _appIconView = [[UIImageView alloc] init];
        _appIconView.image = [UIImage imageNamed:@"game"];
    }
    return _appIconView;
}

- (UILabel *)cardTitleLabel
{
    if (!_cardTitleLabel) {
        _cardTitleLabel = [[UILabel alloc] init];
        _cardTitleLabel.font = [UIFont systemFontOfSize:36];
        _cardTitleLabel.textColor = [UIColor whiteColor];
        _cardTitleLabel.text = @"今日游戏";
    }
    return _cardTitleLabel;
}

- (UILabel *)appKindLabel
{
    if (!_appKindLabel) {
        _appKindLabel = [[UILabel alloc] init];
        _appKindLabel.font = [UIFont systemFontOfSize:14];
        _appKindLabel.textColor = [UIColor whiteColor];
        _appKindLabel.text = @"冒险游戏";
    }
    return _appKindLabel;
}

- (UILabel *)appTitleLabel
{
    if (!_appTitleLabel) {
        _appTitleLabel = [[UILabel alloc] init];
        _appTitleLabel.font = [UIFont systemFontOfSize:14];
        _appTitleLabel.textColor = [UIColor whiteColor];
        _appTitleLabel.text = @"Legendary warrior";
    }
    return _appTitleLabel;
}

- (UIButton *)buyButton
{
    if (!_buyButton) {
        _buyButton = [[UIButton alloc] init];
        _buyButton.layer.cornerRadius = 16;
        _buyButton.layer.masksToBounds = YES;
        _buyButton.backgroundColor = [UIColor whiteColor];
        [_buyButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_buyButton setTitle:@"获取" forState:UIControlStateNormal];
    }
    return _buyButton;
}

- (UIView *)bottomContentView
{
    if (!_bottomContentView) {
        _bottomContentView = [UIView new];
        _bottomContentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
    return _bottomContentView;
}
@end
