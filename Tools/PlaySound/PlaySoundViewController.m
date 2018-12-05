//
//  PlaySoundViewController.m
//  SmallTools
//
//  Created by 周子龙 on 2018/12/5.
//  Copyright © 2018 Zhou. All rights reserved.
//

#import "PlaySoundViewController.h"
#import "PlaySoundView.h"

@interface PlaySoundViewController () <PlaySoundViewDelegate>

@property (nonatomic, strong) PlaySoundView *playSoundView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, copy) NSArray *textArray;

@end

@implementation PlaySoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}


#pragma mark - 初始化

- (void)initUI {
    self.title = @"文字转语音";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#999999"];
    self.textArray = @[@"这里是银行", @"带一个斜杠/的语音", @"还有不知道要讲什么的"];
    [self.view addSubview:self.playSoundView];
    [self.playSoundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-30);
        make.top.equalTo(self.view).offset(150);
    }];
    [self.view addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.playSoundView.mas_bottom).offset(60);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(120, 30));
    }];
}

#pragma mark - View(页面处理)


#pragma mark - XXXDelegate
- (NSUInteger)numberInPlaySoundView:(PlaySoundView *)playSoundView {
    return self.textArray.count;
}

- (NSString *)playSoundView:(PlaySoundView *)playSoundView problemForRowAtIndex:(NSInteger)index {
    return self.textArray[index];
}

- (void)completePlaySound {
    // 完成全部播放。
    NSLog(@"完成全部播放");
}


#pragma mark - 对外接口


#pragma mark - private methods(内部接口)


#pragma mark -  loading


#pragma mark - 懒加载
- (PlaySoundView *)playSoundView {
    if (!_playSoundView) {
        _playSoundView = [[PlaySoundView alloc] init];
        _playSoundView.backgroundColor = [UIColor whiteColor];
        _playSoundView.delegate = self;
    }
    return _playSoundView;
}

- (UIButton *)button {
    if (!_button) {
        _button = [[UIButton alloc] init];
        _button.backgroundColor = [UIColor orangeColor];
        [_button setTitle:@"开始播放" forState:UIControlStateNormal];
        _button.layer.cornerRadius = 3;
        _button.layer.masksToBounds = YES;
        @weakify(self);
        [[_button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self.playSoundView startPlay];
        }];
    }
    return _button;
}



@end
