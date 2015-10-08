//
//  HGGoodsFrame.h
//  HiGo
//
//  Created by Think_lion on 15/7/27.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import <Foundation/Foundation.h>

#define  HGDescFont  [UIFont systemFontOfSize:13]

@class HGGoodsModel;

@interface HGGoodsFrame : NSObject

@property (nonatomic,strong) HGGoodsModel *goodsModel;


//自定显示view的frame
@property (nonatomic,assign,readonly) CGRect viewR;

//第一张大图的frame
@property (nonatomic,assign,readonly) CGRect imageF;
//小图片的frame
@property (nonatomic,assign,readonly) CGRect oneSmallF;
@property (nonatomic,assign,readonly) CGRect twoSmallF;
@property (nonatomic,assign,readonly) CGRect threeSmallF;
//描述文字的frame
@property (nonatomic,assign,readonly) CGRect descF;
//地址的frame
@property (nonatomic,assign,readonly) CGRect addressF;

//表格单元的高度
@property (nonatomic,assign) CGFloat cellH;

@end
