//
//  HGCategoryCell.m
//  HiGo
//
//  Created by Think_lion on 15/7/27.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import "HGCategoryCell.h"
#import "HGCategoryModel.h"
#import "HGImageModel.h"

@interface HGCategoryCell ()

@property (nonatomic,weak) UIImageView *imageView;
@property (nonatomic,weak) UILabel *labelStr;

@end

@implementation HGCategoryCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        //1.添加collectionview
        [self addChildView];
    }
    return self;
}

#pragma mark 添加子控件
-(void)addChildView
{
    //1.添加图片
    UIImageView *imageView=[[UIImageView alloc]init];
    imageView.frame=self.bounds;
    imageView.layer.cornerRadius=5;
    imageView.clipsToBounds=YES;
    [self.contentView addSubview:imageView];
    self.imageView=imageView;
    //2.添加文字标签
    UILabel *label=[[UILabel alloc]init];
    label.x=0;
    label.height=30;
    label.width=self.width;
    label.y=self.height-label.height;
    
    label.textColor=[UIColor whiteColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont boldSystemFontOfSize:14];
    [self.contentView addSubview:label];
    self.labelStr=label;
}

-(void)setCateModel:(HGCategoryModel *)cateModel
{
    _cateModel=cateModel;
    //NSLog(@"%@   %@",cateModel.name,cateModel.image.image_original);
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:cateModel.image.image_original] placeholderImage:[UIImage resizedImage:@"loading"]];
    //设置标签的 文字
    self.labelStr.text=cateModel.name;
    
}


@end
