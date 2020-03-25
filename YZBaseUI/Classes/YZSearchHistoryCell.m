//
//  YZSearchHistoryCell.m
//  YZBaseUI_Example
//
//  Created by Nansi on 2020/3/23.
//  Copyright © 2020 niansi.no@gmail.com. All rights reserved.
//

#import "YZSearchHistoryCell.h"
#import "UIColor+Extension.h"

@implementation YZSearchHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.title.backgroundColor = [UIColor dynamicColorWithLight:[UIColor groupTableViewBackgroundColor] dark:[UIColor lightGrayColor]];
}

@end
