//
//  HGTabView.m
//  HiGo
//
//  Created by Think_lion on 15/7/25.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import "HGTabView.h"
#import "HGTabButton.h"

@interface HGTabView ()

@property (nonatomic,weak) HGTabButton *button;

@end

@implementation HGTabView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        
    }
    return self;
}


-(void)addTabItem:(UITabBarItem *)item
{
    HGTabButton *tabButton=[[HGTabButton alloc]init];
    tabButton.item=item;
    [tabButton addTarget:self action:@selector(tabButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:tabButton];
    //如果是第一个的话  就选中
    if(self.subviews.count==1){
        [self tabButtonClick:tabButton];
    }
   
}


#pragma mark 按钮的点击事件
-(void)tabButtonClick:(HGTabButton*)sender
{
    

    if([self.delegate respondsToSelector:@selector(tabView:didSelectedFrom:toIndex:)]){
        [self.delegate tabView:self didSelectedFrom:self.button.tag toIndex:sender.tag];
    }
    self.button.selected=NO;
    sender.selected=YES;
    self.button=sender;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    int count=(int)self.subviews.count;
    CGFloat btnY=0;
    CGFloat btnX=0;
    CGFloat btnH=self.height;
    CGFloat btnW=ScreenWidth/count;
    for(int i=0;i<count;i++){
        btnX=i*btnW;
        HGTabButton *btn=self.subviews[i];
        btn.tag=i;
        btn.frame=CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    
}


@end
