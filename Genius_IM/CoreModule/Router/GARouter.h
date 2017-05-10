//
//  GARouter.h
//  Genius_IM
//
//  Created by Peter Gra on 2017/5/3.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RouterComplete)(id _Nullable result);

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSString* const RouterMsgLoginCtr;
FOUNDATION_EXTERN NSString* const RouterMsgRegisterCtr ;
FOUNDATION_EXTERN NSString* const RouterMsgListCtr ;
FOUNDATION_EXTERN NSString* const RouterMsgChatCtr ;
FOUNDATION_EXTERN NSString* const RouterUserDetailtCtr ;

/** Routing decoupling system based on "MGJRouter" frame structures */

@interface GARouter : NSObject

+ (void)pushURL:(NSString* )url userInfo:(NSDictionary* _Nullable )userInfo complete:(_Nullable RouterComplete)block;

+ (void)presentURL:(NSString* )url userInfo:(NSDictionary* _Nullable )userInfo complete:(_Nullable RouterComplete)block;

@end

NS_ASSUME_NONNULL_END
