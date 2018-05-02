//
//  PLBaseTransitionDelegate.h
//  PLTransition
//
//  Created by 一维 on 2018/5/2.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PLTransitionAgent,PLInteractiveTransitionAgent;
@protocol PLTransitionProtocol;

@interface PLBaseTransitionDelegate : NSObject
- (instancetype)initWithTransition:(id<PLTransitionProtocol>)transition;
- (void)setupWithTransition:(id<PLTransitionProtocol>)transition;
@property(nonatomic,strong) NSArray<UIViewController *> *interactiveTransitionViewController;
@property (nonatomic, strong, readonly) PLTransitionAgent *transitionAgent;
@property (nonatomic, strong, readonly) PLInteractiveTransitionAgent *interactiveTransitionAgent;
@end
