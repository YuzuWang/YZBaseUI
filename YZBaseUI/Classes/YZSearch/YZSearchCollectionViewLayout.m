//
//  YZSearchCollectionViewLayout.m
//  YZBaseUI_Example
//
//  Created by Nansi on 2020/3/23.
//  Copyright © 2020 niansi.no@gmail.com. All rights reserved.
//

#import "YZSearchCollectionViewLayout.h"

static float const kDefatultOriginX = 0;

@implementation YZSearchCollectionViewLayout


/**
 *  重写当前方法 实现控制item最大间距
 *
 *  @param rect 绘图范围
 *
 *  @return item属性数组
 */
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    for(int i = 0; i < [attributes count]; i++) {
        
        //当前attributes
        UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
    
        // 不知道原因  header 在数组中的最后一个
        if (currentLayoutAttributes.representedElementKind == UICollectionElementKindSectionHeader ) {
                       
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = 0;
            currentLayoutAttributes.frame = frame;
//            NSLog(@"头 >>> %d, --- %f", i, frame.origin.x);
            continue;
        }
                   
        UIEdgeInsets insets = self.sectionInset;

        // 第一个特殊处理
        if (i == 0) {
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = kDefatultOriginX + insets.left;
            currentLayoutAttributes.frame = frame;
            continue;
        }
        
        //上一个attributes
        UICollectionViewLayoutAttributes *prevLayoutAttributes    = attributes[i - 1];
        
        // 不是同一个section 的话， 也是从头开始算起
        if (currentLayoutAttributes.indexPath.section != prevLayoutAttributes.indexPath.section) {
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = kDefatultOriginX + insets.left;
            currentLayoutAttributes.frame = frame;
            continue;
        }
        
        //前一个cell的最右边
        CGFloat origin = CGRectGetMaxX(prevLayoutAttributes.frame);
        //如果当前一个cell的最右边加上我们想要的间距加上当前cell的宽度依然在contentSize中，我们改变当前cell的原点位置
        //不加这个判断的后果是，UICollectionView只显示一行，原因是下面所有cell的x值都被加到第一行最后一个元素的后面了
                
        if(origin + self.minimumInteritemSpacing  + currentLayoutAttributes.frame.size.width + insets.right < self.collectionViewContentSize.width) {
            CGRect frame                  = currentLayoutAttributes.frame;
            frame.origin.x                = origin + self.minimumInteritemSpacing;
            frame.origin.y = prevLayoutAttributes.frame.origin.y;
            currentLayoutAttributes.frame = frame;
            
//            NSLog(@" >>> %d, --- %@", i, NSStringFromCGRect(frame));
        }else{
            CGRect frame                  = currentLayoutAttributes.frame;
            frame.origin.x                = kDefatultOriginX + insets.left;
            currentLayoutAttributes.frame = frame;
//            NSLog(@"换行 >>> %d, --- %@", i, NSStringFromCGRect(frame));
        }
    }
    return attributes;
}


@end
