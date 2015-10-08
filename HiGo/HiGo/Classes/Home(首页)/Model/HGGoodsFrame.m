//
//  HGGoodsFrame.m
//  HiGo
//
//  Created by Think_lion on 15/7/27.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import "HGGoodsFrame.h"
#import "HGGoodsImageModel.h"
#import "HGGoodsModel.h"
#import "HGGoodsInfoModel.h"
#import "HGGoodsImageModel.h"

#define justOneBigImageH 240
#define moreImageH 150
#define smallImageH 100
#define marginW 5

@implementation HGGoodsFrame


-(void)setGoodsModel:(HGGoodsModel *)goodsModel
{
    _goodsModel=goodsModel;
    //1.显示多张图片
    if(goodsModel.goods_image.count<6){
        //1.第一张图片的frame
        CGFloat imageX=0;
        CGFloat imageY=0;
        CGFloat imageW=ScreenWidth;
        CGFloat imageH=moreImageH;
        _imageF=CGRectMake(imageX, imageY, imageW, imageH);
        //2.设置小图片的frame
        CGFloat smallImgY=CGRectGetMaxY(_imageF)+marginW;
        CGFloat smallImgW=(ScreenWidth-marginW*2)/3;
        CGFloat smallImgH=smallImageH;
        CGFloat oneX=0;
        _oneSmallF=CGRectMake(oneX, smallImgY, smallImgW, smallImgH);
        //3.第二张小图片
        CGFloat twoX=CGRectGetMaxX(_oneSmallF)+marginW;
        _twoSmallF=CGRectMake(twoX, smallImgY, smallImgW, smallImgH);
        //4.第三章小图片
        CGFloat threeX=CGRectGetMaxX(_twoSmallF)+marginW;
        _threeSmallF=CGRectMake(threeX, smallImgY, smallImgW, smallImgH);
        //5.设置标签文字的frame
        CGFloat labelOriginW=ScreenWidth-20;
        CGSize finalSize=[goodsModel.goods_name boundingRectWithSize:CGSizeMake(labelOriginW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:HGDescFont} context:nil].size;
        
        
        
        CGFloat descX=10;
        CGFloat descY=CGRectGetMaxY(_oneSmallF)+20;
        _descF=CGRectMake(descX, descY, finalSize.width, finalSize.height);
        //6.设置地址的frame
        CGFloat addressX=20;
        CGFloat addressY=CGRectGetMaxY(_descF)+5;
        _addressF=CGRectMake(addressX, addressY, 120, 20);
        
        _viewR=CGRectMake(0, 0, ScreenWidth, CGRectGetMaxY(_addressF)+10);
        //7.设置单元格的高度
        _cellH=CGRectGetMaxY(_viewR)+20;

    }else{  //显示一张图片
        //1.第一张图片的frame
        CGFloat imageX=0;
        CGFloat imageY=0;
        CGFloat imageW=ScreenWidth;
        CGFloat imageH=justOneBigImageH;
        _imageF=CGRectMake(imageX, imageY, imageW, imageH);
        
        _viewR=CGRectMake(imageX, imageY, imageW, imageH);
        _cellH=CGRectGetMaxY(_viewR)+20;
        
    }
    
}




@end
