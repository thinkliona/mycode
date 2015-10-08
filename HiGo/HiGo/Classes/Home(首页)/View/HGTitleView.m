//
//  HGTitleView.m
//  HiGo
//
//  Created by Think_lion on 15/7/25.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import "HGTitleView.h"

@interface HGTitleView ()
@property (nonatomic,weak) UIButton *button;
@end

@implementation HGTitleView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        //添加3个按钮
        [self setupButton];
    }
    return self;
}

-(void)setupButton
{
    [self addButton:@"精选"];
    [self addButton:@"发现"];
    [self addButton:@"专场"];
}

-(void)addButton:(NSString*)title
{
    UIButton *btn=[[UIButton alloc]init];
    btn.titleLabel.font=HGfont(15);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:HGColor(75, 75, 75) forState:UIControlStateNormal];
    [btn setTitleColor:HGColor(247, 133, 136) forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}


-(void)titleButtonClick:(UIButton*)sender
{
    
    if([self.delegate respondsToSelector:@selector(titleView:scrollToIndex:)]){
        [self.delegate titleView:self scrollToIndex:sender.tag];
    }
    
    self.button.selected=NO;
    self.button.titleLabel.font=HGfont(15);
    sender.selected=YES;
    sender.titleLabel.font=HGfont(18);
    self.button=sender;
}

-(void)wanerSelected:(NSInteger)tagIndex
{
    self.button.selected=NO;
    self.button.titleLabel.font=HGfont(15);
    UIButton *btn=self.subviews[tagIndex];
    btn.selected=YES;
    btn.titleLabel.font=HGfont(18);
    self.button=btn;
}

-(void)layoutSubviews
{
    CGFloat btnY=0;
    int count=(int)self.subviews.count;
    CGFloat btnX=0;
    CGFloat btnW=self.width/count;
    CGFloat btnH=self.height;
    for(int i=0;i<count;i++){
        btnX=btnW*i;
        UIButton *btn=self.subviews[i];
        btn.tag=i;
        btn.frame=CGRectMake(btnX, btnY, btnW, btnH);
    }
}

@end
