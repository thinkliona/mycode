//
//  HGTabButton.m
//  HiGo
//
//  Created by Think_lion on 15/7/25.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import "HGTabButton.h"

@implementation HGTabButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        
    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted{}


-(void)setItem:(UITabBarItem *)item
{
    _item=item;
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    
}




@end
