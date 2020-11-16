//
//  YZHistoryHeaderView.m
//  YZBaseUI_Example
//
//  Created by Nansi on 2020/3/23.
//  Copyright © 2020 niansi.no@gmail.com. All rights reserved.
//

#import "YZHistoryHeaderView.h"
#import "UIColor+Extension.h"

@implementation YZHistoryHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = [UIColor dynamicColorWithLight:[UIColor whiteColor] dark:[UIColor darkGrayColor]];
    self.title.textColor = [UIColor s_colorWithHexString:@"0x222222"];
    self.title.font = [UIFont systemFontOfSize:15];
}

- (IBAction)delete:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteBtnClick)]) {
        [self.delegate deleteBtnClick];
    }
}

@end
