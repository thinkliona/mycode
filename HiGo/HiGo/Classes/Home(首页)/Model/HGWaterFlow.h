//
//  HGWaterFlow.h
//  HiGo
//
//  Created by Think_lion on 15/7/27.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HGWaterFlow;

@protocol HGWaterFlowDelegate <NSObject>

//必须实现
-(CGFloat)waterFlow:(HGWaterFlow*)waterFlow heightForWidth:(CGFloat)width indexPath:(NSIndexPath*)indexPath;

@end


@interface HGWaterFlow : UICollectionViewLayout

//每一行的间距
@property (nonatomic,assign) CGFloat rowMargin;
//每一列的间距
@property (nonatomic,assign) CGFloat columnMargin;
//四边的距离
@property (nonatomic,assign) UIEdgeInsets sectionInset;
//最大的列数
@property (nonatomic,assign) CGFloat columsCount;


@property (nonatomic,weak) id<HGWaterFlowDelegate>delegate;

@end;








