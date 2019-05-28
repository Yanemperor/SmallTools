//
//  UIResponder+Router.m
//  CLS
//
//  Created by 周子龙 on 2018/12/10.
//  Copyright © 2018 apple. All rights reserved.
//

#import "UIResponder+Router.h"

@implementation UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}

@end
