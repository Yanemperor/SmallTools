//
//  FloatingWindowViewController.m
//  SmallTools
//
//  Created by 周子龙 on 2018/12/5.
//  Copyright © 2018 Zhou. All rights reserved.
//

#import "FloatingWindowViewController.h"
#import "FloatingWindowView.h"
@interface FloatingWindowViewController ()



@end

@implementation FloatingWindowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}


#pragma mark - 初始化

- (void)initUI {
    [[FloatingWindowView shareInstance] isHidden:NO];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[FloatingWindowView shareInstance] isHidden:YES];
}

#pragma mark - View(页面处理)


#pragma mark - XXXDelegate



#pragma mark - 对外接口


#pragma mark - private methods(内部接口)


#pragma mark -  loading


#pragma mark - 懒加载




@end
