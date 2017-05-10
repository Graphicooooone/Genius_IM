//
//  NSString+Collection.m
//  Genius_IM
//
//  Created by Graphic-one on 17/2/27.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "NSString+Collection.h"
#import <CommonCrypto/CommonDigest.h>
#import "sys/utsname.h"

#pragma mark - FilePath
@implementation NSString (FilePath)

+ (NSString *)documentsFolderPath{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
}

+ (NSString *)tmpFolderPath{
    return [NSHomeDirectory() stringByAppendingFormat:@"/tmp"];
}

+ (NSString *)cachesFolderPath{
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
}

+ (NSString *)pereferencesFolderPath{
    return NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES).lastObject;
}

@end


#pragma mark - Networking
@implementation NSString (Networking)

+ (NSString* )UA{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)", [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleExecutableKey] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleIdentifierKey], (__bridge id)CFBundleGetValueForInfoDictionaryKey(CFBundleGetMainBundle(), kCFBundleVersionKey) ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey], deviceString, [[UIDevice currentDevice] systemVersion], ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] ? [[UIScreen mainScreen] scale] : 1.0f)];
}

- (NSString *)encodeURL{
    NSString* str = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), kCFStringEncodingUTF8));
    if (str) {
        return str;
    }
    return @"";
}

- (NSString* )decodeURL{
    NSString* str = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,(CFStringRef)self,CFSTR(""),kCFStringEncodingUTF8);
    if (str) {
        return str;
    }
    return @"";
}
                                                                                                                               
@end


#pragma mark - Encrypt
@implementation NSString (Encrypt)

- (NSString *)MD5_Value{
    if (self.length == 0) return nil;
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data.bytes, (CC_LONG)data.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10],result[11],
            result[12],result[13],result[14],result[15]
            ];
}

- (NSString *)SHA1_Value{
    if (self.length == 0) return nil;
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10],result[11],
            result[12],result[13],result[14],result[15],
            result[16],result[17],result[18],result[19]
            ];
}

@end

