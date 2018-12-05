//
//  ApiConfigsUtil.h
//  CLS
//
//  Created by 周子龙 on 2018/5/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ApiConfig : NSObject

@property (nonatomic, copy) NSString *baseURL;
@property (nonatomic, copy) NSString *versionUpdateURL;
@property (nonatomic, copy) NSString *baiduMapKey;
@property (nonatomic, copy) NSString *youMenSdkCode;
@property (nonatomic, copy) NSString *buglySdkKey;
@property (nonatomic, copy) NSString *apnsCername;
@property (nonatomic, copy) NSString *env;
@property (nonatomic, copy) NSString *envKey;

@end

@interface ApiConfigsUtil : NSObject

@property (nonatomic, strong) ApiConfig *apiConfig;
@property (nonatomic, strong) NSMutableArray *netArray;
@property (nonatomic, weak) UIViewController *baseVc;

+ (ApiConfigsUtil *)shareApiConfigsUtil;

- (ApiConfig *)apiConfig;

- (void)registerApiNetChangeView:(UIViewController *)vc;

@end
