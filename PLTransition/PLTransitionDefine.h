//
//  PLTransitionDefine.h
//  PLTransition
//
//  Created by 一维 on 2018/4/25.
//

#ifndef PLTransitionDefine_h
#define PLTransitionDefine_h

#define WS(weakSelf) __weak __typeof(&*self) weakSelf = self;
#define SS(strongSelf) __strong __typeof(weakSelf) strongSelf = weakSelf;



#endif /* PLTransitionDefine_h */
