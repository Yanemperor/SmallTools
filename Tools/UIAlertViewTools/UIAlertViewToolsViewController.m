//
//  UIAlertViewToolsViewController.m
//  SmallTools
//
//  Created by 周子龙 on 2018/12/24.
//  Copyright © 2018 Zhou. All rights reserved.
//

#import "UIAlertViewToolsViewController.h"
#import "UIAlertViewTools.h"

@interface UIAlertViewToolsViewController ()

@end

@implementation UIAlertViewToolsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}


#pragma mark - 初始化

- (void)initUI {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    button.backgroundColor = [UIColor orangeColor];
    button.center = self.view.center;
    [button setTitle:@"alertView" forState:UIControlStateNormal];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [UIAlertViewTools alertWithTitle:@"提示" message:@"提示信息" cancelButtonTitle:@"取消" otherButtonTitle:@"确定" withBlock:^(NSInteger index) {
            if (index == 0) {
                NSLog(@"取消");
            }else{
                NSLog(@"确定");
            }
        }];
    }];
    [self.view addSubview:button];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    button1.backgroundColor = [UIColor orangeColor];
    button1.center = self.view.center;
    button1.top = button.bottom + 30;
    [button1 setTitle:@"SheetView" forState:UIControlStateNormal];
    [[button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [UIAlertViewTools alertSheetWithTitle:@"请选择" message:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:@[@"1",@"2",@"3"] withBlock:^(NSInteger index) {
            if (index == 0) {
                NSLog(@"取消");
            }else if (index == -1) {
                NSLog(@"删除");
            }else if (index == 1) {
                NSLog(@"1");
            }else if (index == 2) {
                NSLog(@"2");
            }else if (index == 3) {
                NSLog(@"3");
            }
        }];
    }];
    [self.view addSubview:button1];
    
}


#pragma mark - View(页面处理)


#pragma mark - XXXDelegate



#pragma mark - 对外接口


#pragma mark - private methods(内部接口)


#pragma mark -  loading


#pragma mark - 懒加载




@end
