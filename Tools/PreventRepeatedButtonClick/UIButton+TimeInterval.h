//
//  UIButton+TimeInterval.h
//  CLS
//
//  Created by 周子龙 on 2018/12/28.
//  Copyright © 2018 apple. All rights reserved.
//

// 防止Button多次点击

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (TimeInterval)

/**
 点击时间间隔
 */
@property (nonatomic, assign) NSTimeInterval timeInterval;

@end

NS_ASSUME_NONNULL_END
