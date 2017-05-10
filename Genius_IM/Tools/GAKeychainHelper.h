//
//  GAKeychainHelper.h
//  Genius_IM
//
//  Created by Peter Gra on 2017/5/8.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GAKeychainHelper : NSObject

+ (BOOL)saveSecretKeyWithIndentifier:(nonnull NSString* )indentifier secretKey:(nonnull NSString* )secretKey;

+ (nullable NSString* )secretKeyWithIndentifier:(nonnull NSString* )indentifier;

@end
