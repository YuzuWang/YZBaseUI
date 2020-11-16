//
//  YZSearchController.h
//  YZBaseUI_Example
//
//  Created by Nansi on 2020/3/23.
//  Copyright © 2020 niansi.no@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZSearchBar.h"


typedef NS_ENUM(NSUInteger, YZSearchType) {
    YZSearchTypeHistoriesFirst,
    YZSearchTypeHotKeysFirst,
};

@class YZSearchController;

@protocol YZSearchControllerDelegate <NSObject>

@optional

/// 开始搜索
-(void)searchCotroller:(YZSearchController *_Nullable)searchController beginSearch:(NSString *_Nonnull)searchText withResultController:(UIViewController *_Nullable)resultController;

-(void)searchControllerWillAppear:(YZSearchController *_Nullable)controller;
-(void)searchControllerWillDisappear:(YZSearchController *_Nullable)controller;
-(void)searchControllerDidDisappear:(YZSearchController *_Nullable)controller;

/// 自定义返回按钮
-(UIView *_Nullable)customBackButton;

- (void)shouldHiddenNavigationBar:(YZSearchController *_Nullable)searchController;

@end


NS_ASSUME_NONNULL_BEGIN

@interface YZSearchController : UIViewController

// 历史记录
@property(nonatomic, strong) NSMutableArray *history;

// 热词
@property(nonatomic, strong) NSMutableArray *hotKeys;

// 搜索
@property(nonatomic, strong) YZSearchBar *searchBar;

// 返回按钮
@property(nonatomic, strong) UIView *backBtn;

// 行间距   默认为5
@property(nonatomic, assign) float rowSpacing;

// 列间距   默认为5
@property(nonatomic, assign) float colSpacing;

// 历史记录的 内间距  默认为 UIEdgeInsetsMake(5,5,5,5);
@property(nonatomic, assign) UIEdgeInsets insets;

// 类型  默认历史记录和热词都有
@property(nonatomic, assign) YZSearchType type;

// 历史记录地址
@property(nonatomic, copy) NSString *historyPath;

// 历史记录标题
@property(nonatomic, copy) NSString *historyTitle;

@property(nonatomic, copy) NSString *placeholder;

// 热门搜索标题
@property(nonatomic, copy) NSString *hotkeysTitle;

// 历史记录最大数  默认为15
@property(nonatomic, assign) NSInteger maxHistories;

@property(nonatomic, strong) UIViewController *childController;

@property(nonatomic, weak) id<YZSearchControllerDelegate> delegate;

- (instancetype)initWithResultViewController:(UIViewController *)childController;

@end

NS_ASSUME_NONNULL_END
