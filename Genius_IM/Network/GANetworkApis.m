//
//  GANetworkApis.m
//  Genius_IM
//
//  Created by Graphic-one on 17/3/1.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "GANetworkApis.h"
#import <objc/runtime.h>
#import "NSObject+Collection.h"

#import "GAModelHelper.h"
#import "GALogIn.h"
#import "GARegister.h"

static NSString* const GANetworkApisKey = @"GANetworkApisKey";

@implementation GANetworkApis

+ (instancetype)shareNetworkApis{
    static GANetworkApis* _shareNetworkApis;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareNetworkApis = [GANetworkApis new];
        objc_setAssociatedObject(_shareNetworkApis, &GANetworkApisKey, [GANetworkService ShareNetworkService], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    });
    return _shareNetworkApis;
}


- (void)loginRequest:(GALogIn* )loginModel
            complete:(complete)block
{
    GANetworkService* curService = objc_getAssociatedObject(self, &GANetworkApisKey);
    
    [NSObject showHUD:loginTip];
    [curService sendRequestWithPath:kLogin paramater:[loginModel GA_modelToJSONObject] method:POST complete:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error) {
            
        }else{

        }
        [NSObject hideAllHUD];
    } cacheType:SandboxCacheTypeNone];
}

- (void)registerRequest:(GARegister* )registerModel
               complete:(complete)block
{
    GANetworkService* curService = objc_getAssociatedObject(self, &GANetworkApisKey);

    [NSObject showHUD:registerTip];
    [curService sendRequestWithPath:kRegister paramater:[registerModel GA_modelToJSONObject] method:POST complete:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error) {

        }else{

        }
        [NSObject hideAllHUD];
    } cacheType:SandboxCacheTypeNone];
}

@end































#pragma mark - DSL IMP

NSString* const baseUrlkey                  = @"baseUrlkey";
NSString* const stringEncodingKey           = @"stringEncodingKey";
NSString* const timeoutIntervalKey          = @"timeoutIntervalKey";
NSString* const HTTPShouldHandleCookiesKey  = @"HTTPShouldHandleCookies";
NSString* const HTTPHeaderFieldKey          = @"HTTPHeaderFieldKey";

@implementation GANetworkApis (DSL)

@dynamic baseURL,stringEncoding,timeoutInterval,HTTPShouldHandleCookies;

- (instancetype)init{
    self = [super init];
    if (self) {
        @weakify(self)
        _requestStringEncoding = ^GANetworkApis* (NSStringEncoding stringEncoding){
            @strongify(self)
            objc_setAssociatedObject(self, &stringEncodingKey, @(stringEncoding), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return self;
        };
        _requestTimeoutInterval = ^GANetworkApis* (NSUInteger timeoutInterval){
            @strongify(self)
            objc_setAssociatedObject(self, &timeoutIntervalKey, @(timeoutInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return self;
        };
        _requestHTTPShouldHandleCookies = ^GANetworkApis* (BOOL HTTPShouldHandleCookies){
            @strongify(self)
            objc_setAssociatedObject(self, &HTTPShouldHandleCookiesKey, @(HTTPShouldHandleCookies), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return self;
        };
        _requestHTTPHeaderField = ^GANetworkApis* (NSDictionary* HTTPHeaderField){
            @strongify(self)
            objc_setAssociatedObject(self, &HTTPHeaderFieldKey, HTTPHeaderField, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return self;
        };
    }
    return self;
}

- (GANetworkApis *)end{
    GANetworkService* tmpService = [[GANetworkService alloc] initWithBaseURL:self.baseURL];
    tmpService.requestSerializer.stringEncoding = self.stringEncoding;
    tmpService.requestSerializer.timeoutInterval = self.timeoutInterval;
    tmpService.requestSerializer.HTTPShouldHandleCookies = self.HTTPShouldHandleCookies;
    [tmpService.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [tmpService.requestSerializer setValue:[NSString UA] forHTTPHeaderField:@"User-Agent"];
    [self.HTTPHeaderField.allKeys enumerateObjectsUsingBlock:^(NSString*  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        [tmpService.requestSerializer setValue:self.HTTPHeaderField[key] forHTTPHeaderField:key];
    }];
    objc_setAssociatedObject(self, &GANetworkApisKey, tmpService, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return self;
}

- (NSURL *)baseURL{
    return objc_getAssociatedObject(self, &baseUrlkey);
}
- (void)setBaseURL:(NSURL *)baseURL{
    objc_setAssociatedObject(self, &baseUrlkey, baseURL, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSStringEncoding)stringEncoding{
    return [objc_getAssociatedObject(self, &stringEncodingKey) integerValue];
}
- (NSUInteger)timeoutInterval{
    return [objc_getAssociatedObject(self, &timeoutIntervalKey) integerValue];
}
- (BOOL)HTTPShouldHandleCookies{
    return [objc_getAssociatedObject(self, &HTTPShouldHandleCookiesKey) integerValue];
}
- (NSDictionary *)HTTPHeaderField{
    return objc_getAssociatedObject(self, &HTTPHeaderFieldKey);
}

@end







