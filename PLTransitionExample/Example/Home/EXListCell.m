//
//  EXListCell.m
//  PLTransition
//
//  Created by 一维 on 2018/4/25.
//  Copyright © 2018年 一维. All rights reserved.
//

#import "EXListCell.h"
#import <Masonry.h>

@interface EXListCell()
@property(nonatomic,strong) UILabel *titleLabel;
@end

@implementation EXListCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24);
        make.centerY.mas_equalTo(0);
    }];
}

- (void)setupWithTitle:(NSString *)title
{
    self.titleLabel.text = title;
}
@end
