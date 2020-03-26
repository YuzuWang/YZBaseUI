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


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        NSBundle *resourceBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:@"Resources" ofType:@"bundle"]];
        
        self = [[resourceBundle loadNibNamed:@"YZHistoryHeaderView"
                                              owner:self
                                            options:nil] firstObject];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = [UIColor dynamicColorWithLight:[UIColor whiteColor] dark:[UIColor darkGrayColor]];
    self.title.textColor = [UIColor dynamicColorWithLight:[UIColor blackColor] dark:[UIColor whiteColor]];
}

- (IBAction)delete:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteBtnClick)]) {
        [self.delegate deleteBtnClick];
    }
}

@end
