//
//  PLPresentTransitionDelegate.h
//  PLTransition
//
//  Created by 一维 on 2018/4/25.
//  Copyright © 2018年 一维. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PLBaseTransitionDelegate.h"

@protocol PLTransitionProtocol;
@interface PLPresentTransitionDelegate : PLBaseTransitionDelegate<UIViewControllerTransitioningDelegate>
@end
