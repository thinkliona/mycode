//
//  HGCategoryModel.h
//  HiGo
//
//  Created by Think_lion on 15/7/27.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HGImageModel;


@interface HGCategoryModel : NSObject


@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *cate_type;
@property (nonatomic,strong) HGImageModel *image;

@end
