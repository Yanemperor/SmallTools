//
//  YYFPSViewController.m
//  SmallTools
//
//  Created by 周子龙 on 2019/1/8.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "YYFPSViewController.h"
#import "YYFPSLabel.h"

@interface YYFPSViewController ()

@property (nonatomic, strong) YYFPSLabel *fpsLabel;

@end

@implementation YYFPSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}


#pragma mark - 初始化

- (void)initUI {
    [self.view addSubview:self.fpsLabel];
    
}

#pragma mark - View(页面处理)


#pragma mark - XXXDelegate



#pragma mark - 对外接口


#pragma mark - private methods(内部接口)


#pragma mark -  loading


#pragma mark - 懒加载
- (YYFPSLabel *)fpsLabel {
    if (!_fpsLabel) {
        _fpsLabel = [[YYFPSLabel alloc] initWithFrame:CGRectMake(30, 100, 100, 20)];
        _fpsLabel.backgroundColor = [UIColor orangeColor];
    }
    return _fpsLabel;
}



@end
