//
//  HomeViewController.m
//  SmallTools
//
//  Created by 周子龙 on 2018/12/4.
//  Copyright © 2018 Zhou. All rights reserved.
//

#import "HomeViewController.h"
#import "FloatingWindowViewController.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *titleArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}


#pragma mark - 初始化

- (void)initUI {
    self.title = @"首页";
    self.titleArray = @[@"小圆点"];
    [self.view addSubview:self.tableView];
}

#pragma mark - View(页面处理)


#pragma mark - XXXDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *title = self.titleArray[indexPath.row];
    if ([title isEqualToString:@"小圆点"]) {
        FloatingWindowViewController *vc = [[FloatingWindowViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 对外接口


#pragma mark - private methods(内部接口)


#pragma mark -  loading


#pragma mark - 懒加载

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    }
    return _tableView;
}


@end
