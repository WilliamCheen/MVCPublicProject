//
//  TTImageManager.m
//  WilliamProject
//
//  Created by WilliamChen on 15/11/11.
//  Copyright © 2015年 WilliamChen. All rights reserved.
//

#import "TTImageManager.h"
#import <AliyunOSSiOS/OSSService.h>

static NSString * const AccessKey = @"qVE087P8WqDR3ICO";
static NSString * const SecretKey = @"sYWjcT8nk2YGHs34CIISdgg7mplBdi";
static NSString * const endPoint  = @"http://oss-cn-shanghai.aliyuncs.com";
static NSString * const multipartUploadKey = @"multipartUploadObject";

@interface TTImageManager ()
@property (nonatomic, strong) OSSClient   *client;
@end

@implementation TTImageManager

+ (instancetype)manager{
    static TTImageManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TTImageManager alloc]init];
    });
    return manager;
}


#pragma mark -Setters And Getters

- (OSSClient *)client{
    if (_client == nil) {
        id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc]initWithPlainTextAccessKey:AccessKey secretKey:SecretKey];
        OSSClientConfiguration * conf = [OSSClientConfiguration new];
        conf.maxRetryCount = 3;
        conf.enableBackgroundTransmitService = YES; // 是否开启后台传输服务，目前，开启后，只对上传任务有效
        conf.timeoutIntervalForRequest = 15;
        conf.timeoutIntervalForResource = 24 * 60 * 60;
        
        _client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential clientConfiguration:conf];
    }
    return _client;
}


@end
