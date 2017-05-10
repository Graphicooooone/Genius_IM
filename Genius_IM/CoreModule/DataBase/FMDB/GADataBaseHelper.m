//
//  GADataBaseHelper.m
//  Genius_IM
//
//  Created by Graphic-one on 17/2/25.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#define GA_EqualCls(cls,otherCls) [NSStringFromClass(cls) isEqualToString:NSStringFromClass(otherCls)]

#import "GADataBaseHelper.h"
#import "GAKeychainHelper.h"

#import <sqlite3.h>
#import <objc/runtime.h>

#import "GASession.h"
#import "GAMessage.h"
#import "GAUser.h"
#import "GAGroup.h"
#import "GAGroupMember.h"

#pragma mark - FMDatabase (GA_Protect_Hook)

@interface FMDatabase (GA_Protect_Hook) @end

@implementation FMDatabase (GA_Protect_Hook)

- (BOOL)_dataBaseKeyHelperOpen{
    if (![self isKindOfClass:[FMDatabase class]]) return NO;
    
    BOOL rValue = [self _dataBaseKeyHelperOpen];
    FMDatabase* dataBase = (FMDatabase* )self;
    void* db = dataBase->_db;
    
    BOOL isEncrypted ;
    sqlite3_stmt* stmt;
    NSString* tSQL = @"select * from sqlite_master where type='table' order by name";///< Access to the db files in the table name
    sqlite3_prepare_v2(db, tSQL.UTF8String, -1, &stmt, NULL);
    isEncrypted = sqlite3_step(stmt) != SQLITE_ROW;
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        NSString* firstName = [NSString stringWithUTF8String:(const char* )sqlite3_column_text(stmt, 1)];
        NSLog(@"%@",firstName);
    }
    
    /** 
    ///< get all tName ...
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        NSString* firstName = [NSString stringWithUTF8String:(const char* )sqlite3_column_text(stmt, 1)];
        NSLog(@"%@",firstName);
    }
    
    ///< get top one data ...
    NSString* tName = [NSString stringWithUTF8String:(const char* )sqlite3_column_text(stmt, 1)];
    if (tName){
        stmt = nil;
        tSQL = [NSString stringWithFormat:@"SELECT TOP 1 * FROM %@",tName];
        sqlite3_prepare_v2(db, tSQL.UTF8String, -1, &stmt, NULL);
        if (sqlite3_step(stmt) != SQLITE_OK) {
            isEncrypted = YES;
        }
    }else{
        NSLog(@"The current db no data table");///< The current db no data table
    }
     */
    
    
    if (isEncrypted) {
        NSString* sKey = [GAKeychainHelper secretKeyWithIndentifier:dataBase->_databasePath];
        if (sKey) {
            if (![dataBase setKey:sKey]) {
                ///< External encryption ...
            }
        }else{
            ///< External encryption ...
        }
    }else{
        NSString* curUUID = [NSUUID UUID].UUIDString;
        curUUID = @"lebron";//test
        if ([dataBase setKey:curUUID]) {
            [GAKeychainHelper saveSecretKeyWithIndentifier:dataBase->_databasePath secretKey:curUUID];
        }
    }
    return rValue;
}

- (BOOL)_dataBaseKeyHelperOpenWithFlags:(int)flags vfs:(NSString *)vfsName{
    if (![self isKindOfClass:[FMDatabase class]]) return NO;

    BOOL rValue = [self _dataBaseKeyHelperOpenWithFlags:flags vfs:vfsName];
    FMDatabase* dataBase = (FMDatabase* )self;
    void* db = dataBase->_db;
    
    BOOL isEncrypted ;
    sqlite3_stmt* stmt;
    NSString* tSQL = @"select * from sqlite_master where type='table' order by name";///< Access to the db files in the table name
    sqlite3_prepare_v2(db, tSQL.UTF8String, -1, &stmt, NULL);
    isEncrypted = sqlite3_step(stmt) != SQLITE_ROW;

    if (isEncrypted) {
        NSString* sKey = [GAKeychainHelper secretKeyWithIndentifier:dataBase->_databasePath];
        if (sKey) {
            if (![dataBase setKey:sKey]) {
                ///< External encryption ...
            }
        }else{
            ///< External encryption ...
        }
    }else{
        NSString* curUUID = [NSUUID UUID].UUIDString;
        curUUID = @"lebron";//test
        if ([dataBase setKey:curUUID]) {
            [GAKeychainHelper saveSecretKeyWithIndentifier:dataBase->_databasePath secretKey:curUUID];
        }
    }
    
    return rValue;
}

@end

/** methodSwizzling */
__attribute__((constructor(101)))
static void methodSwizzling(void){
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originOpen = @selector(open);
        SEL targetOpen = @selector(_dataBaseKeyHelperOpen);
        Method originMethod = class_getInstanceMethod([FMDatabase class], originOpen);
        Method targetMethod = class_getInstanceMethod([FMDatabase class], targetOpen);
        BOOL isAdd = class_addMethod([FMDatabase class], originOpen, method_getImplementation(targetMethod), method_getTypeEncoding(targetMethod));
        if (isAdd) {
            class_replaceMethod([FMDatabase class], targetOpen, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
        }else{
            method_exchangeImplementations(originMethod, targetMethod);
        }
        
        originOpen = @selector(openWithFlags:vfs:);
        targetOpen = @selector(_dataBaseKeyHelperOpenWithFlags:vfs:);
        originMethod = class_getInstanceMethod([FMDatabase class], originOpen);
        targetMethod = class_getInstanceMethod([FMDatabase class], targetOpen);
        isAdd = class_addMethod([FMDatabase class], originOpen, method_getImplementation(targetMethod), method_getTypeEncoding(targetMethod));
        if (isAdd) {
            class_replaceMethod([FMDatabase class], targetOpen, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
        }else{
            method_exchangeImplementations(originMethod, targetMethod);
        }
    });
}
/** methodSwizzling */


typedef NS_ENUM(NSUInteger,GADataBaseType){
    GADataBaseType_text         = 1,
    GADataBaseType_number       = 2,
    
    GADataBaseType_nonsupport   = 0,
};

@interface GADataBaseHelper ()
+ (FMDatabaseQueue* )_dataBase;
+ (NSString* )_dataBasePath;
@end

@implementation GADataBaseHelper

+ (FMDatabaseQueue* )_dataBase{
    return [FMDatabaseQueue databaseQueueWithPath:[self _dataBasePath]];
}
+ (NSString* )_dataBasePath{
    return [[NSString cachesFolderPath] stringByAppendingPathComponent:@"dataBase.db"];
}

#pragma mark - Public

+ (nullable id)SearchData:(NSString* )pk cls:(nonnull Class)cls{
    if (!pk || pk == (id)kCFNull || pk.length == 0) return nil;
    
    FMDatabaseQueue* db = [self _dataBase];
    NSString* tName = [self _returnCurTableName:cls];
    __block id model = [[cls alloc] init];
    [db inDatabase:^(FMDatabase *db) {
        FMResultSet* rs = [db executeQueryWithFormat:@"select * from %@ where id is %@",tName,pk];
        model = [self _setupModelWithResultSet:rs cls:cls];
    }];
    return model;
}

+ (nullable NSArray* )SearchDatas:(NSArray<NSString* >* )pks cls:(nonnull Class)cls{
    if (!pks || pks == (id)kCFNull || pks.count == 0) return nil;
    
    FMDatabaseQueue* db = [self _dataBase];
    NSString* tName = [self _returnCurTableName:cls];
    NSMutableArray* mArr = [NSMutableArray array];
    [db inDatabase:^(FMDatabase *db) {
        __block id model;
        for (NSString* pk in pks) {
            FMResultSet* result = [db executeQueryWithFormat:@"select * from %@ where id is %@",tName,pk];
            model = [self _setupModelWithResultSet:result cls:cls];
            if (model) [mArr addObject:model];
        }
    }];
    return [mArr copy];
}

+ (nullable id)SearchDatasWhere:(NSString* )desc cls:(nonnull Class)cls{
    if (!desc || desc == (id)kCFNull || desc.length == 0)  return nil;
    
    FMDatabaseQueue* db = [self _dataBase];
    __block id model = [[cls alloc] init];
    [db inDatabase:^(FMDatabase *db) {
        FMResultSet* result = [db executeQuery:desc];
        model = [self _setupModelWithResultSet:result cls:cls];
    }];
    return model;
}

+ (BOOL)UpdateData:(id)obj primaryKey:(NSString* )pk{
    if (!obj || obj == (id)kCFNull) return NO;
    if (!pk  || pk  == (id)kCFNull || pk.length == 0) return NO;
    
    FMDatabaseQueue* db = [self _dataBase];
    NSString* tName = [self _returnCurTableName:[obj class]];
    __block BOOL result = NO;
    [db inTransaction:^(FMDatabase *db, BOOL *rollback) {
        BOOL deleteRs = [db executeUpdateWithFormat:@"%@",[NSString stringWithFormat:@"DELETE FROME %@ WHERE id = %@",tName,pk]];
        BOOL insertRs = [db executeUpdateWithFormat:@"%@",[self _returnInsertSQL:[self _returnCurClsProperty:[obj class]] value:obj tableName:tName]];
        if (!(deleteRs && insertRs)) {
            *rollback = YES;
        }
    }];
    return result;
}

+ (BOOL)SaveData:(id)obj{
    if (!obj || obj == (id)kCFNull) {
        DDLogError(@"class : %@\n sel : %@\n para : %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd),obj);
#ifdef DEBUG
        NSAssert(false, @"%@ -Failure- %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
#endif
        return NO ;
    }else{
        __block BOOL result;
        FMDatabaseQueue* db = [self _dataBase];
        __weak typeof(self) weakSelf = self;
        [db inDatabase:^(FMDatabase *db) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            result = [db executeUpdate:[strongSelf _returnInsertSQL:[strongSelf _returnCurClsProperty:[obj class]] value:obj tableName:[strongSelf _returnCurTableName:[obj class]]]];
        }];
        return result;
    }
}

+ (DataBaseExecuteStatus)SaveDatas:(NSArray<id>* )objs{
    if (!objs || objs == (id)kCFNull || objs.count == 0) {
        DDLogError(@"class : %@\n sel : %@\n para : %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd),objs);
#ifdef DEBUG
        NSAssert(false, @"%@ -Failure- %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
#endif
        return DataBaseExecuteStatusAllFailed ;
    }else{
        FMDatabaseQueue* db = [self _dataBase];
        __block DataBaseExecuteStatus result = DataBaseExecuteStatusAllFailed;
        [db inDatabase:^(FMDatabase *db) {
            NSMutableArray* mArrResult = [NSMutableArray array];
            
            for (id obj in objs) {
                BOOL result = [db executeUpdateWithFormat:@"%@",[self _returnInsertSQL:[self _returnCurClsProperty:[obj class]] value:obj tableName:[self _returnCurTableName:[obj class]]]];
                
                if (!result) {
                    DDLogError(@"class : %@\n sel : %@\n curSaveObj : %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd),obj);
#ifdef DEBUG
                    NSAssert(false, @"%@ -Failure- %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
#endif
                }
                
                [mArrResult addObject:@(result)];
            }
            
            if (mArrResult.count == 0 || ![mArrResult containsObject:@(YES)]) {
                result = DataBaseExecuteStatusAllFailed;
            }else if ([mArrResult containsObject:@(NO)] && [mArrResult containsObject:@(YES)]){
                result = DataBaseExecuteStatusPortion;
            }else{
                result = DataBaseExecuteStatusAllSuccess;
            }
        }];
        return result;
    }
}

+ (BOOL)RemoveData:(id)obj{
    if (!obj || obj == (id)kCFNull) {
        DDLogError(@"class : %@\n sel : %@\n para : %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd),obj);
#ifdef DEBUG
        NSAssert(false, @"%@ -Failure- %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
#endif
        return NO ;
    }else{
        __block BOOL result = NO;
        FMDatabaseQueue* db = [self _dataBase];
        [db inTransaction:^(FMDatabase *db, BOOL *rollback) {
            result = [db executeUpdateWithFormat:@"DELETE FROME %@ WHERE id = %@",[self _returnCurTableName:[obj class]],[obj valueForKeyPath:@"_id"]];
            if (!result) {
                *rollback = YES;
            }
        }];
        return result;
    }
}

#pragma mark - Private
+ (NSString* )_returnCurTableName:(Class)cls{
    NSString* tableName;
    
    if (GA_EqualCls(cls, [GASession class])) {
        tableName = @"t_session";
    }
    else if (GA_EqualCls(cls, [GAMessage class])){
        tableName = @"t_message";
    }
    else if (GA_EqualCls(cls, [GAUser class])){
        tableName = @"t_user";
    }
    else if (GA_EqualCls(cls, [GAGroup class])){
        tableName = @"t_group";
    }
    else if (GA_EqualCls(cls, [GAGroupMember class])){
        tableName = @"t_group_member";
    }
    
    return tableName;
}

+ (NSDictionary* )_returnCurClsProperty:(Class)cls{
    NSMutableDictionary* mDic = [NSMutableDictionary dictionary];
    unsigned int count ;
    objc_property_t* properties = class_copyPropertyList(cls, &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSString* propertyName = [NSString stringWithUTF8String:property_getName(property)];
        NSString* propertyType = [NSString stringWithUTF8String:property_getAttributes(property)];
        if ([self _verifyType:propertyType] != GADataBaseType_nonsupport) {
            [mDic setValue:@([self _verifyType:propertyType]) forKey:propertyName];
        }
    }
    free(properties);
    
    return [mDic copy];
}

+ (GADataBaseType)_verifyType:(NSString* )t{
    if ([t containsString:@"T@\"NSString\""]) {
        return GADataBaseType_text;
    }else if ([t containsString:@"TQ"] || [t containsString:@"Tq"]){
        return GADataBaseType_number;
    }else{
        return GADataBaseType_nonsupport;
    }
}

+ (NSString* )_returnInsertSQL:(NSDictionary* )para value:(id)model tableName:(NSString* )tName{
    NSString* sql = nil;
    if (!para || para == (id)kCFNull || para.allKeys.count == 0) return sql;
    if (!model || model == (id)kCFNull) return sql;
    
    NSMutableString* keyStr   = [NSMutableString string];
    NSMutableString* valueStr = [NSMutableString string];

    [keyStr appendString:@"("];
    [valueStr appendString:@"("];
    
    for (NSString* pName in para.allKeys) {
        [keyStr appendFormat:@"%@,",pName];
        GADataBaseType T = [para[pName] integerValue];
        if (T == GADataBaseType_text) {
            if (![model valueForKey:pName]) {
                [valueStr appendFormat:@"'-',"];
            }else{
                [valueStr appendFormat:@"'%@',",[model valueForKey:pName]];
            }
        }else if (T == GADataBaseType_number){
            [valueStr appendFormat:@"%@,",[model valueForKey:pName]];
        }else{
            DDLogError(@"class : %@\n sel : %@\n curValue : %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd),pName);
#ifdef DEBUG
            NSAssert(false, @"%@ -Failure- %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
#endif
        }
    }
    
    keyStr = [keyStr substringWithRange:NSMakeRange(0, keyStr.length - 1)].mutableCopy;
    [keyStr appendString:@")"];
    valueStr = [valueStr substringWithRange:NSMakeRange(0, valueStr.length - 1)].mutableCopy;
    [valueStr appendString:@")"];
    
    sql = [NSString stringWithFormat:@"INSERT INTO %@ %@ VALUES %@;",tName,keyStr.copy,valueStr.copy];
    
    return sql;
}

+ (id)_setupModelWithResultSet:(FMResultSet* )rs cls:(Class)cls{
    id model = [[cls alloc] init];
    
    NSDictionary* propertyDic = [self _returnCurClsProperty:[cls class]];
    while ([rs next]) {
        for (NSString* pName in propertyDic.allKeys) {
            switch ([propertyDic[pName] unsignedIntegerValue]) {
                case GADataBaseType_text:{
                    NSString* str = [rs stringForColumn:pName];
                    if (str) {
                        [model setValue:str forKey:pName];
                    }
                    break;
                }
                case GADataBaseType_number:{
                    NSUInteger num = [rs unsignedLongLongIntForColumn:pName] ;
                    if (num != NSNotFound) {
                        [model setValue:@(num) forKey:pName];
                    }
                    break;
                }
                    
                default:
                    DDLogError(@"class : %@\n sel : %@\n curValue : %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd),pName);
#ifdef DEBUG
                    NSAssert(false, @"%@ -Failure- %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
#endif
                    break;
            }
        }
    }
    
    return model;
}

@end


#pragma mark - GADataBaseHelper (General)

@implementation GADataBaseHelper (General)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        FMDatabase* db =[FMDatabase databaseWithPath:[self _dataBasePath]];
        if ([db open]) {
            [db executeUpdate:[self _sql_session]];
            [db executeUpdate:[self _sql_message]];
            [db executeUpdate:[self _sql_group]];
            [db executeUpdate:[self _sql_groupMember]];
            [db executeUpdate:[self _sql_user]];
            [db close];
        }
    });
}

#pragma mark - Public

+ (FMDatabaseQueue *)dataBaseQueue{
    return [self _dataBase];
}

+ (BOOL)uninstallDataBase{
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self _dataBasePath]]) {
        return [[NSFileManager defaultManager] removeItemAtPath:[self _dataBasePath] error:NULL];
    }else{
        return NO;
    }
}

#pragma mark - creat sql ...

/**
 t_session TABLE :
 *  id(text)     type(integer)     picture(text)       title(text)   content(text)     nuReadCount(integer)     messageId(text)
 *  "9922"             0          "gra.com/gra.png"       "Gra"        "Hey,ONE"            23                     "132135"
 *  "2131"             0          "gra.com/QiuJu.png"     "Qiuju"      "#￥%……&*"            0                     "121212"
 *  "1233"             0          "gra.com/Lebron.png"     "Lebron"     "#￥%……&*"            0                      "560840"
 *  "1111"             0          "gra.com/Oone.png"      "Oone"        "..*.."              0                     "6444264"
 */
+ (NSString* )_sql_session{
    return [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS t_session (id text PRIMARY KEY, type integer NOT NULL, picture text, title text, content text, nuReadCount integer, messageId text);"];
}

/**
 t_message TABLE :
 *  id(text)     content(text)     attach(text)    type(integer)   pushlish(text)     status(integer)     senderId(text)     groupId(text)     receiverId(text)
 MessageType                        MessageStatus
 *  "4535"         "ok,fine."          ""           0             "2017.06.20 14:20"    0                   "132135"            "0"              "123456"
 *  "3240"         "//...file"   "//...filePath"    3             "2017.06.20 14:20"    1                   "564590"            "0"              "123456"
 *  "7897"          "sorry!"           ""           0             "2017.06.20 14:20"    1                   "560840"            "0"              "123456"
 *  "4755"      "hey,merry,coming"     ""           0             "2017.06.20 14:20"    1                   "644642"           "819"             "123456"
 */
+ (NSString* )_sql_message{
    return [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS t_message (id text PRIMARY KEY, content text NOT NULL, attach text, type integer NOT NULL, pushlish text NOT NULL, status integer NOT NULL, senderId text NOT NULL, groupId text NOT NULL, receiverId text NOT NULL);"];
}

/**
 t_group TABLE :
 *  id(text)     name(text)         desc(text)          pricture(text)          createrId(text)
 *  "9203"       "groupNameOne"   "something desc"   "xxx.com/portrait.png"       "923816"
 *  "9320"        "Musicers"      "something desc"     "xxx.com/Gra.jpeg"         "200810"
 *  "2503"       "ClassOne"      "something desc"     "xxx.com/Sisa.gif"          "592017"
 *  "1743"         "Genius"       "something desc"   "xxx.com/portrait.png"       "604720"
 */
+ (NSString* )_sql_group{
    return [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS t_group (id text PRIMARY KEY, name text NOT NULL, desc text, pricture text, createrId text NOT NULL);"];
}

/**
 t_group_member TABLE :
 *  id(text)        alias(text)         groupId(text)       userId(integer)
 *   "2619"         "gra_"              "92017"                "19401"
 *   "7216"         "curry"             "92017"                "59302"
 *   "5739"         ""                  "92017"                "6727"
 *   "9502"         ""                  "401371"               "59494"
 */
+ (NSString* )_sql_groupMember{
    return [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS t_group_member (id text PRIMARY KEY, alias text, groupId text NOT NULL, userId text NOT NULL);"];
}

/**
 t_user TABLE :
 *  id(text)     name(text)     phone(text)         portrait(text)          desc(text)     sex(integer)     isFollow(integer)     alias(text)
 UserSex
 *   "4535"       "gra_"         "1234567"       "xxx.com/Gra.jpeg"      "something desc"      0                   0                "Gra"
 *   "3240"      "curry"         "1234567"      "xxx.com/portrait.png"   "something desc"      1                   1                ""
 *   "7897"       "QiuJu"        "1234567"      "xxx.com/portrait.png"   "something desc"      2                   0                "Qiuju"
 *   "4755"      "Lebron"        "1234567"      "xxx.com/portrait.png"   "xxxxxxxxxxxxxx"      1                   1                ""
 */
+ (NSString* )_sql_user{
    return [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS t_user (id text PRIMARY KEY, name text, phone text, portrait text, desc text, sex integer, isFollow integer, alias text);"];;
}

@end










