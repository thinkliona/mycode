//
//  HGFindBannerModel.h
//  HiGo
//
//  Created by Think_lion on 15/7/27.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HGFindBannerPicModel;

@interface HGFindBannerModel : NSObject

@property (nonatomic,copy) NSString *name;

@property (nonatomic,strong) HGFindBannerPicModel *banner_pic;

@end
