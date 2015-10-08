//
//  HGScrollCell.m
//  HiGo
//
//  Created by Think_lion on 15/7/26.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import "HGScrollCell.h"
#import "HGScrollModel.h"


@interface HGScrollCell ()
@property (nonatomic,weak) UIImageView *imageView;

@end

@implementation HGScrollCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        [self addChild];
    }
    return self;
}


-(void)addChild
{
    UIImageView *imageView=[[UIImageView alloc]init];
    imageView.frame=self.bounds;
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds=YES;
    // imageView.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    [self.contentView addSubview:imageView];
    self.imageView=imageView;
    
}

-(void)setScrollModel:(HGScrollModel *)scrollModel
{
    _scrollModel=scrollModel;
    //self.imageView.image=[UIImage imageNamed:scrollModel.icon];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:scrollModel.icon] placeholderImage:[UIImage imageNamed:@"loading"]];
}






@end
