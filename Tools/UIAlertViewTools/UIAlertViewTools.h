//
//  UIAlertViewTools.h
//  SmallTools
//
//  Created by 周子龙 on 2018/12/24.
//  Copyright © 2018 Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertViewTools : NSObject

+ (void)alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles withBlock:(void(^)(NSInteger index))block;

+ (void)alertSheetWithTitle:(NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle otherButtonTitles:(nullable NSArray *)otherButtonTitles withBlock:(void (^)(NSInteger index))block;
@end

NS_ASSUME_NONNULL_END
