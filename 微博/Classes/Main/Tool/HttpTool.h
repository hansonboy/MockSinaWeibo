//
//  HttpTool.h
//  JW微博JW
//
//  Created by wangjianwei on 16/1/16.
//  Copyright © 2016年 JW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFURLRequestSerialization.h"
@interface HttpTool : NSObject

+(void)get:(NSString*)url params:(NSDictionary*)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
+(void)post:(NSString*)url params:(NSDictionary*)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
+(void)post:(NSString*)url params:(NSDictionary*)params constructingBodyWithBlock:(void(^)(id<AFMultipartFormData> formData))bodyBlock success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
@end
