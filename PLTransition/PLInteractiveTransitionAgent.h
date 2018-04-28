//
//  PLInteractiveTransitionAgent.h
//  PLTransition
//
//  Created by 一维 on 2018/4/25.
//

#import <Foundation/Foundation.h>

@protocol PLTransitionProtocol;
@interface PLInteractiveTransitionAgent : UIPercentDrivenInteractiveTransition
@property (nonatomic, strong) id<PLTransitionProtocol> animator;
@property (nonatomic, assign, readonly,getter=isInteractive) BOOL interactive;
- (void)handleProgressForViewController:(UIViewController *)viewController;
@end
