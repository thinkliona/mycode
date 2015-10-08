//
//  HGChoiceShowView.m
//  HiGo
//
//  Created by Think_lion on 15/7/27.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import "HGChoiceShowView.h"

#import "HGGoodsFrame.h"
#import "HGGoodsModel.h"
#import "HGGoodsMainImageModel.h"
#import "HGGoodsImageModel.h"
#import "HGGoodsInfoModel.h"

@interface HGChoiceShowView ()

@property (nonatomic,weak) UIImageView *bigImag;
//小图片  第一个
@property (nonatomic,weak) UIImageView *oneImg;
@property (nonatomic,weak) UIImageView *twoImg;
@property (nonatomic,weak) UIImageView *threeImg;

@property (nonatomic,weak) UILabel *descLabel;
@property (nonatomic,weak) UILabel *addressLabel;

@property (nonatomic,strong) NSMutableArray *arrSmallImg; //存放小图片的数组

@end

@implementation HGChoiceShowView

-(NSMutableArray *)arrSmallImg
{
    if(_arrSmallImg==nil) {
        _arrSmallImg=[NSMutableArray array];
    }
    return _arrSmallImg;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        //添加子控件
        [self addChoiceChild];
    }
    return self;
        
}

#pragma mark 添加子控件
-(void)addChoiceChild
{
    //1.添加大得imageView
    UIImageView *bigImag=[[UIImageView alloc]init];
    bigImag.contentMode=UIViewContentModeScaleAspectFill;
    bigImag.clipsToBounds=YES;
    [self addSubview:bigImag];
    self.bigImag=bigImag;
    //2.添加三张小图片
    UIImageView *oneImg=[[UIImageView alloc]init];
    oneImg.contentMode=UIViewContentModeScaleAspectFill;
    oneImg.clipsToBounds=YES;
    [self addSubview:oneImg];
    self.oneImg=oneImg;
    
    UIImageView *twoImg=[[UIImageView alloc]init];
    twoImg.contentMode=UIViewContentModeScaleAspectFill;
    twoImg.clipsToBounds=YES;
    [self addSubview:twoImg];
    self.twoImg=twoImg;
    
    
    UIImageView *threeImg=[[UIImageView alloc]init];
    threeImg.contentMode=UIViewContentModeScaleAspectFill;
    threeImg.clipsToBounds=YES;
    [self addSubview:threeImg];
    self.threeImg=threeImg;
    //3.添加商品描述
    UILabel *descLabel=[[UILabel alloc]init];
    descLabel.textColor=HGColor(75, 75, 75);
    descLabel.numberOfLines=0;
    descLabel.font=HGDescFont;
    [self addSubview:descLabel];
    self.descLabel=descLabel;
    //4.添加地址
    UILabel *address=[[UILabel alloc]init];
    address.textColor=HGColor(164, 164, 164);
    address.font=HGfont(11);
    [self addSubview:address];
    self.addressLabel=address;
    
}


-(void)setGoodsFrame:(HGGoodsFrame *)goodsFrame
{
    _goodsFrame=goodsFrame;
    //如果是显示多张的话  就需要显示多个控件
   
        self.frame=goodsFrame.viewR;
        //1.设置第一张大图片的数组
        [self.bigImag sd_setImageWithURL:[NSURL URLWithString:goodsFrame.goodsModel.main_image.image_original] placeholderImage:[UIImage resizedImage:@"loading"]];
        self.bigImag.frame=goodsFrame.imageF;
        //2.设置3张小图片的frame
        
        NSInteger count=(int)goodsFrame.goodsModel.goods_image.count-1;
        NSInteger tempCount=count;
        //第一张小图片
        HGGoodsImageModel *oneModel=goodsFrame.goodsModel.goods_image[count];
    
        [self.oneImg sd_setImageWithURL:[NSURL URLWithString:oneModel.image_original] placeholderImage:[UIImage imageNamed:@"loading"]];
        self.oneImg.frame=goodsFrame.oneSmallF;

        tempCount--;
        //第二章小图片
        if(tempCount>=0){
            HGGoodsImageModel *twoModel=goodsFrame.goodsModel.goods_image[count-1];
            [self.twoImg sd_setImageWithURL:[NSURL URLWithString:twoModel.image_original] placeholderImage:[UIImage imageNamed:@"loading"]];
            self.twoImg.frame=goodsFrame.twoSmallF;
            tempCount--;
        }else{
            [self.twoImg sd_setImageWithURL:[NSURL URLWithString:oneModel.image_original] placeholderImage:[UIImage imageNamed:@"loading"]];
            self.twoImg.frame=goodsFrame.twoSmallF;
        }
    
        //第三章小图片
        if(tempCount>=0){
            HGGoodsImageModel *threeModel=goodsFrame.goodsModel.goods_image[count-2];
            [self.threeImg sd_setImageWithURL:[NSURL URLWithString:threeModel.image_original] placeholderImage:[UIImage imageNamed:@"loading"]];
            self.threeImg.frame=goodsFrame.threeSmallF;
        }else{
            [self.threeImg sd_setImageWithURL:[NSURL URLWithString:oneModel.image_original] placeholderImage:[UIImage imageNamed:@"loading"]];
            self.threeImg.frame=goodsFrame.threeSmallF;
        }
        
        //3.设置描述的frame
        
        self.descLabel.text=goodsFrame.goodsModel.goods_name;
        self.descLabel.frame=goodsFrame.descF;
        //4.设置地址的frame
        NSString *addressStr=[NSString stringWithFormat:@"%@,%@",goodsFrame.goodsModel.group_info.country,goodsFrame.goodsModel.group_info.city];
        //设置样式
        [self setupAddressLabelWithStr:addressStr];
        self.addressLabel.frame=goodsFrame.addressF;

    }
#pragma mark 设置setupDescLabel
-(void)setupAddressLabelWithStr:(NSString*)str
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    // 创建图片图片附件
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:@"localG"];
    attach.bounds = CGRectMake(0, -1, 10, 10);
    NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
    [string appendAttributedString:attachString];
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:str]];
    self.addressLabel.attributedText=string;
}


    




@end
