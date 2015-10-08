//
//  HGHttpTool.m
//  HiGo
//
//  Created by Think_lion on 15/7/26.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import "HGHttpTool.h"

@implementation HGHttpTool


+(void)getWirhUrl:(NSString *)url parms:(NSDictionary *)parms success:(void (^)(id))success failture:(void (^)(id))failture
{
    [HGBaseMethod get:url parms:parms success:^(id json) {
        //缓存数据
        NSArray *categoryList= json[@"data"][@"category_list"];
        NSArray *tempGoods = json[@"data"][@"goods_list"];
        
        if(success){
            success(json);
        }
    } failture:^(id json) {
        if(failture){
            failture(json);
        }
    }];
}


@end
