//
//  GAUserSetting.m
//  Genius_IM
//
//  Created by Graphic-one on 17/3/2.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "GAUserSetting.h"
#import "GARealmHelper.h"

NSString * const GAUserSettingInfo = @"GAUserSettingInfo";

@interface GAUserSetting (){
@package
    BOOL _isNewest;
    NSString* _Nullable  _curUserID;
}
@end

@implementation GAUserSetting
+ (instancetype)shareUserSetting{
    static GAUserSetting* _shareUserSetting;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareUserSetting = [GAUserSetting new];
        _shareUserSetting->_isNewest = YES;
        _shareUserSetting->_curUserID = [[NSUserDefaults standardUserDefaults] stringForKey:GAUserSettingInfo];
    });
    return _shareUserSetting;
}

+ (BOOL)updateUserSettingInfo:(NSString* )userID{
    if (!userID || [userID isEqual:(id)kCFNull]) return NO;
    
    [[NSUserDefaults standardUserDefaults] setObject:userID forKey:GAUserSettingInfo];
    GAUserSetting* settingStatus = [self shareUserSetting];
    settingStatus->_isNewest = NO;
    return [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSUInteger)UserID{
    GAUserSetting* settingStatus = [self shareUserSetting];
    if (!settingStatus->_isNewest) {
        settingStatus->_curUserID = [[NSUserDefaults standardUserDefaults] stringForKey:GAUserSettingInfo];
    }
    return settingStatus->_curUserID.integerValue;
}

+ (NSString* )UserName{
    return [GARealmHelper<GARLMUser* > SearchData:[NSString stringWithFormat:@"%lu",(unsigned long)[self UserID]] cls:[GARLMUser class]].name;
}

+ (NSString* )UserPhone{
    return [GARealmHelper<GARLMUser* > SearchData:[NSString stringWithFormat:@"%lu",(unsigned long)[self UserID]] cls:[GARLMUser class]].phone;
}

+ (NSString* )UserPortrait{
    return [GARealmHelper<GARLMUser* > SearchData:[NSString stringWithFormat:@"%lu",(unsigned long)[self UserID]] cls:[GARLMUser class]].portrait;
}

+ (NSString* )UserDesc{
    return [GARealmHelper<GARLMUser* > SearchData:[NSString stringWithFormat:@"%lu",(unsigned long)[self UserID]] cls:[GARLMUser class]].desc;
}

+ (UserSex)UserSex{
    return [GARealmHelper<GARLMUser* > SearchData:[NSString stringWithFormat:@"%lu",(unsigned long)[self UserID]] cls:[GARLMUser class]].sex;
}

@end
