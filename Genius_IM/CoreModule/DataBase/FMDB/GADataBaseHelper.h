//
//  GADataBaseHelper.h
//  Genius_IM
//
//  Created by Graphic-one on 17/2/25.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>

@class FMDatabaseQueue;

typedef NS_ENUM(NSUInteger,DataBaseExecuteStatus){
    DataBaseExecuteStatusAllSuccess = 1,
    DataBaseExecuteStatusAllFailed  = 0,
    DataBaseExecuteStatusPortion    = 99,
};

NS_ASSUME_NONNULL_BEGIN

@class GASession,GAMessage,GAGroup,GAGroupMember,GAUser;

@interface GADataBaseHelper<ObjectType> : NSObject

+ (nullable ObjectType)SearchData:(NSString* )pk cls:(Class)cls;

+ (nullable NSArray<ObjectType>* )SearchDatas:(NSArray<NSString* >* )pks cls:(Class)cls;

+ (nullable NSArray<ObjectType>* )SearchDatasWhere:(NSString* )desc cls:(Class)cls;

+ (BOOL)UpdateData:(ObjectType)obj primaryKey:(NSString* )pk;

+ (BOOL)SaveData:(ObjectType)obj;

+ (DataBaseExecuteStatus)SaveDatas:(NSArray<ObjectType>* )objs;

+ (BOOL)RemoveData:(ObjectType)obj;

@end


@interface GADataBaseHelper<ObjectType> (General)

+ (FMDatabaseQueue* )dataBaseQueue;

+ (BOOL)uninstallDataBase;

@end

NS_ASSUME_NONNULL_END


