//
//  HGSpecialCell.m
//  HiGo
//
//  Created by Think_lion on 15/7/28.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import "HGSpecialCell.h"
#import "HGSpecialModel.h"
#import "HGSpecialMainImageModel.h"

@interface HGSpecialCell ()
@property (nonatomic,weak)  UIImageView *logo;

@end

@implementation HGSpecialCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        [self addChildView];
    }
    return self;
}

-(void)addChildView
{
    UIImageView *logo=[[UIImageView alloc]initWithFrame:self.bounds];
    logo.contentMode=UIViewContentModeScaleAspectFill;
    logo.clipsToBounds=YES;
    [self.contentView addSubview:logo];
    self.logo=logo;
}


-(void)setSpecialModel:(HGSpecialModel *)specialModel
{
    _specialModel=specialModel;
    
    NSString *strUrl=specialModel.main_image.image_original;
    [self.logo sd_setImageWithURL:[NSURL URLWithString:strUrl] placeholderImage:[UIImage imageNamed:@"loading"]];
    
}


@end
