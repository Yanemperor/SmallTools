//
//  PreventRepeatedButtonClickViewController.m
//  SmallTools
//
//  Created by 周子龙 on 2018/12/28.
//  Copyright © 2018 Zhou. All rights reserved.
//

#import "PreventRepeatedButtonClickViewController.h"
#import "UIButton+TimeInterval.h"

@interface PreventRepeatedButtonClickViewController ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, assign) NSInteger index;

@end

@implementation PreventRepeatedButtonClickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}


#pragma mark - 初始化

- (void)initUI {
    self.title = @"button防多点";
    self.index = 0;
    [self.view addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(120, 30));
    }];
}

#pragma mark - View(页面处理)


#pragma mark - XXXDelegate



#pragma mark - 对外接口


#pragma mark - private methods(内部接口)


#pragma mark -  loading


#pragma mark - 懒加载
- (UIButton *)button {
    if (!_button) {
        _button = [[UIButton alloc] init];
        _button.backgroundColor = [UIColor orangeColor];
        [_button setTitle:@"点击" forState:UIControlStateNormal];
        _button.layer.cornerRadius = 3;
        _button.layer.masksToBounds = YES;
        _button.timeInterval = 2;
        @weakify(self);
        [[_button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            self.index++;
            NSLog(@"%@",[NSString stringWithFormat:@"被点击%li次",self.index]);
        }];
    }
    return _button;
}



@end
