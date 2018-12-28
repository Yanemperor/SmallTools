//
//  RouterCell.m
//  SmallTools
//
//  Created by 周子龙 on 2018/12/28.
//  Copyright © 2018 Zhou. All rights reserved.
//

#import "RouterCell.h"

@interface RouterCell ()

@property (nonatomic, strong) UIButton *button1;

@end

@implementation RouterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.button1];
        [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(120, 30));
        }];
    }
    return self;
}

- (UIButton *)button1 {
    if (!_button1) {
        _button1 = [[UIButton alloc] init];
        _button1.backgroundColor = [UIColor orangeColor];
        [_button1 setTitle:@"点击" forState:UIControlStateNormal];
        _button1.layer.cornerRadius = 3;
        _button1.layer.masksToBounds = YES;
        @weakify(self);
        [[_button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self routerEventWithName:@"RouterCell" userInfo:@{@"cell":@"点击"}];
        }];
    }
    return _button1;
}


@end
