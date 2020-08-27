//
//  YZResultController.m
//  YZBaseUI_Example
//
//  Created by Nansi on 2020/3/24.
//  Copyright © 2020 niansi.no@gmail.com. All rights reserved.
//

#import "YZResultController.h"

@interface YZResultController ()

@end

@implementation YZResultController


- (void)dealloc{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    
    self.view.backgroundColor = [UIColor redColor];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
#pragma mark - UI
- (void)initView {
    
}



#pragma mark - delegate

#pragma mark - private

#pragma mark - target

#pragma mark - setter getter

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event 
{
    [self.navigationController pushViewController:[YZResultController new] animated:true];
}
@end
