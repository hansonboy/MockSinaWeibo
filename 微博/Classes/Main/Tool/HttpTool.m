//
//  HttpTool.m
//  JW微博JW
//
//  Created by wangjianwei on 16/1/16.
//  Copyright © 2016年 JW. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"
@implementation HttpTool
static  AFHTTPRequestOperationManager *HTTPRequestOperationManager;
+(void)initialize{
    if (self == [HttpTool self]) {
        HTTPRequestOperationManager = [AFHTTPRequestOperationManager manager];
    }
}
+(void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [HTTPRequestOperationManager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [HTTPRequestOperationManager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)post:(NSString *)url params:(NSDictionary *)params constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))bodyBlock success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [HTTPRequestOperationManager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        bodyBlock(formData);
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
