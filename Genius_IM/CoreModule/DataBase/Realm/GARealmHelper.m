//
//  GARealmHelper.m
//  Genius_IM
//
//  Created by Graphic-one on 17/2/28.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "GARealmHelper.h"

#define PrimaryKeyIllegal(condition,value) \
if ((!condition) || ([condition isEqual:(id)kCFNull]) || (condition.length == 0)) { \
return value; \
}
#define PredicateIllegal(condition,value) \
if ((!condition) || ([condition isEqual:(id)kCFNull]) || (condition.length == 0)) { \
return value; \
}
#define PrimaryKeysIllegal(condition,value) \
if ((!condition) || ([condition isEqual:(id)kCFNull]) || (condition.count == 0)){ \
return value; \
}
#define ClassIllegal(condition,value) \
if (![condition isSubclassOfClass:[RLMObject class]]){ \
return value; \
}

@implementation GARealmHelper

#pragma mark - Synchronous
+ (nullable RLMObject* )SearchData:(NSString* )pk cls:(Class)cls{
    PrimaryKeyIllegal(pk, nil);
    ClassIllegal(cls, nil);
    return [cls objectsWhere:[NSString stringWithFormat:@"id LIKE %@",pk]].firstObject;
}

+ (nullable NSArray<RLMObject* >* )SearchDatas:(NSArray<NSString* >* )pks cls:(Class)cls{
    PrimaryKeysIllegal(pks, nil);
    ClassIllegal(cls, nil);
    
    NSMutableArray* mArr = @[].mutableCopy;
    for (NSString* pk in pks) {
        if ([self SearchData:pk cls:cls]) {
            [mArr addObject:[self SearchData:pk cls:cls]];
        }
    }
    return [mArr copy];
}

+ (nullable RLMResults* )SearchDatasWhere:(NSString* )desc cls:(Class)cls{
    PredicateIllegal(desc, nil);
    ClassIllegal(cls, nil);
    
    return [cls objectsWhere:desc];
}

+ (BOOL)SaveData:(RLMObject* )obj{
    RLMRealm* realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];

    @try {
        [realm addOrUpdateObject:obj];
    } @catch (NSException *exception) {
        return NO;
    } @finally {
        [realm commitWriteTransaction];
    }
    
    return YES;
}

+ (BOOL)SaveDatas:(NSArray<RLMObject* >* )objs{
    RLMRealm* realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    
    @try {
        [realm addOrUpdateObjectsFromArray:objs];
    } @catch (NSException *exception) {
        return NO;
    } @finally {
        [realm commitWriteTransaction];
    }
    
    return YES;
}

+ (BOOL)RemoveData:(RLMObject* )obj{
    RLMRealm* realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    
    @try {
        [realm deleteObject:obj];
    } @catch (NSException *exception) {
        return NO;
    } @finally {
        [realm commitWriteTransaction];
    }
    
    return YES;
}

#pragma mark - Asynchronous
+ (void)SearchData:(NSString* )pk cls:(Class)cls complete:(SearchDatasComplete)block{
    PrimaryKeyIllegal(pk, );
    ClassIllegal(cls, );
    
}

+ (void)SearchDatas:(NSArray<NSString* >* )pks cls:(Class)cls complete:(SearchDatasComplete)block{
    PrimaryKeysIllegal(pks, );
    ClassIllegal(cls, );
    
    NSMutableArray* mArr = @[].mutableCopy;
    for (NSString* pk in pks) {
        
    }
}

+ (void)SearchDatasWhere:(NSString* )desc cls:(Class)cls complete:(SearchDatasComplete)block{
    PredicateIllegal(desc, );
    ClassIllegal(cls, );
    
}

+ (void)SaveData:(RLMObject* )obj complete:(SaveDatasComplete)block{

}

+ (void)SaveDatas:(NSArray<RLMObject* >* )objs complete:(SaveDatasComplete)block{

}

+ (void)RemoveData:(RLMObject* )obj complete:(SaveDatasComplete)block{

}

@end


/** Realm Transaction Thread ... */

@implementation GARLMTransactionThread
static NSOperationQueue* _staticQueue;
+ (NSThread* )transactionThread{
    static NSThread* _transactionThread;
    if (!_transactionThread || [_transactionThread isEqual:(id)kCFNull] ) {
        _transactionThread = [[NSThread alloc] initWithBlock:^{
            @autoreleasepool {
                [[NSThread currentThread] setName:@"GARLMTransactionThread"];
                [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
                [[NSRunLoop currentRunLoop] run];
                
                NSOperationQueue* queue = [[NSOperationQueue alloc] init];
                _staticQueue = queue;
            }
        }];
        [_transactionThread start];
    }
    return _transactionThread;
}
+ (void)addTaskToTransactionThread:(void (^)())taskblock{
    NSBlockOperation* blockOperation = [NSBlockOperation blockOperationWithBlock:taskblock];
    [_staticQueue addOperation:blockOperation];
}
@end

