//
//  PlaySoundView.m
//  CLS
//
//  Created by 周子龙 on 2018/11/6.
//  Copyright © 2018 apple. All rights reserved.
//

#import "PlaySoundView.h"
#import <AVFoundation/AVFoundation.h>

@interface PlaySoundView () <AVSpeechSynthesizerDelegate>

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer;
@property (nonatomic, assign) NSUInteger allCount;
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, copy) NSString *playContent;

@end

@implementation PlaySoundView

#pragma  mark TTS

- (void)startPlay {
    if (!self.isNextPlay) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(numberInPlaySoundView:)]) {
        self.allCount = [self.delegate numberInPlaySoundView:self];
    }
    if (self.index >= self.allCount) {
        if ([self.delegate respondsToSelector:@selector(completePlaySound)]) {
            [self.delegate completePlaySound];
        }
        return;
    }
    if ([self.delegate respondsToSelector:@selector(playSoundView:problemForRowAtIndex:)]) {
        self.playContent = [self.delegate playSoundView:self problemForRowAtIndex:self.index];
        if (self.playContent.length > 0 && self.playContent) {
            self.textLabel.text = self.playContent;
            [self play];
        }
    }
    self.index++;
    if (self.allCount > 0) {
        self.progressView.progress = (float)self.index / ((float)self.allCount);
    }
}

- (void)resetPlay {
    self.index = 0;
}

- (void)play {
    NSString *temp = self.playContent;
    temp = [temp stringByReplacingOccurrencesOfString:@"/" withString:@""];
    [self startTTS:temp callback:^(NSArray * _Nonnull response) {
        NSLog(@"startTTS:%@",[response description]);
    }];
}

- (void)stopPlay {
    [self cancelTTS];
}

-(void)configureTTS{
    self.synthesizer = self.synthesizer ? self.synthesizer : [[AVSpeechSynthesizer alloc] init];
    self.synthesizer.delegate = self;
}

-(void)startTTS:(NSString*)sentence callback:(ResponseSenderBlock)callback{
    self.synthesizer = [[AVSpeechSynthesizer alloc] init];
    self.synthesizer.delegate = self;
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:sentence];
    //utterance.voice = [AVSpeechSynthesisVoice voiceWithIdentifier:voice];
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
    utterance.voice = voice;
    [self.synthesizer speakUtterance:utterance];
}

- (void)cancelTTS{
    [self.synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance{
    NSLog(@"---完成播放");
    self.isNextPlay = YES;
}

- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didStartSpeechUtterance:(AVSpeechUtterance*)utterance{
    NSLog(@"---开始播放");
    self.isNextPlay = NO;
}

#pragma mark --- 点击事件
- (void)tapClick {
    if (!self.isNextPlay) {
        return;
    }
    NSLog(@"#######重播########");
    [self play];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:1/255.0 alpha:0.08].CGColor;
        self.layer.shadowOffset = CGSizeMake(0,1);
        self.layer.shadowOpacity = 1;
        self.layer.shadowRadius = 5;
        self.layer.cornerRadius = 2;
        self.index = 0;
        self.isNextPlay = YES;
        [self addSubview:self.iconView];
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(16, 16));
            make.left.top.equalTo(self).offset(10);
        }];
        [self addSubview:self.progressView];
        [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_right).offset(8);
            make.centerY.equalTo(self.iconView.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-13);
            make.height.mas_offset(5);
        }];
        [self addSubview:self.textLabel];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.progressView.mas_bottom).offset(10);
            make.left.equalTo(self).offset(36);
            make.right.equalTo(self).offset(-30);
            make.bottom.equalTo(self).offset(-10);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = [UIImage imageNamed:@"voice"];
    }
    return _iconView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] init];
        _progressView.progressTintColor = [UIColor orangeColor];
//        _progressView.trackTintColor = [UIColor lightGrayColor];
        _progressView.layer.masksToBounds = YES;
        _progressView.layer.cornerRadius = 2.5;
        _progressView.progress = 0;
    }
    return _progressView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
//        _textLabel.textColor = CLSCommonTextColor;
        _textLabel.textAlignment = NSTextAlignmentLeft;
        _textLabel.font = [UIFont systemFontOfSize:14.0];
        _textLabel.numberOfLines = 0;
    }
    return _textLabel;
}

@end
