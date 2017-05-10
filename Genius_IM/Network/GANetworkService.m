//
//  GANetworkService.m
//  Genius_IM
//
//  Created by Graphic-one on 17/1/24.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "GANetworkService.h"

@interface _GARequestModel : NSObject{
    @package
    NSString* _path;
    NSString* _realityPara;//json
    NSString* _realityDesc;//json_desc
    
    @private
    NSDictionary* _Nullable _paraDic;
    NSString* _Nullable _httpBody;
}
+ (nullable instancetype)requestModel:(RequestType)requestType path:(NSString* )path para:(NSDictionary* )para;
@end

@implementation _GARequestModel
+ (instancetype)requestModel:(RequestType)requestType path:(NSString *)path para:(NSDictionary* )para{
    if (!path && !para) return nil;
#warning TODO : It is not yet supported 'RequestType_FROM' and 'RequestType_URL' ...
    if (requestType == RequestType_FROM || requestType == RequestType_URL) return nil;
    
    _GARequestModel* model = [[_GARequestModel alloc] init];
   
    model->_path = path;
    NSData* data = [NSJSONSerialization dataWithJSONObject:para options:NSJSONWritingPrettyPrinted error:NULL];
    model->_realityPara = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ?: @"";
    model->_realityDesc = model->_realityPara.hash ? [NSString stringWithFormat:@"%lu",(unsigned long)model->_realityPara.hash] : @"";
    
    /** save code
    [mStr appendString:@"{"];
    [para.allKeys enumerateObjectsUsingBlock:^(NSString* _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        if (para[key] == (id)kCFNull) return  ;

        [mStr appendString:[NSString stringWithFormat:@"%@:%@",[key encodeURL],[para[key] encodeURL]]];
        
        if (idx != (para.allKeys.count - 1)) [mStr appendString:@"&"];
    }];
    [mStr appendString:@"}"];
    */
    
    return model;
}

@end


@implementation GANetworkService

+ (instancetype)ShareNetworkService{
    static GANetworkService* _networkService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _networkService = [[GANetworkService alloc] initWithBaseURL:[NSURL URLWithString:kStandard_base_url]];
        [_networkService.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [_networkService.requestSerializer setValue:[NSString UA] forHTTPHeaderField:@"User-Agent"];
    });
    return _networkService;
}

- (void)sendRequestWithPath:(NSString *)path
                  paramater:(NSDictionary* )paramaters
                     method:(MethodType)method
                   complete:(completeBlock)block
                  cacheType:(SandboxCacheType)cacheType
{
    if (!path || path == (id)kCFNull) return;
    
    [self sendRequestWithPath:path paramater:paramaters method:method complete:block cacheType:cacheType requestType:RequestType_JSON_HTTP_BODY];
}

- (void)sendRequestWithPath:(NSString *)path
                  paramater:(NSDictionary* )paramaters
                     method:(MethodType)method
                   complete:(completeBlock)block
                  cacheType:(SandboxCacheType)cacheType
                requestType:(RequestType)requestType
{
    if (!path || path == (id)kCFNull) return;

    _GARequestModel* model = [_GARequestModel requestModel:requestType path:path para:paramaters];
    
    DDLogDebug(@"%@",[NSString stringWithFormat:@"**** request start ****\n method:%@\n path:%@\n paramaterDesc:%@\n paramater:%@\n",[[self _methods] objectAtIndex:method],model->_path,model->_realityDesc,model->_realityPara]);
    
    switch (method) {
        case GET:{
            NSString* resource = [NSObject cacheResourceNameWithURL:model->_path parameterDictionaryDesc:model->_realityDesc];
            __block NSError* err = nil;
            [self GET:model->_path parameters:model->_realityPara
             progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable responseObject) {
                  
                  DDLogDebug(@"%@",[NSString stringWithFormat:@"**** request success ****\n path:%@\n paramaterDesc:%@\n responseObject:%@\n ",model->_path,model->_realityDesc,responseObject]);
                  
                  if ([responseObject[@"code"] integerValue] == ResultCodeSuccess) {
                      id result = responseObject[@"result"];
                      if (result) {
                          [NSObject handleResponseObject:result resource:resource cacheType:cacheType];
                          block(result,err);
                      }else{
                          err = [NSError errorWithDomain:NSCocoaErrorDomain code:ResultCodeSuccess userInfo:@{NSLocalizedDescriptionKey : @"result is nil"}];
                          block([NSObject responseObjectWithResource:resource cacheType:cacheType],err);
                      }
                  }else{
                      err = [NSError errorWithDomain:NSCocoaErrorDomain code:[responseObject[@"code"] integerValue] userInfo:@{NSLocalizedDescriptionKey : @"code is not ResultCodeSuccess"}];
                      block([NSObject responseObjectWithResource:resource cacheType:cacheType],err);
                  }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                DDLogDebug(@"%@",[NSString stringWithFormat:@"**** request failure ****\n path:%@\n paramaterDesc:%@\n error:%@\n ",model->_path,model->_realityDesc,error]);

                block([NSObject responseObjectWithResource:resource cacheType:cacheType],error);
            }];
            
            break;
        }
            
        case POST:{
            [self POST:model->_path parameters:model->_realityPara
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable responseObject) {
                   
                   DDLogDebug(@"%@",[NSString stringWithFormat:@"**** request success ****\n path:%@\n paramaterDesc:%@\n responseObject:%@\n ",model->_path,model->_realityDesc,responseObject]);

                   if ([responseObject[@"code"] integerValue] == ResultCodeSuccess) {
                       block(responseObject[@"result"],nil);
                   }else{
                       block(responseObject[@"result"],[NSError errorWithDomain:NSCocoaErrorDomain code:[responseObject[@"code"] integerValue] userInfo:@{NSLocalizedDescriptionKey : @"code is not ResultCodeSuccess"}]);
                   }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                DDLogDebug(@"%@",[NSString stringWithFormat:@"**** request failure ****\n path:%@\n paramaterDesc:%@\n error:%@\n ",model->_path,model->_realityDesc,error]);

                block(nil,error);
            }];
            
            break;
        }
            
        case PUT:{
            [self PUT:model->_path parameters:model->_realityPara
              success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable responseObject) {
                  
                  DDLogDebug(@"%@",[NSString stringWithFormat:@"**** request success ****\n path:%@\n paramaterDesc:%@\n responseObject:%@\n ",model->_path,model->_realityDesc,responseObject]);

                  if ([responseObject[@"code"] integerValue] == ResultCodeSuccess) {
                      block(responseObject[@"result"],nil);
                  }else{
                      block(responseObject[@"result"],[NSError errorWithDomain:NSCocoaErrorDomain code:[responseObject[@"code"] integerValue] userInfo:@{NSLocalizedDescriptionKey : @"code is not ResultCodeSuccess"}]);
                  }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                DDLogDebug(@"%@",[NSString stringWithFormat:@"**** request failure ****\n path:%@\n paramaterDesc:%@\n error:%@\n ",model->_path,model->_realityDesc,error]);

                block(nil,error);
            }];
            
            break;
        }
            
        case DELETE:{
            [self DELETE:model->_path parameters:model->_realityPara
                 success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable responseObject) {
                     
                     DDLogDebug(@"%@",[NSString stringWithFormat:@"**** request success ****\n path:%@\n paramaterDesc:%@\n responseObject:%@\n ",model->_path,model->_realityDesc,responseObject]);

                     if ([responseObject[@"code"] integerValue] == ResultCodeSuccess) {
                         block(responseObject[@"result"],nil);
                     }else{
                         block(responseObject[@"result"],[NSError errorWithDomain:NSCocoaErrorDomain code:[responseObject[@"code"] integerValue] userInfo:@{NSLocalizedDescriptionKey : @"code is not ResultCodeSuccess"}]);
                     }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                DDLogDebug(@"%@",[NSString stringWithFormat:@"**** request failure ****\n path:%@\n paramaterDesc:%@\n error:%@\n ",model->_path,model->_realityDesc,error]);

                block(nil,error);
            }];
            
            break;
        }
            
        default:
            break;
    }
}

- (void)sendRequestWithPath:(NSString *)path
                   filePath:(NSString* )filePath
                  paramater:(NSDictionary* )paramaters
                     method:(MethodType)method
                   complete:(completeBlock)block
{
    
}

#pragma mark - read methods 
- (NSArray* )_methods{
    return @[@"GET",@"POST",@"PUT",@"DELETE"];
}

@end















