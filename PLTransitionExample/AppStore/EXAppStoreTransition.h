//
//  EXAppStoreTransition.h
//  PLTransitionExample
//
//  Created by 一维 on 2018/4/26.
//  Copyright © 2018年 一维. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PLTransition.h>
#import "EXAppStoreCardView.h"

@interface EXAppStoreTransition : NSObject<PLTransitionProtocol>
@property (nonatomic, strong) EXAppStoreCardView *cardView;
@property (nonatomic, assign) CGRect originCardViewFrame;
@end
