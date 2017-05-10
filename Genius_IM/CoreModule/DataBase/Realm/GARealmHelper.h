//
//  GARealmHelper.h
//  Genius_IM
//
//  Created by Graphic-one on 17/2/28.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm.h>

#import "GARLMUser.h"
#import "GARLMGroupMember.h"
#import "GARLMSession.h"
#import "GARLMMessage.h"
#import "GARLMGroup.h"

typedef RLMArray*  _Nullable (^SearchDatasComplete)();
typedef RLMObject* _Nullable (^SaveDatasComplete)();

NS_ASSUME_NONNULL_BEGIN

@interface GARealmHelper<ObjectType> : NSObject

///< Synchronous
+ (nullable ObjectType)SearchData:(NSString* )pk cls:(Class)cls;
+ (nullable NSArray<ObjectType>* )SearchDatas:(NSArray<NSString* >* )pks cls:(Class)cls;
+ (nullable ObjectType)SearchDatasWhere:(NSString* )desc cls:(Class)cls;
+ (BOOL)SaveData:(ObjectType)obj;
+ (BOOL)SaveDatas:(NSArray<ObjectType>* )objs;
+ (BOOL)RemoveData:(ObjectType)obj;

///< Asynchronous
+ (void)SearchData:(NSString* )pk cls:(Class)cls complete:(SearchDatasComplete)block;
+ (void)SearchDatas:(NSArray<NSString* >* )pks cls:(Class)cls complete:(SearchDatasComplete)block;
+ (void)SearchDatasWhere:(NSString* )desc cls:(Class)cls complete:(SearchDatasComplete)block;
+ (void)SaveData:(ObjectType)obj complete:(SaveDatasComplete)block;
+ (void)SaveDatas:(NSArray<ObjectType>* )objs complete:(SaveDatasComplete)block;
+ (void)RemoveData:(ObjectType)obj complete:(SaveDatasComplete)block;

@end


/** Realm Transaction Thread ... */

@interface GARLMTransactionThread : NSObject

+ (nonnull NSThread* )transactionThread;

+ (void)addTaskToTransactionThread:(void(^)())taskblock;

@end

NS_ASSUME_NONNULL_END

