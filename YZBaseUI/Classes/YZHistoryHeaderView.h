//
//  YZHistoryHeaderView.h
//  YZBaseUI_Example
//
//  Created by Nansi on 2020/3/23.
//  Copyright © 2020 niansi.no@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YZHistoryHeaderViewDelegate <NSObject>

@optional

-(void)deleteBtnClick;


@end

@interface YZHistoryHeaderView : UICollectionReusableView

@property(nonatomic, weak) id<YZHistoryHeaderViewDelegate> delegate;

@property(nonatomic, strong) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@end

NS_ASSUME_NONNULL_END
