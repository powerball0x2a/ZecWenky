//
//  ZecHTTPSessionManager.h
//  QianMuJinRong
//
//  Created by Zec on 16/6/11.
//  Copyright © 2016年 Zec. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface ZecHTTPSessionManager : AFHTTPSessionManager


//  GET请求
- (NSURLSessionDataTask *)ZECGET:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
//  POST请求
- (NSURLSessionDataTask *)ZECPOST:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//  POST超时请求
- (NSURLSessionDataTask *)ZECPOST:(NSString *)URLString
                  timeoutInterval:(NSInteger)timeoutInterval
                       parameters:(id)parameters
                          success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//  POST图片
- (NSURLSessionDataTask *)ZECPOSTImg:(NSString *)URLString
                          parameters:(id)parameters
                               image:(UIImage *)image
                             success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                             failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//  POST数据
- (NSURLSessionDataTask *)ZECPOSTData:(NSString *)URLString
                           parameters:(id)parameters
                              dataKey:(NSString *)key
                             fileName:(NSString *)fileName
                                 data:(NSData *)data
                              success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                              failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

@end
