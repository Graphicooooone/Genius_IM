//
//  NSString+Collection.h
//  Genius_IM
//
//  Created by Graphic-one on 17/2/27.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - FilePath
@interface NSString (FilePath)

+ (NSString* )documentsFolderPath;

+ (NSString* )tmpFolderPath;

+ (NSString* )cachesFolderPath;

+ (NSString* )pereferencesFolderPath;

@end

#pragma mark - Networking
@interface NSString (Networking)

+ (NSString* )UA;

- (NSString* )encodeURL;

- (NSString* )decodeURL;

@end

#pragma mark - Encrypt
@interface NSString (Encrypt)

- (NSString* )MD5_Value;

- (NSString* )SHA1_Value;

@end
