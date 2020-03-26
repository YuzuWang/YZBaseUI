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

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        NSBundle *resourceBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:@"Resources" ofType:@"bundle"]];
            
        self = [[resourceBundle loadNibNamed:@"YZSearchHistoryCell"
                                              owner:self
                                            options:nil] firstObject];
    }
    
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.title.backgroundColor = [UIColor dynamicColorWithLight:[UIColor groupTableViewBackgroundColor] dark:[UIColor lightGrayColor]];
}

@end
