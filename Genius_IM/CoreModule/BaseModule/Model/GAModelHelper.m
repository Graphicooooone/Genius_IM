//
//  GAModelHelper.m
//  Genius_IM
//
//  Created by Graphic-one on 17/3/8.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "GAModelHelper.h"

@implementation NSObject (YYModel_Vendors)

+ (nullable instancetype)GA_modelWithJSON:(id)json{
    return [self modelWithJSON:json];
}

+ (nullable instancetype)GA_modelWithDictionary:(NSDictionary *)dictionary{
    return [self modelWithDictionary:dictionary];
}

- (BOOL)GA_modelSetWithJSON:(id)json{
    return [self modelSetWithJSON:json];
}

- (BOOL)GA_modelSetWithDictionary:(NSDictionary *)dic{
    return [self modelSetWithDictionary:dic];
}

- (nullable id)GA_modelToJSONObject{
    return [self modelToJSONObject];
}

- (nullable NSData *)GA_modelToJSONData{
    return [self modelToJSONData];
}

- (nullable NSString *)GA_modelToJSONString{
    return [self modelToJSONString];
}

- (nullable id)GA_modelCopy{
    return [self modelCopy];
}

- (void)GA_modelEncodeWithCoder:(NSCoder *)aCoder{
    [self modelEncodeWithCoder:aCoder];
}

- (id)GA_modelInitWithCoder:(NSCoder *)aDecoder{
    return [self modelInitWithCoder:aDecoder];
}

- (NSUInteger)GA_modelHash{
    return [self modelHash];
}

- (BOOL)GA_modelIsEqual:(id)model{
    return [self modelIsEqual:model];
}

- (NSString *)GA_modelDescription{
    return [self modelDescription];
}

@end


@implementation NSArray (YYModel_Vendors)

+ (nullable NSArray *)GA_modelArrayWithClass:(Class)cls
                                        json:(id)json
{
    return [self modelArrayWithClass:cls json:json];
}

@end


@implementation NSDictionary (YYModel_Vendors)

+ (NSDictionary *)GA_modelDictionaryWithClass:(Class)cls
                                         json:(id)json
{
    return [self modelDictionaryWithClass:cls json:json];
}

@end
