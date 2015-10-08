//
//  HGHttpTool.h
//  HiGo
//
//  Created by Think_lion on 15/7/26.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGHttpTool : NSObject

+(void)getWirhUrl:(NSString*)url parms:(NSDictionary*)parms success:(void(^)(id json))success failture:(void(^)(id error))failture;



@end
