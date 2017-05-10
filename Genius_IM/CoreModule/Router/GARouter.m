//
//  GARouter.m
//  Genius_IM
//
//  Created by Peter Gra on 2017/5/3.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "GARouter.h"
#import "UIViewController+Collection.h"

#import <MGJRouter.h>
#import <objc/runtime.h>

static NSString* const jumpType = @"GARouter";

NSString* const RouterMsgLoginCtr       = @"gra://router/ctr/login";
NSString* const RouterMsgRegisterCtr    = @"gra://router/ctr/register";
NSString* const RouterMsgListCtr        = @"gra://router/ctr/msgList";
NSString* const RouterMsgChatCtr        = @"gra://router/ctr/msgChat";
NSString* const RouterUserDetailtCtr    = @"gra://router/ctr/userDetail";

@implementation GARouter

+ (void)load{
    ///< login & register
    [MGJRouter registerURLPattern:RouterMsgLoginCtr toHandler:^(NSDictionary *routerParameters) {
        BOOL isPush = [routerParameters[MGJRouterParameterUserInfo][jumpType] boolValue];
        
        NSLog(@"isPush = %d , ctr = %@",isPush,RouterMsgLoginCtr); 
        RouterComplete block = routerParameters[MGJRouterParameterCompletion];
        if (block) {
            block(routerParameters);
        }
    }];
    [MGJRouter registerURLPattern:RouterMsgRegisterCtr toHandler:^(NSDictionary *routerParameters) {
        BOOL isPush = [routerParameters[MGJRouterParameterUserInfo][jumpType] boolValue];

        NSLog(@"isPush = %d , ctr = %@",isPush,RouterMsgRegisterCtr);
        RouterComplete block = routerParameters[MGJRouterParameterCompletion];
        if (block) {
            block(routerParameters);
        }
    }];
    
    ///< Msg list
    [MGJRouter registerURLPattern:RouterMsgListCtr toHandler:^(NSDictionary *routerParameters) {
        BOOL isPush = [routerParameters[MGJRouterParameterUserInfo][jumpType] boolValue];

        NSLog(@"isPush = %d , ctr = %@",isPush,RouterMsgListCtr);
        RouterComplete block = routerParameters[MGJRouterParameterCompletion];
        if (block) {
            block(routerParameters);
        }
    }];
    
    ///< Msg chat
    [MGJRouter registerURLPattern:RouterMsgChatCtr toHandler:^(NSDictionary *routerParameters) {
        BOOL isPush = [routerParameters[MGJRouterParameterUserInfo][jumpType] boolValue];

        NSLog(@"isPush = %d , ctr = %@",isPush,RouterMsgChatCtr);
        RouterComplete block = routerParameters[MGJRouterParameterCompletion];
        if (block) {
            block(routerParameters);
        }
    }];
    
    ///< User detail
    [MGJRouter registerURLPattern:RouterUserDetailtCtr toHandler:^(NSDictionary *routerParameters) {
        BOOL isPush = [routerParameters[MGJRouterParameterUserInfo][jumpType] boolValue];

        NSLog(@"isPush = %d , ctr = %@",isPush,RouterUserDetailtCtr);
        RouterComplete block = routerParameters[MGJRouterParameterCompletion];
        if (block) {
            block(routerParameters);
        }
    }];
}

+ (void)pushURL:(NSString *)url userInfo:(NSDictionary *)userInfo complete:(RouterComplete)block{
    NSMutableDictionary* mDic = userInfo ? userInfo.mutableCopy : @{}.mutableCopy;
    [mDic setObject:@(YES) forKey:jumpType];
    [MGJRouter openURL:url withUserInfo:mDic.copy completion:block];
}

+ (void)presentURL:(NSString *)url userInfo:(NSDictionary *)userInfo complete:(RouterComplete)block{
    NSMutableDictionary* mDic = userInfo ? userInfo.mutableCopy : @{}.mutableCopy;
    [mDic setObject:@(NO) forKey:jumpType];
    [MGJRouter openURL:url withUserInfo:mDic.copy completion:block];
}

@end


