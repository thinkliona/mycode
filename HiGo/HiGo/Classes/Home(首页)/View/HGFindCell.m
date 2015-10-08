//
//  HGFindCell.m
//  HiGo
//
//  Created by Think_lion on 15/7/27.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import "HGFindCell.h"
#import "HGFindShowView.h"
#import "HGFindFrameModel.h"

@interface HGFindCell ()

@property (nonatomic,weak) HGFindShowView *showV;

@end

@implementation HGFindCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
       //添加子控件
        [self addChildView];
    }
    return self;
}

#pragma mark 添加子控件的方法
-(void)addChildView
{
    HGFindShowView *showV=[[HGFindShowView alloc]init];
    [self.contentView addSubview:showV];
    self.showV=showV;
    
}


-(void)setFindFrame:(HGFindFrameModel *)findFrame
{
    self.showV.findFrame=findFrame;
}

@end
