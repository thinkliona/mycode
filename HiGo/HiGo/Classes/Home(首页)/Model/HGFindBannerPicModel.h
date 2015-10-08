//
//  HGFindBannerPicModel.h
//  HiGo
//
//  Created by Think_lion on 15/7/27.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGFindBannerPicModel : NSObject

@property (nonatomic,assign) CGFloat image_width;
@property (nonatomic,assign) CGFloat image_height;
//image_original
@property (nonatomic,copy) NSString *image_original;
@property (nonatomic,copy) NSString *image_middle;
@property (nonatomic,copy) NSString *image_thumbnail;


@end
