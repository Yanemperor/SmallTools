//
//  InjectionIIIViewController.m
//  SmallTools
//
//  Created by 周子龙 on 2019/4/2.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "InjectionIIIViewController.h"

@interface InjectionIIIViewController ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIView *bgView;

@end

@implementation InjectionIIIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}


#pragma mark - 初始化

- (void)initUI {
    self.title = @"InjectionIII";
    [self.view addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(120, 30));
    }];
//    [self.view addSubview:self.bgView];
//    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.button.mas_centerX);
//        make.top.equalTo(self.button.mas_bottom).offset(30);
//        make.size.mas_equalTo(CGSizeMake(120, 40));
//    }];
}

#pragma mark - View(页面处理)


#pragma mark - XXXDelegate



#pragma mark - 对外接口


#pragma mark - private methods(内部接口)
// App Store下载InjectionIII 运行后打开注释，然后control+= , 点击按钮发现injected方法m被执行。
- (void)buttonClick {
    [self injected];
    
}

- (void)injected
{
    NSLog(@"I've been injected: %@", self);
}


#pragma mark -  loading


#pragma mark - 懒加载
- (UIButton *)button {
    if (!_button) {
        _button = [[UIButton alloc] init];
        _button.backgroundColor = [UIColor blackColor];
        [_button setTitle:@"点击" forState:UIControlStateNormal];
        _button.layer.cornerRadius = 3;
        _button.layer.masksToBounds = YES;
        [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor orangeColor];
    }
    return _bgView;
}

@end
