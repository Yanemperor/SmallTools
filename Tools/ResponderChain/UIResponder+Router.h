//
//  UIResponder+Router.h
//  CLS
//
//  Created by 周子龙 on 2018/12/10.
//  Copyright © 2018 apple. All rights reserved.
//

/*
// 发送事件
[self routerEventWithName:kBLGoodsDetailBottomBarEventTappedBuyButton userInfo:nil];

// 响应事件时
 - (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
 {
 NSInvocation *invocation = self.eventStrategy[eventName];
 [invocation setArgument:&userInfo atIndex:2];
 [invocation invoke];
 
 // 如果需要让事件继续往上传递，则调用下面的语句
 // [super routerEventWithName:eventName userInfo:userInfo];
 }
*/

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;

@end

NS_ASSUME_NONNULL_END
