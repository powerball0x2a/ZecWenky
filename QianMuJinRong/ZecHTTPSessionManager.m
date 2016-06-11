//
//  ZecHTTPSessionManager.m
//  QianMuJinRong
//
//  Created by Zec on 16/6/11.
//  Copyright © 2016年 Zec. All rights reserved.
//

#import "ZecHTTPSessionManager.h"

@implementation ZecHTTPSessionManager

- (void)ZECSuccess:(NSDictionary *)responseObject
         operation:(NSURLSessionDataTask *)operation
           success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
           failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    
    if ([[responseObject objectForKey:@"code" ] isEqualToString:@"10000"]) {
        success(operation, responseObject);
    } else {
        
        NSError *err = [NSError errorWithDomain:@"error" code:9999 userInfo:responseObject];
        failure(operation, err);
    }
}

- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration
{
    NSURL *baseUrl = url;
    self = [super initWithBaseURL:baseUrl sessionConfiguration:configuration];

    self.securityPolicy = [self securityPolicy:@"https"];

    
    NSMutableSet *mutableContentTypes = [[NSMutableSet alloc] initWithSet:self.responseSerializer.acceptableContentTypes copyItems:YES];
    [mutableContentTypes unionSet:[NSSet setWithObjects:@"application/json",@"text/html",nil]];
    self.responseSerializer.acceptableContentTypes = mutableContentTypes;
    
    return self;
}

- (AFSecurityPolicy *)securityPolicy:(NSString *)certName
{
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // 设置可以接收无效的证书
    [securityPolicy setAllowInvalidCertificates:YES];
    // 设置不检测整个证书链，只要其中一个正确即可
    securityPolicy.validatesDomainName = NO;
    //证书的路径
    NSString *certPath = [[NSBundle mainBundle] pathForResource:certName ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:certPath];
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:certData, nil];
    
    return securityPolicy;
}

#pragma mark - 网络请求

- (NSURLSessionDataTask *)ZECGET:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure {
    
        NSURLSessionDataTask *task = [self GET:URLString
                                parameters:parameters
                                  progress:nil
                                   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                       [self ZECSuccess:responseObject
                                              operation:task
                                                success:success
                                                failure:failure];
                                   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                       failure(task, error);
                                   }];
    return task;
}

- (NSURLSessionDataTask *)ZECPOST:(NSString *)URLString
                       parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))success
                          failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    
    NSURLSessionDataTask *task = [self POST:URLString
                                 parameters:parameters
                                   progress:nil
                                    success:^(NSURLSessionDataTask *operation, id responseObject) {
                                        [self ZECSuccess:responseObject
                                               operation:task
                                                 success:success
                                                 failure:failure];
                                    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                                        failure(operation, error);
                                    }];
    return task;
}

- (NSURLSessionDataTask *)ZECPOST:(NSString *)URLString
                 timeoutInterval:(NSInteger)timeoutInterval
                      parameters:(id)parameters
                         success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{

    NSMutableURLRequest *request = nil;
    request = [self.requestSerializer requestWithMethod:@"POST"
                                              URLString:URLString
                                             parameters:parameters
                                                  error:nil];
    request.timeoutInterval = timeoutInterval;
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self dataTaskWithRequest:request
                          uploadProgress:nil
                        downloadProgress:nil
                       completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
                           if (error) {
                               failure(dataTask, error);
                           } else {
                               [self ZECSuccess:responseObject
                                     operation:dataTask
                                       success:success
                                       failure:failure];
                           }
                       }];
    
    [dataTask resume];
    return dataTask;
}

- (NSURLSessionDataTask *)ZECPOSTImg:(NSString *)URLString
                         parameters:(id)parameters
                              image:(UIImage *)image
                            success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                            failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    NSURLSessionDataTask *operation = [self POST:URLString
                                      parameters:parameters
                       constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                           if (image) {
                               NSData *headData = UIImageJPEGRepresentation(image, 0.5);
                               [formData appendPartWithFileData:headData name:@"headPic" fileName:@"123.png" mimeType:@"image/jpg"];
                           }
                       } progress:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
                           [self ZECSuccess:responseObject
                                 operation:operation
                                   success:success
                                   failure:failure];
                       } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                           failure(operation, error);
                       }];
    
    return operation;
}

- (NSURLSessionDataTask *)ZECPOSTData:(NSString *)URLString
                          parameters:(id)parameters
                             dataKey:(NSString *)key
                            fileName:(NSString *)fileName
                                data:(NSData *)data
                             success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                             failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    NSURLSessionDataTask *operation = [self POST:URLString
                                      parameters:parameters
                       constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                           if (data.length > 0) {
                               [formData appendPartWithFileData:data name:key fileName:fileName mimeType:@"image/jpg"];
                           }
                       } progress:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
                           [self ZECSuccess:responseObject
                                 operation:operation
                                   success:success
                                   failure:failure];
                       } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                           failure(operation, error);
                       }];
    
    return operation;
}



@end
