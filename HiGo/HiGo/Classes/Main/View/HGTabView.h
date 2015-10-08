//
//  HGTabView.h
//  HiGo
//
//  Created by Think_lion on 15/7/25.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  HGTabView;


@protocol HGTabViewDelegate <NSObject>

@optional
-(void)tabView:(HGTabView*)tabView didSelectedFrom:(int)from toIndex:(int)to;

@end

@interface HGTabView : UIView

-(void)addTabItem:(UITabBarItem*)item;
@property (nonatomic,weak) id<HGTabViewDelegate>delegate;

@end
