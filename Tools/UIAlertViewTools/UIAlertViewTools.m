//
//  UIAlertViewTools.m
//  SmallTools
//
//  Created by 周子龙 on 2018/12/24.
//  Copyright © 2018 Zhou. All rights reserved.
//

#import "UIAlertViewTools.h"

@implementation UIAlertViewTools

+ (void)alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles withBlock:(void(^)(NSInteger index))block {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // 取消
        block(0);
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:otherButtonTitles style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 确定
        block(1);
    }]];
    
    [[self getCurrentVC] presentViewController:alertController animated:YES completion:nil];
}

+ (void)alertSheetWithTitle:(NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle otherButtonTitles:(nullable NSArray *)otherButtonTitles withBlock:(void (^)(NSInteger index))block {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       // 取消
        block(0);
    }]];
    
    for (int i = 0; i < otherButtonTitles.count; i++) {
        NSString *otherButtonTitle = otherButtonTitles[i];
        [alertController addAction:[UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // other
            block(i + 1);
        }]];
    }
    [alertController addAction:[UIAlertAction actionWithTitle:destructiveButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        // 删除
        block(-1);
    }]];
    [[self getCurrentVC] presentViewController:alertController animated:YES completion:nil];
}

+ (UIViewController *)getCurrentVC {
    UIViewController *currentvc = [self getPushCurrentVC];
    if ([currentvc isKindOfClass:[UINavigationController class]] || !currentvc) {
        currentvc = [self getPresentedViewController];
    }
    return currentvc;
}

// 获取当前屏幕显示的viewcontroller
+ (UIViewController *)getPushCurrentVC {
    UIViewController *result = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else{
        result = window.rootViewController;
    }
    return result;
}

// 获取当前屏幕中present出来的viewcontroller
+ (UIViewController *)getPresentedViewController {
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

@end
