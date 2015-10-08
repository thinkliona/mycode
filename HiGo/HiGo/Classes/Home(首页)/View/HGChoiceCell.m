//
//  HGChoiceCell.m
//  HiGo
//
//  Created by Think_lion on 15/7/27.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import "HGChoiceCell.h"
#import "HGGoodsFrame.h"
#import "HGChoiceShowView.h"

@interface HGChoiceCell ()

@property (nonatomic,weak) HGChoiceShowView *choiceView;

@end 

@implementation HGChoiceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        [self addChild];
    }
    return self;
}

-(void)addChild
{
    HGChoiceShowView *choiceShow=[[HGChoiceShowView alloc]init];
    choiceShow.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:choiceShow];
    self.choiceView=choiceShow;
    
    UIView *v=[[UIView alloc]init];
    v.backgroundColor=HGColor(237, 237, 237);
    self.backgroundView=v;
    //取消选中样式
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
}

+(instancetype)cellWithTableView:(UITableView *)tableView indentifier:(NSString *)indentifier
{
    HGChoiceCell *cell=[tableView dequeueReusableCellWithIdentifier:indentifier];
    if(cell==nil){
        cell=[[HGChoiceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    return cell;
}



-(void)setGoodsFrame:(HGGoodsFrame *)goodsFrame
{
    self.choiceView.goodsFrame=goodsFrame;
}


@end
