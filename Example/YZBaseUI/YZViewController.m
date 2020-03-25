//
//  YZViewController.m
//  YZBaseUI
//
//  Created by niansi.no@gmail.com on 03/20/2020.
//  Copyright (c) 2020 niansi.no@gmail.com. All rights reserved.
//

#import "YZViewController.h"
#import "YZResultController.h"

@interface YZViewController ()<YZSearchControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation YZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    YZResultController *resultVC = [[YZResultController alloc] init];
    
    YZSearchController *controller = [[YZSearchController alloc] initWithResultViewController:resultVC];
    controller.delegate = self;
    controller.modalPresentationStyle= UIModalPresentationFullScreen;
    controller.hotKeys = [NSMutableArray arrayWithArray: @[@"洗漱用品",@"生活用品",@"科技产品"]];
//    [self.navigationController pushViewController:controller animated:NO];
    [self presentViewController:controller animated:false completion:nil];
}


- (void)searchCotroller:(YZSearchController *)searchController beginSearch:(NSString *)searchText withResultController:(UIViewController *)resultController {
    
    NSLog(@"搜索的关键字是 ====> %@", searchText);
}

//- (UIView *)customBackButton {
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = [UIColor blueColor];
//    return view;
//}

@end
