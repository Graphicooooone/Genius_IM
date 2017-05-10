//
//  GAKeychainHelper.m
//  Genius_IM
//
//  Created by Peter Gra on 2017/5/8.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "GAKeychainHelper.h"
#import <Security/Security.h>

@implementation GAKeychainHelper

+ (BOOL)saveSecretKeyWithIndentifier:(nonnull NSString* )indentifier secretKey:(nonnull NSString* )secretKey{
    if (!indentifier || indentifier == (id)kCFNull || indentifier.length == 0) return NO ;
    if (!secretKey || secretKey == (id)kCFNull || secretKey.length == 0) return NO;
    NSMutableDictionary* mDic = @{(__bridge NSString* )kSecClass            : (__bridge NSString* )kSecClassGenericPassword,
                                  (__bridge NSString* )kSecAttrService      : indentifier.MD5_Value,
                                  (__bridge NSString* )kSecAttrAccount      : indentifier.MD5_Value,
                                  (__bridge NSString* )kSecAttrAccessible   : (__bridge NSString* )kSecAttrAccessibleAfterFirstUnlock,
                                  }.mutableCopy;
    SecItemDelete((__bridge CFDictionaryRef)mDic.copy);
    [mDic setObject:[secretKey dataUsingEncoding:NSUTF8StringEncoding] forKey:(__bridge NSString* )kSecValueData];
    return SecItemAdd((__bridge CFDictionaryRef)mDic.copy, NULL) == errSecSuccess;
}

+ (nullable NSString* )secretKeyWithIndentifier:(nonnull NSString* )indentifier{
    if (!indentifier || indentifier == (id)kCFNull || indentifier.length == 0) return nil ;
    NSMutableDictionary* mDic = @{(__bridge NSString* )kSecClass            : (__bridge NSString* )kSecClassGenericPassword,
                                  (__bridge NSString* )kSecAttrService      : indentifier.MD5_Value,
                                  (__bridge NSString* )kSecAttrAccount      : indentifier.MD5_Value,
                                  (__bridge NSString* )kSecAttrAccessible   : (__bridge NSString* )kSecAttrAccessibleAfterFirstUnlock,
                                  (__bridge NSString* )kSecReturnData       : (__bridge NSNumber* )kCFBooleanTrue,
                                  (__bridge NSString* )kSecMatchLimit       : (__bridge NSString* )kSecMatchLimitOne,
                                  }.mutableCopy;
    NSString* secretKey = nil;
    CFDataRef cfData = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)mDic.copy,(CFTypeRef* )&cfData);
    if (status == errSecSuccess && cfData != NULL) {
        secretKey = [[NSString alloc] initWithData:(__bridge NSData* )cfData encoding:NSUTF8StringEncoding];
    }
    return secretKey;
}

@end
