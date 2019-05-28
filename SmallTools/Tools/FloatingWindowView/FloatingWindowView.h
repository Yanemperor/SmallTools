//
//  FloatingWindowView.h
//  CLS
//
//  Created by 周子龙 on 2018/10/16.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FloatingWindowView : UIImageView

+ (FloatingWindowView *)shareInstance;

- (void)viewController:(UIViewController *)vc;

- (void)isHidden:(BOOL)is;

@end

NS_ASSUME_NONNULL_END

