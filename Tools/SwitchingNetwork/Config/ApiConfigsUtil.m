//
//  ApiConfigsUtil.m
//  CLS
//
//  Created by 周子龙 on 2018/5/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ApiConfigsUtil.h"

@implementation ApiConfig

- (id)mutableCopyWithZone:(NSZone *)zone {
    ApiConfig *config = [[ApiConfig allocWithZone:zone] init];
    config.baseURL = self.baseURL;
    config.versionUpdateURL = self.versionUpdateURL;
    config.baiduMapKey = self.baiduMapKey;
    config.youMenSdkCode = self.youMenSdkCode;
    config.buglySdkKey = self.buglySdkKey;
    config.env = self.env;
    config.envKey = self.envKey;
    return config;
}

@end

@implementation ApiConfigsUtil

+ (ApiConfigsUtil *)shareApiConfigsUtil {
    static ApiConfigsUtil *apiConfigsUtil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        apiConfigsUtil = [[self alloc] init];
        NSInteger accessTag = [[NSUserDefaults standardUserDefaults] integerForKey:@"accessTag"];
        apiConfigsUtil.netArray = [NSMutableArray array];
        [apiConfigsUtil getDataFromJSONWithIndex:accessTag];
    });
    return apiConfigsUtil;
}

-(void)setApiConfigIndex:(NSInteger)mode{
    [[NSUserDefaults standardUserDefaults] setInteger:mode forKey:@"accessTag"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self getDataFromJSONWithIndex:mode];
}

-(void)getDataFromJSONWithIndex:(NSInteger)index{
    id object = [[NSUserDefaults standardUserDefaults] objectForKey:@"apiConfig"];
    [self.netArray removeAllObjects];
    if (object) {
        NSMutableArray *tempArray =  [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"apiConfig"]];
        for (NSDictionary *dic in tempArray) {
            // 可以用其他解析器代替 我使用的是YYModel
            ApiConfig *model = [ApiConfig yy_modelWithDictionary:dic];
            [self.netArray addObject:model];
        }
    }else{
        NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"apiConfig" ofType:@"json"];
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:dataPath];
        NSError *error;
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error]];
        for (NSDictionary *dic in tempArray) {
            // 可以用其他解析器代替 我使用的是YYModel
            ApiConfig *model = [ApiConfig yy_modelWithDictionary:dic];
            [self.netArray addObject:model];
        }
    }
    if (index >= [self.netArray count]) {
        index = 0;
    }
#ifndef DEBUG
    index = 0;
#endif
    _apiConfig = self.netArray[index];
}

- (void)registerApiNetChangeView:(UIViewController *)vc{
#ifdef DEBUG
    self.baseVc = vc;
    // 双击的 Recognizer
    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] init];
    [longPressRecognizer addTarget:self action:@selector(changeNetWork:)];
    [vc.view addGestureRecognizer:longPressRecognizer];
#endif
}

- (void)changeNetWork:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        //初始化提示框；
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"当前环境：%@%@，是否要切换连接环境？",self.apiConfig.env,self.apiConfig.baseURL] message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.text = @"http://192.168.166.";
            textField.placeholder = @"请输入自定义baseURL名称";
        }];
        [alert addAction:[UIAlertAction actionWithTitle:@"添加自定义baseURL" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            UITextField *envirnmentNameTextField = alert.textFields.firstObject;
            //输出 检查是否正确无误
            NSLog(@"你输入的文本%@",envirnmentNameTextField.text);
            ApiConfig *tempApiConfig = [[self.netArray firstObject] mutableCopy];
            tempApiConfig.baseURL = [self trimSpace:envirnmentNameTextField.text];
            tempApiConfig.env = @"自定义";
            [self.netArray addObject:tempApiConfig];
            [[NSUserDefaults standardUserDefaults] setObject:[self.netArray yy_modelToJSONObject] forKey:@"apiConfig"];
            [self setApiConfigIndex:self.netArray.count - 1];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
        }]];
        for(ApiConfig *tempApiConfig in self.netArray){
            [alert addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"%@:%@",tempApiConfig.env,tempApiConfig.baseURL] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //点击按钮的响应事件；
                for(int i=0; i<self.netArray.count; i++){
                    ApiConfig *tempApiConfig = self.netArray[i];
                    if ([[NSString stringWithFormat:@"%@:%@",tempApiConfig.env,tempApiConfig.baseURL] isEqualToString:action.title]) {
                        [self setApiConfigIndex:i];
                        break;
                    }
                }
            }]];
        }
        //弹出提示框；
        [self.baseVc presentViewController:alert animated:true completion:nil];
    }
}

- (NSString *)trimSpace:(NSString *)text
{
    return [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end
