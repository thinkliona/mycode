//
//  HGBaseMethod.h
//  HiGo
//
//  Created by Think_lion on 15/7/26.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGBaseMethod : NSObject

//网络请求的GET方法
+(void)get:(NSString*)url parms: (NSDictionary*)parms success:(void(^)(id json)) success failture:(void(^)(id json)) failture;
//网络请求的POST方法
+(void)post:(NSString*)url parms: (NSDictionary*)parms success:(void(^)(id json)) success failture:(void(^)(id json)) failture;

@end
