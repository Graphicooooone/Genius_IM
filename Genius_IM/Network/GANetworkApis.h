//
//  GANetworkApis.h
//  Genius_IM
//
//  Created by Graphic-one on 17/3/1.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GANetworkService.h"

typedef NS_ENUM(NSUInteger,RequestWaitStyle){
    RequestWaitStyleNone         ,
    RequestWaitStyleHUD          ,
    RequestWaitStyleStatus       ,
};

/** result model*/
@class GAModel;

/** parameter models */
@class GALogIn,GARegister;

@interface GANetworkApis<T> : NSObject

typedef void(^complete)(T model, NSError* error);

+ (instancetype)shareNetworkApis;

- (void)loginRequest:(GALogIn* )loginModel complete:(complete)block;

- (void)registerRequest:(GARegister* )registerModel complete:(complete)block;







/**
using DSL make tmp netWorkApi  ...
 
such as
MakeNetNetworkApi(@"peter.com").requestStringEncoding(NSASCIIStringEncoding).requestTimeoutInterval(20).requestHTTPShouldHandleCookies(YES).end  
 */
@property (nonatomic,copy) GANetworkApis* (^requestStringEncoding)(NSStringEncoding stringEncoding);
@property (nonatomic,copy) GANetworkApis* (^requestTimeoutInterval)(NSUInteger timeoutInterval);
@property (nonatomic,copy) GANetworkApis* (^requestHTTPShouldHandleCookies)(BOOL HTTPShouldHandleCookies);
@property (nonatomic,copy) GANetworkApis* (^requestHTTPHeaderField)(NSDictionary* HTTPHeaderField);
@property (nonatomic,copy) GANetworkApis* end;

@end































#pragma mark - DSL IMP

FOUNDATION_EXTERN NSString* const baseUrlkey;
FOUNDATION_EXTERN NSString* const stringEncodingKey;
FOUNDATION_EXTERN NSString* const timeoutIntervalKey;
FOUNDATION_EXTERN NSString* const HTTPShouldHandleCookiesKey;
FOUNDATION_EXTERN NSString* const HTTPHeaderFieldKey;

@interface GANetworkApis (DSL)

@property (nonatomic,strong) NSURL *baseURL;

@property (nonatomic,assign,readonly) NSStringEncoding stringEncoding;

@property (nonatomic,assign,readonly) NSUInteger timeoutInterval;

@property (nonatomic,assign,readonly) BOOL HTTPShouldHandleCookies;

@property (nonatomic,strong,readonly) NSDictionary* HTTPHeaderField;

@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-function"

#define MakeNetNetworkApi(str) ga_alloc(str)

static GANetworkApis* ga_alloc(NSString* str){
    GANetworkApis* newApi = [[GANetworkApis alloc] init];
    NSURL* url = [NSURL URLWithString:str];
    newApi.baseURL = url;
    return newApi;
}

#pragma clang diagnostic pop







