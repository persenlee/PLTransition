//
//  EXAppStoreFeedCell.h
//  PLTransitionExample
//
//  Created by 一维 on 2018/4/26.
//  Copyright © 2018年 一维. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EXAppStoreCardView;
@interface EXAppStoreFeedCell : UICollectionViewCell
@property(nonatomic,strong) EXAppStoreCardView *cardView;
@property (nonatomic, copy) void (^didTapAction)(void);
@end
