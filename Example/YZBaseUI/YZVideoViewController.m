//
//  YZVideoViewController.m
//  YZBaseUI_Example
//
//  Created by Nansi on 2020/3/27.
//  Copyright © 2020 niansi.no@gmail.com. All rights reserved.
//

#import "YZVideoViewController.h"

#import "YZVideoBgView.h"

@interface YZVideoViewController ()

@property(nonatomic, strong) YZVideoBgView *bgView;

@end

@implementation YZVideoViewController


- (void)dealloc{
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true animated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

#pragma mark - UI
- (void)initView {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"resource.mp4" ofType:nil];
    
    _bgView = [[YZVideoBgView alloc] initWithFrame:self.view.bounds withPath:path];
    [self.view addSubview:_bgView];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 200, 50, 50);
    [button setTitle:@"返回" forState: UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(200, 200, 50, 50);
    [button1 setTitle:@"登录" forState: UIControlStateNormal];
    [button1 addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
}

#pragma mark - delegate

#pragma mark - private

- (void)back {
    [self.navigationController popViewControllerAnimated:false];
}

- (void)login {
    _bgView.effect = !_bgView.effect;
}

#pragma mark - target

#pragma mark - setter getter



@end
