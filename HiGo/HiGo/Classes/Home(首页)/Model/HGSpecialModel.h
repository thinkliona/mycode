//
//  HGSpecialModel.h
//  HiGo
//
//  Created by Think_lion on 15/7/28.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HGSpecialMainImageModel;

@interface HGSpecialModel : NSObject

@property (nonatomic,copy) NSString *goods_name;
@property (nonatomic,copy) NSString *goods_desc;
@property (nonatomic,copy) NSString *goods_display_final_price;  //产品的价格
@property (nonatomic,copy) NSString *goods_display_color_name;  //产品的颜色

//主图片的模型
@property (nonatomic,strong) HGSpecialMainImageModel  *main_image;

@end
