//
//  PLNavigationTransitionDelegate.h
//  PLTransition
//
//  Created by 一维 on 2018/4/25.
//  Copyright © 2018年 一维. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol PLTransitionProtocol;
@interface PLNavigationTransitionDelegate : NSObject<UINavigationControllerDelegate>
- (instancetype)initWithTransition:(id<PLTransitionProtocol>)transition;
- (void)setupWithTransition:(id<PLTransitionProtocol>)transition;
@property(nonatomic,strong) NSArray<UIViewController *> *interactiveTransitionViewController;
@end
