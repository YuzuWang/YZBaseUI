//
//  YZViewController.m
//  YZBaseUI
//
//  Created by niansi.no@gmail.com on 03/20/2020.
//  Copyright (c) 2020 niansi.no@gmail.com. All rights reserved.
//

#import "YZViewController.h"
#import "YZResultController.h"
#import "YZSearchController+YZSearch.h"

#import "YZVideoViewController.h"

@interface YZViewController ()<YZSearchControllerDelegate, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, copy) NSArray *titleArr;

@end

@implementation YZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    _titleArr = @[@"搜索", @"弹框"];
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _titleArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    switch (indexPath.row) {
        case 0:
        {
            [self search];
        }
            break;
        case 1: {
            YZVideoViewController *videoVC = [[YZVideoViewController alloc] init];
            [self.navigationController pushViewController:videoVC animated:false];
        }
            break;
        default:
            break;
    }
    
}


- (void)searchCotroller:(YZSearchController *)searchController beginSearch:(NSString *)searchText withResultController:(UIViewController *)resultController {
    NSLog(@"搜索的关键字是 ====> %@", searchText);
}

- (void)searchControllerWillAppear:(YZSearchController *)controller{
    [controller.navigationController setNavigationBarHidden:true animated:true];
}

- (void)searchControllerWillDisappear:(YZSearchController *)controller {
 [controller.navigationController setNavigationBarHidden:false animated:true];
}


#pragma mark - Search

- (void)search {
    YZResultController *resultVC = [[YZResultController alloc] init];
      
      YZSearchController *controller = [[YZSearchController alloc] initWithResultViewController:resultVC];
      controller.delegate = self;
      controller.modalPresentationStyle= UIModalPresentationFullScreen;
      controller.hotKeys = [NSMutableArray arrayWithArray: @[@"洗漱用品",@"生活用品",@"科技产品"]];
      [self.navigationController pushViewController:controller animated:NO];
}


- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
        _tableView.separatorInset = UIEdgeInsetsZero;
        
        _tableView.contentInset = UIEdgeInsetsMake(kSafeAreaTopHeight, 0, kSafeAreaBottomHeight, 0);
        [self.tableView setScrollIndicatorInsets:UIEdgeInsetsMake(0, 0, kSafeAreaBottomHeight, 0)];
        _tableView.tableFooterView = [UIView new];
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
    }
    return _tableView;
}




@end
