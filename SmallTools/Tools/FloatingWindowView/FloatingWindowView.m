//
//  FloatingWindowView.m
//  CLS
//
//  Created by 周子龙 on 2018/10/16.
//  Copyright © 2018 apple. All rights reserved.
//

#import "FloatingWindowView.h"

#define AnimateTime 0.3
#define Margin 10
#define kiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

@interface FloatingWindowView ()

@property (nonatomic, weak) UIViewController *vc;
@property (nonatomic, assign) CGPoint touchesBeganPoint;

@end

@implementation FloatingWindowView

+ (FloatingWindowView *)shareInstance {
    static dispatch_once_t onceToken;
    static FloatingWindowView *floatingWindowView;
    dispatch_once(&onceToken, ^{
        floatingWindowView = [[FloatingWindowView alloc] initWithFrame:CGRectMake(kScreenWidth - 51 - Margin, kScreenHeight - 200, 51, 51)];
        floatingWindowView.userInteractionEnabled = YES;
        floatingWindowView.backgroundColor = [UIColor clearColor];
        floatingWindowView.image = [UIImage imageNamed:@"calculate"];
    });
    return floatingWindowView;
}

- (void)click {
    
}

- (void)viewController:(UIViewController *)vc {
    _vc = vc;
    [self isHidden:NO];
}

- (void)isHidden:(BOOL)is {
    self.hidden = is;
    if (!is) {
        [[UIApplication sharedApplication].keyWindow addSubview:[FloatingWindowView shareInstance]];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [allTouches anyObject];
    CGPoint point = [touch locationInView:[touch window]];
    self.touchesBeganPoint = point;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [allTouches anyObject];
    CGPoint point = [touch locationInView:[touch window]];
    self.center = point;
    if (self.left <= 0 && self.top <= 0) {
        self.left = 0;
        self.top = 0;
    }else if (self.left <= 0 && self.bottom >= kScreenHeight) {
        self.left = 0;
        self.bottom = kScreenHeight;
    }else if (self.bottom >= kScreenHeight && self.right >= kScreenWidth) {
        self.bottom = kScreenHeight;
        self.right = kScreenWidth;
    }else if (self.right >= kScreenWidth && self.top <= 0) {
        self.right = kScreenWidth;
        self.top = 0;
    }else if (self.left <= 0) {
        self.left = 0;
    }else if (self.top <= 0) {
        self.top = 0;
    }else if (self.right >= kScreenWidth) {
        self.right = kScreenWidth;
    }else if (self.bottom >= kScreenHeight) {
        self.bottom = kScreenHeight;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [allTouches anyObject];
    CGPoint point = [touch locationInView:[touch window]];
    if (point.x == _touchesBeganPoint.x && point.y == _touchesBeganPoint.y) {
        [self click];
    }else{
        if (self.left < kScreenWidth / 2.0) {
            [UIView animateWithDuration:AnimateTime animations:^{
                self.left = Margin;
            }];
        }
        if (self.top <= 0) {
            [UIView animateWithDuration:AnimateTime animations:^{
                if (kiPhoneX) {
                    self.top = 2 * Margin + 20;
                }else{
                    self.top = 2 * Margin;
                }
            }];
        }
        if (self.right >= kScreenWidth / 2.0) {
            [UIView animateWithDuration:AnimateTime animations:^{
                self.right = kScreenWidth - Margin;
            }];
        }
        if (self.bottom >= kScreenHeight) {
            [UIView animateWithDuration:AnimateTime animations:^{
                if (kiPhoneX) {
                    self.bottom = kScreenHeight - Margin - 20;
                }else{
                    self.bottom = kScreenHeight - Margin;
                }
            }];
        }
    }
}

@end
