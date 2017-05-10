//
//  GANetworkService.h
//  Genius_IM
//
//  Created by Graphic-one on 17/1/24.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <AFNetworking.h>
#import "GAApis.h"

#import "NSObject+Collection.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^completeBlock)(NSData* _Nullable  data , NSError* _Nullable error);

typedef NS_ENUM(NSUInteger,RequestType){
    RequestType_JSON_HTTP_BODY = 0,
    RequestType_FROM           = 1,
    RequestType_URL            = 2,
};

typedef NS_ENUM(NSUInteger,MethodType){
    GET     = 0,
    POST    = 1,
    PUT     = 2,
    DELETE  = 3,
};

@interface GANetworkService : AFHTTPSessionManager

+ (instancetype)ShareNetworkService;

- (void)sendRequestWithPath:(nullable NSString* )path
                  paramater:(nullable NSDictionary* )paramaters
                     method:(MethodType)method
                   complete:(completeBlock)block
                  cacheType:(SandboxCacheType)cacheType;

- (void)sendRequestWithPath:(nullable NSString* )path
                  paramater:(nullable NSDictionary* )paramaters
                     method:(MethodType)method
                   complete:(completeBlock)block
                  cacheType:(SandboxCacheType)cacheType
                requestType:(RequestType)requestType;

- (void)sendRequestWithPath:(nullable NSString* )path
                   filePath:(nullable NSString* )filePath
                  paramater:(nullable NSDictionary* )paramaters
                     method:(MethodType)method
                   complete:(completeBlock)block;

@end


NS_ASSUME_NONNULL_END





