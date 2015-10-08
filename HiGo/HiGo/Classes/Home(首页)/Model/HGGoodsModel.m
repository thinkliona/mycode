//
//  HGGoodsModel.m
//  HiGo
//
//  Created by Think_lion on 15/7/27.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import "HGGoodsModel.h"
#import "HGGoodsImageModel.h"



@implementation HGGoodsModel


+(NSDictionary *)objectClassInArray
{
    
    return @{@"goods_image" : [HGGoodsImageModel class]};
}





@end












