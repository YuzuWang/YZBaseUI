//
//  YZVideoBgView.m
//  YZBaseUI_Example
//
//  Created by Nansi on 2020/3/27.
//  Copyright © 2020 niansi.no@gmail.com. All rights reserved.
//

#import "YZVideoBgView.h"
#import <AVFoundation/AVFoundation.h>

@interface YZVideoBgView()

@property(nonatomic, strong) UIVisualEffectView *effectView;

@property(nonatomic, strong) UIView *maskView;

@end

@implementation YZVideoBgView

- (instancetype)initWithFrame:(CGRect)frame withPath:(NSString *)path
{
    self = [super initWithFrame:frame];
    if (self) {
        _path = path;
        [self initView];
    }
    return self;
}

#pragma mark - initView

- (void)initView {
    [self play];
    [self addSubview:self.maskView];
}

#pragma mark - target

#pragma mark - private


-(void)play {
    if (!self.path || self.path.length == 0) {
        assert(@"视频路径不能为空");
        return;
    }
    [self.player play];
}

- (void)playToEnd {
    [self.player seekToTime:kCMTimeZero];
}

#pragma mark - getter setter

- (void)setEffect:(BOOL)effect {
    if (_effect == effect) {
        return;
    }
    _effect = effect;
    if (_effect) {
        [self addSubview:self.effectView];
        [_maskView removeFromSuperview];
    }else {
        [self.effectView removeFromSuperview];
        [self addSubview:self.maskView];
    }
}

- (void)setEffectAlpha:(float)effectAlpha {
    if (_effectAlpha == effectAlpha) {
        return;
    }
    _effectView.alpha = _effectAlpha;
}

- (AVPlayer *)player
{
    if (!_player) {
        NSURL *url = [NSURL fileURLWithPath:_path];
        AVPlayerItem *playItem = [AVPlayerItem playerItemWithURL:url];
        // 2 播放的设置
        _player = [AVPlayer playerWithPlayerItem:playItem];
        _player.actionAtItemEnd = AVPlayerActionAtItemEndNone;// 永不暂停
        _player.muted = true;
        _player.automaticallyWaitsToMinimizeStalling = false;
        
        // 3 将图层嵌入到0层
        AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_player];
        layer.frame = self.bounds;
        [self.layer insertSublayer:layer atIndex:0];
        // 4 播放到头循环播放
        
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playToEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return _player;
}

- (UIVisualEffectView *)effectView {
    if (!_effectView) {
          UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
            effectView.frame = self.bounds;
        _effectView = effectView;
    }
    return _effectView;
}

- (UIView *)maskView {
    if (!_maskView) {
        UIView *maskView = [[UIView alloc] init];
        maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        maskView.frame = self.bounds;
        _maskView = maskView ;
    }
    return _maskView;
}

@end
