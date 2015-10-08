//
//  GHCategoryList.h
//  HiGo
//
//  Created by Think_lion on 15/7/27.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HGCategoryList;

@protocol HGCategoryListDelegate <NSObject>

@optional

-(void)categoaryList:(HGCategoryList*)categoaryList clickIndex:(NSInteger)clickIndex;

@end

@interface HGCategoryList : UIView

@property (nonatomic,strong) NSArray *data;
@property (nonatomic,weak) id<HGCategoryListDelegate> delegate;

@end
