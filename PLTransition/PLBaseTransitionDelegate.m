//
//  PLBaseTransitionDelegate.m
//  PLTransition
//
//  Created by 一维 on 2018/5/2.
//

#import "PLBaseTransitionDelegate.h"
#import "PLTransitionAgent.h"
#import "PLInteractiveTransitionAgent.h"
#import "PLTransitionProtocol.h"

@interface PLBaseTransitionDelegate()
@property (nonatomic, strong) PLTransitionAgent *transitionAgent;
@property (nonatomic, strong) PLInteractiveTransitionAgent *interactiveTransitionAgent;
@end

@implementation PLBaseTransitionDelegate
- (instancetype)init
{
    self = [super init];
    if (self) {
        _transitionAgent = [[PLTransitionAgent alloc] init];
    }
    return self;
}

- (instancetype)initWithTransition:(id<PLTransitionProtocol>)transition
{
    self = [self init];
    if (self) {
        [self setupWithTransition:transition];
    }
    return self;
}

- (void)setupWithTransition:(id<PLTransitionProtocol>)transition
{
    _transitionAgent.animator = transition;
    if ([transition respondsToSelector:@selector(isInteractive)] && [transition isInteractive]) {
        _interactiveTransitionAgent = [[PLInteractiveTransitionAgent alloc] init];
        _interactiveTransitionAgent.animator = transition;
    }
}

- (void)setInteractiveTransitionViewController:(NSArray<UIViewController *> *)interactiveTransitionViewController
{
    _interactiveTransitionViewController = interactiveTransitionViewController;
    for (UIViewController *viewController in interactiveTransitionViewController) {
        [self.interactiveTransitionAgent handleProgressForViewController:viewController];
    }
}
@end
