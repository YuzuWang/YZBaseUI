//
//  YZConstants.h
//  YZBaseUI_Example
//
//  Created by Nansi on 2020/3/26.
//  Copyright © 2020 niansi.no@gmail.com. All rights reserved.
//

#ifndef YZConstants_h
#define YZConstants_h

/**** UI尺寸 ****/
//获取屏幕宽度与高度
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height

//判断是否为X系列
#define IPHONE_X \
({\
BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
isPhoneX;\
})


#define YZLog(...) printf("function:%s line:%d content:%s\n\n",__FUNCTION__, __LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);


// 状态栏高度
#define kStatusBarHeight        (IPHONE_X ? 44.f : 20.f)

// 顶部导航栏高度
#define kNavigationBarHeight    44.f

// 顶部安全距离
#define kSafeAreaTopHeight      (IPHONE_X ? 88.f : 64.f)

// 底部安全距离
#define kSafeAreaBottomHeight   (IPHONE_X ? 34.f : 0.f)

// Tabbar高度
#define kTabbarHeight           49.f

// 去除上下导航栏剩余中间视图高度
#define ContentHeight           (kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight - kTabbarHeight)



#define NSUSERDEFAULT            [NSUserDefaults standardUserDefaults]

#define SEARCH_HISTORY_CACHE_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"history.plist"]


#endif /* YZConstants_h */
