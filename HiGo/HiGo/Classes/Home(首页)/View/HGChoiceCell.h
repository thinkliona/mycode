//
//  HGChoiceCell.h
//  HiGo
//
//  Created by Think_lion on 15/7/27.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HGGoodsFrame;

@interface HGChoiceCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView indentifier:(NSString *)indentifier;

@property (nonatomic,strong) HGGoodsFrame *goodsFrame;

@end
