//
//  GAModelHelper.h
//  Genius_IM
//
//  Created by Graphic-one on 17/3/8.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Based on the data YYModel resolution layer
 * In order to eliminate the coupling ...
 */

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (YYModel_Vendors)

+ (nullable instancetype)GA_modelWithJSON:(id)json;

+ (nullable instancetype)GA_modelWithDictionary:(NSDictionary *)dictionary;

- (BOOL)GA_modelSetWithJSON:(id)json;

- (BOOL)GA_modelSetWithDictionary:(NSDictionary *)dic;

- (nullable id)GA_modelToJSONObject;

- (nullable NSData *)GA_modelToJSONData;

- (nullable NSString *)GA_modelToJSONString;

- (nullable id)GA_modelCopy;

- (void)GA_modelEncodeWithCoder:(NSCoder *)aCoder;

- (id)GA_modelInitWithCoder:(NSCoder *)aDecoder;

- (NSUInteger)GA_modelHash;

- (BOOL)GA_modelIsEqual:(id)model;

- (NSString *)GA_modelDescription;

@end

@interface NSArray (YYModel_Vendors)

+ (nullable NSArray *)GA_modelArrayWithClass:(Class)cls json:(id)json;

@end

@interface NSDictionary (YYModel_Vendors)

+ (nullable NSDictionary *)GA_modelDictionaryWithClass:(Class)cls json:(id)json;

@end

NS_ASSUME_NONNULL_END
