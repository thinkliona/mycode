//
//  HGFindModel.h
//  HiGo
//
//  Created by Think_lion on 15/7/27.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HGGoodsInfoModel,HGGoodsMainImageModel;

@interface HGFindModel : NSObject

@property (nonatomic,copy) NSString *goods_id;  //group_id  goods_name  goods_desc
@property (nonatomic,copy) NSString *group_id;
@property (nonatomic,copy) NSString *goods_name;
@property (nonatomic,copy) NSString *goods_desc;
@property (nonatomic,copy) NSString *goods_display_final_price;  //产品的价格
@property (nonatomic,copy) NSString *goods_display_color_name;  //产品的颜色

//分组信息的模型
@property (nonatomic,strong)  HGGoodsInfoModel *group_info;

//主图片的模型
@property (nonatomic,strong) HGGoodsMainImageModel  *main_image;

@end
