//
//  YZSearchController.m
//  YZBaseUI_Example
//
//  Created by Nansi on 2020/3/23.
//  Copyright © 2020 niansi.no@gmail.com. All rights reserved.
//

#import "YZSearchController.h"
#import "YZConstants.h"
#import "YZSearchCollectionViewLayout.h"
#import "YZSearchHistoryCell.h"
#import "YZHistoryHeaderView.h"

#import "UIColor+Extension.h"

@interface YZSearchController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, YZHistoryHeaderViewDelegate>

@property(nonatomic, strong) UIView *containerView;

@property(nonatomic, strong) UISearchBar *searchBar;

@property(nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic, strong) YZSearchCollectionViewLayout *layout;

@property(nonatomic, strong) NSMutableArray<NSMutableArray *> *dataArray;

@property(nonatomic, strong) UIView *backBtn;

@end

@implementation YZSearchController

@synthesize history = _history;

- (void)dealloc{
    
}

- (instancetype)initWithResultViewController:(UIViewController *)childController
{
    self = [super init];
    if (self) {
        [self defaultSetting];
        _childController = childController;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:false];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = true;
    [self initView];
}

#pragma mark - UI
- (void)initView {
    
    [self resetDataArray];

    [self.view addSubview:self.containerView];
    
    [self.containerView addSubview:self.backBtn];
    
    [self.containerView addSubview:self.searchBar];
    
    [self.view addSubview:self.collectionView];
}

- (void)defaultSetting {
    _insets = UIEdgeInsetsMake(5, 16, 20, 16);
    _rowSpacing = 8;
    _colSpacing = 8;
    _historyTitle = @"历史搜索";
    _hotkeysTitle = @"热门搜索";
    _historyPath = SEARCH_HISTORY_CACHE_PATH;
    _placeholder = @"请输入关键字";
    _maxHistories = 15;
}

#pragma mark - CollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray[section].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YZSearchHistoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.title.text = _dataArray[indexPath.section][indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *str      = _dataArray[indexPath.section][indexPath.row];
    /* 根据每一项的字符串确定每一项的size */
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGSize size        = [str boundingRectWithSize:CGSizeMake(self.collectionView.frame.size.width - _insets.left - _insets.right - 25, 1000) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:dict context:nil].size;
    size.height        = 30;
    size.width         += 25;
    return size;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(100, 40);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    YZHistoryHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    
    view.delegate = self;
    
    NSArray *titleArr;
    if (_type == YZSearchTypeHistoriesFirst) {
        titleArr = @[self.historyTitle, self.hotkeysTitle];
        if (indexPath.section == 0) {
            view.deleteBtn.hidden = false;
        }else {
            view.deleteBtn.hidden = true;
        }
    }else {
        if (indexPath.section == 1) {
            view.deleteBtn.hidden = true;
        }else {
            view.deleteBtn.hidden = false;
        }
        titleArr = @[self.hotkeysTitle, self.historyTitle];
    }
    
    view.title.text = titleArr[indexPath.section];
    
    if (kind == UICollectionElementKindSectionHeader) {
        return view;
    }

    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *text = _dataArray[indexPath.section][indexPath.row];
    NSLog(@"text ==== %@",text);
    [self addHistoryRecord:text];
    self.searchBar.text = text;
}

#pragma mark - SearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self dismissResult];
    return true;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [_searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    NSString *searchText = searchBar.text;
    [self addHistoryRecord:searchText];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - HeaderViewDelegate

-(void)deleteBtnClick {
    [_history removeAllObjects];
    [self resetDataArray];
    [self saveHistories];
}

#pragma mark - private

/// 重置数据数组
- (void)resetDataArray {
    [self.dataArray removeAllObjects];
    if (_type == YZSearchTypeHistoriesFirst) {
        [_dataArray addObject:self.history];
        if (self.hotKeys) {
            [_dataArray addObject:self.hotKeys];
        }
    }else {
        if (self.hotKeys) {
            [_dataArray addObject:self.hotKeys];
        }
        [_dataArray addObject:self.history];
    }
    
    if (_collectionView) {
        [_collectionView reloadData];
    }
}

/// 添加历史记录
- (void)addHistoryRecord:(NSString *)searchText {
    [self.view endEditing:true];
    [_searchBar setShowsCancelButton:false animated:true];
    
    if ([self.delegate respondsToSelector:@selector(searchCotroller:beginSearch:withResultController:)]) {
        [self.delegate searchCotroller:self beginSearch:searchText withResultController:self.childController];
    }
    
    [self showResult];
    
    if ([self.history containsObject:searchText]) {
        if ([_history indexOfObject:searchText] == 0) {
            return;
        }
        [_history removeObject:searchText];
    }
    
    [_history insertObject:searchText atIndex:0];
    
    if (_history.count > _maxHistories) {
        _history = [NSMutableArray arrayWithArray:[_history subarrayWithRange:NSMakeRange(0, _maxHistories)]];
        
        [self resetDataArray];
    }else {
        [_collectionView reloadData];
    }
    
    [self saveHistories];
}

/// 保存历史记录
- (void)saveHistories {
    [_history writeToFile:self.historyPath atomically:YES];
}

/// 获取历史l记录
- (void)getHisotry {
    _history = [NSMutableArray arrayWithArray:[NSArray arrayWithContentsOfFile:self.historyPath]];
}

/// 展示搜索结果
- (void)showResult {
    if (_childController) {
           [self addChildViewController:_childController];
           _childController.view.frame = CGRectMake(0, kSafeAreaTopHeight, SCREEN_WIDTH, SCREENH_HEIGHT - kSafeAreaTopHeight);
           [self.view addSubview:_childController.view];
           [_childController didMoveToParentViewController:self];
       }
}

- (void)dismissResult {
    [_childController willMoveToParentViewController:nil];
    [_childController.view removeFromSuperview];
    [_childController removeFromParentViewController];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:NO];
    [self dismissViewControllerAnimated:false completion:nil];
}



#pragma mark - target

#pragma mark - setter

- (void)setHistoryPath:(NSString *)historyPath {
    if ([historyPath isEqualToString:_historyPath]) {
        return;
    }
    
    _historyPath = historyPath;
    [self getHisotry];
    [self resetDataArray];
}

- (void)setType:(YZSearchType)type {
    if (_type == type) {
        return;
    }
    _type = type;
    [self resetDataArray];
}

- (void)setHistory:(NSMutableArray *)history {
    if ([_history isEqualToArray:history]) {
        return;
    }
    _history = history;
    [self resetDataArray];
}

- (void)setHotKeys:(NSMutableArray *)hotKeys {
    if ([_hotKeys isEqualToArray:hotKeys]) {
        return;
    }
    _hotKeys = hotKeys;
    [self resetDataArray];
}

#pragma mark - getter

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [@[] mutableCopy];
    }
    return _dataArray;
}

- (NSMutableArray *)history {
    if (!_history) {
        [self getHisotry];
    }
    return _history;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kSafeAreaTopHeight)];
        _containerView.backgroundColor = [UIColor dynamicColorWithLight:[UIColor whiteColor] dark:[UIColor darkGrayColor]];
    }
    return _containerView;
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.frame = CGRectMake(40, kStatusBarHeight + 4, SCREEN_WIDTH - 40 - 12, 35);
        _searchBar.barTintColor = [UIColor dynamicColorWithLight:[UIColor whiteColor] dark:[UIColor darkGrayColor]];
        _searchBar.tintColor = [UIColor dynamicColorWithLight:[UIColor blackColor] dark:[UIColor whiteColor]];
        _searchBar.delegate = self;
        _searchBar.placeholder = _placeholder;
        UIImageView *barImageView = [[[_searchBar.subviews firstObject] subviews] firstObject];
        
        UIColor *color = [UIColor dynamicColorWithLight:[UIColor whiteColor] dark:[UIColor darkGrayColor]];
        barImageView.layer.borderColor = color.CGColor;
        barImageView.layer.borderWidth = 1;
        
        UITextField * searchTextField =  [_searchBar valueForKey:@"searchField"];
        searchTextField.font = [UIFont systemFontOfSize:15];
        
        searchTextField.backgroundColor = [UIColor dynamicColorWithLight:[UIColor groupTableViewBackgroundColor] dark:[UIColor lightGrayColor]];

        if (@available(iOS 9.0, *)) {
            UIBarButtonItem *cancelBtn = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]];
            cancelBtn.title = @"取消";
        } else {
            // Fallback on earlier versions
        }
    }
    return _searchBar;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        _layout = [[YZSearchCollectionViewLayout alloc] init];
        
        _layout.minimumLineSpacing = self.rowSpacing;
        _layout.minimumInteritemSpacing = self.colSpacing;
        _layout.sectionInset = self.insets;
        _layout.rowSpacing = 5;
        
        _collectionView = ({
            UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kSafeAreaTopHeight, SCREEN_WIDTH, SCREENH_HEIGHT - kSafeAreaTopHeight) collectionViewLayout:_layout];
            
            collection.backgroundColor = [UIColor dynamicColorWithLight:[UIColor whiteColor] dark:[UIColor darkGrayColor]];
            collection.delegate = self;
            collection.dataSource = self;
            
            [collection registerNib:[UINib nibWithNibName:@"YZSearchHistoryCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
            [collection registerNib:[UINib nibWithNibName:@"YZHistoryHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
            
            if (@available(iOS 11.0, *)) {
                collection.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }else {
                self.automaticallyAdjustsScrollViewInsets = NO;
            }
            
            collection;
        });
        
    }
    return _collectionView;
}

- (UIView *)backBtn {
    if (!_backBtn) {
        if ([self.delegate respondsToSelector:@selector(customBackButton)]) {
            _backBtn = [self.delegate customBackButton];
        }else {
            _backBtn = ({
                UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [backBtn setImage:[UIImage imageNamed:@"back.png"]
                         forState:UIControlStateNormal];
                
                [backBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 6, 5, 13)];
                [backBtn setContentMode:UIViewContentModeScaleAspectFill];
                [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
                backBtn;
            });
        }
        _backBtn.frame = CGRectMake(10, kStatusBarHeight + 6, 30, 30);
    }
    return _backBtn;
}


@end
