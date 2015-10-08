//
//  HGBaseMethod.m
//  HiGo
//
//  Created by Think_lion on 15/7/26.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import "HGBaseMethod.h"
#import "AFNetworking.h"

@implementation HGBaseMethod

+(void)get:(NSString *)url parms:(NSDictionary *)parms success:(void (^)(id))success failture:(void (^)(id))failture
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    [manager GET:url parameters:parms success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(success){
            success(responseObject);  //   void(^)(id json)
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failture){
            failture(error);
        }
    }];

}

+(void)post:(NSString *)url parms:(NSDictionary *)parms success:(void (^)(id))success failture:(void (^)(id))failture
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:parms success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(success){
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failture){
            failture(error);
        }
    }];
}

@end
