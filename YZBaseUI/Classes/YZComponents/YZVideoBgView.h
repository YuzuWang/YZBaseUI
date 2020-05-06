//
//  YZVideoBgView.h
//  YZBaseUI_Example
//
//  Created by Nansi on 2020/3/27.
//  Copyright © 2020 niansi.no@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AVPlayer;

@interface YZVideoBgView : UIView

- (instancetype)initWithFrame:(CGRect)frame withPath:(NSString *)path;

@property(nonatomic, strong) AVPlayer *player;

@property(nonatomic, copy) NSString *path;

@property(nonatomic, assign)BOOL effect;

@property(nonatomic, assign)float effectAlpha;

@end

NS_ASSUME_NONNULL_END
