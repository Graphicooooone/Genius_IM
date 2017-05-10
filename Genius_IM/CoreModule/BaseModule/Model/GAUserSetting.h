//
//  GAUserSetting.h
//  Genius_IM
//
//  Created by Graphic-one on 17/3/2.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GAUserSetting : NSObject

+ (BOOL)updateUserSettingInfo:(NSString* )userID;

+ (NSUInteger)UserID;

+ (NSString* )UserName;

+ (NSString* )UserPhone;

+ (NSString* )UserPortrait;

+ (NSString* )UserDesc;

+ (UserSex)UserSex;

@end
