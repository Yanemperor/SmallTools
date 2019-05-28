//
//  PlaySoundView.h
//  CLS
//
//  Created by 周子龙 on 2018/11/6.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlaySoundView;

typedef void (^ResponseSenderBlock)(NSArray *response);

@protocol PlaySoundViewDelegate <NSObject>

- (NSUInteger)numberInPlaySoundView:(PlaySoundView *)playSoundView;

- (NSString *)playSoundView:(PlaySoundView *)playSoundView problemForRowAtIndex:(NSInteger)index;

- (void)completePlaySound;

@end

NS_ASSUME_NONNULL_BEGIN

@interface PlaySoundView : UIView

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, weak) id<PlaySoundViewDelegate> delegate;
@property (nonatomic, assign) BOOL isNextPlay;

- (void)startPlay;
- (void)stopPlay;
- (void)resetPlay;

@end

NS_ASSUME_NONNULL_END

