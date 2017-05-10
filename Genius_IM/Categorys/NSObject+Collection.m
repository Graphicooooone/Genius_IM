//
//  NSObject+Collection.m
//  Genius_IM
//
//  Created by Graphic-one on 17/3/2.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "NSObject+Collection.h"

#pragma mark - serialize

#import "GAUserSetting.h"

@implementation NSObject (Serialize)

NSString * const SandboxCacheType_listFolderName            = @"SandboxCacheType_listFolderName";
NSString * const SandboxCacheType_detailFolderName          = @"SandboxCacheType_detailFolderName";
NSString * const SandboxCacheType_otherFolderName           = @"SandboxCacheType_otherFolderName";
NSString * const SandboxCacheType_temporaryFolderName       = @"SandboxCacheType_temporaryFolderName";
NSString * const SandboxCacheType_webViewImagesFolderName   = @"SandboxCacheType_webViewImagesFolderName";

/** resource name constructor */
+ (NSString* )cacheResourceNameWithURL:(NSString* )requestUrl
               parameterDictionaryDesc:(nullable NSString* )paraDicDesc
{
    NSString* resourceName = [NSString stringWithFormat:@"%@_%@_%ld",requestUrl,paraDicDesc,(long)[GAUserSetting UserID]];
    return [NSString stringWithFormat:@"%lu",resourceName.hash];
}

/** networking Handle */
+ (BOOL)handleResponseObject:(id)responseObject
                    resource:(NSString* )resourceName
                   cacheType:(SandboxCacheType)sandboxCacheType
{
    if (!responseObject || !resourceName) { return NO; }
    if (![GAUserSetting UserID]) { return NO ;}
    
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary* responseObjectData = (NSDictionary* )responseObject;
        resourceName = [resourceName stringByAppendingPathComponent:@"_dic"];
        if ([self createCacheFileWithResourceName:resourceName cacheType:sandboxCacheType]) {
            NSString* path = [self cacheFilePathWithResourceName:resourceName cacheType:sandboxCacheType];
            return [responseObjectData writeToFile:path atomically:YES];
        }else{
            return NO;
        }
    }
    
    if ([responseObject isKindOfClass:[NSArray class]]) {
        NSArray* responseObjectData = (NSArray* )responseObject;
        resourceName = [resourceName stringByAppendingPathComponent:@"_arr"];
        if ([self createCacheFileWithResourceName:resourceName cacheType:sandboxCacheType]) {
            NSString* path = [self cacheFilePathWithResourceName:resourceName cacheType:sandboxCacheType];
            return [responseObjectData writeToFile:path atomically:YES];
        }else{
            return NO;
        }
    }
    
    return NO;
}

+ (nullable id)responseObjectWithResource:(NSString* )resourceName
                                cacheType:(SandboxCacheType)sandboxCacheType
{
    
    NSString* dicResourcePath = [self cacheFilePathWithResourceName:[resourceName stringByAppendingPathComponent:@"_dic"] cacheType:sandboxCacheType];
    NSString* arrResourcePath = [self cacheFilePathWithResourceName:[resourceName stringByAppendingPathComponent:@"_arr"] cacheType:sandboxCacheType];
    if ([[NSFileManager defaultManager] fileExistsAtPath:dicResourcePath]) {
        return [NSDictionary dictionaryWithContentsOfFile:dicResourcePath];
    }else if ([[NSFileManager defaultManager] fileExistsAtPath:[self cacheFilePathWithResourceName:arrResourcePath cacheType:sandboxCacheType]]){
        return [NSArray arrayWithContentsOfFile:arrResourcePath];
    }else{
        return nil;
    }
}


///< file M
#pragma mark - Private
+ (NSString* )_customCache_cacheFolderPath:(NSString* )folderName
{
    NSString* custom_cacheFolderPath = [NSString cachesFolderPath];
    custom_cacheFolderPath = [custom_cacheFolderPath stringByAppendingPathComponent:folderName];
    
    BOOL isDir = NO; BOOL isCreated = NO;
    BOOL isExisted = [[NSFileManager defaultManager] fileExistsAtPath:custom_cacheFolderPath isDirectory:&isDir];
    if (!(isDir && isExisted)) {
        isCreated = [[NSFileManager defaultManager] createDirectoryAtPath:custom_cacheFolderPath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    if (isExisted) { isCreated = YES; }
    
    return  isCreated ? custom_cacheFolderPath : nil;
}

+ (NSArray* )_sandboxCacheTypes{
    return @[SandboxCacheType_listFolderName,SandboxCacheType_detailFolderName,SandboxCacheType_otherFolderName,SandboxCacheType_temporaryFolderName,SandboxCacheType_webViewImagesFolderName];
}

#pragma mark - Public
+ (nullable NSDate* )getFileCreatDateWithResourceName:(NSString* )resourceName
                                            cacheType:(SandboxCacheType)sandboxCacheType
{
    NSString* path = [self cacheFilePathWithResourceName:resourceName cacheType:sandboxCacheType];
    BOOL isExists = [[NSFileManager defaultManager] fileExistsAtPath:path];
    if (isExists) {
        NSDictionary* dic = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:NULL];
        return [dic valueForKey:NSFileCreationDate];
    }else{
        return nil;
    }
}

+ (NSString* )cacheFilePathWithResourceName:(NSString* )resourceName
                                  cacheType:(SandboxCacheType)sandboxCacheType
{
    resourceName = [NSString stringWithFormat:@"%@.json",resourceName];
    NSString* customFolder = [self _sandboxCacheTypes][sandboxCacheType];
    NSString* cacheFilePath = [self _customCache_cacheFolderPath:customFolder];
    return [cacheFilePath stringByAppendingPathComponent:resourceName];
}

+ (BOOL)createCacheFileWithResourceName:(NSString* )resourceName
                              cacheType:(SandboxCacheType)sandboxCacheType
{
    NSString* path = [self cacheFilePathWithResourceName:resourceName cacheType:sandboxCacheType];
    NSFileManager* fileManger = [NSFileManager defaultManager];
    BOOL isExists = [fileManger fileExistsAtPath:path];
    BOOL isCreated = NO;
    if (!isExists) {
        isCreated = [fileManger createFileAtPath:path contents:[NSData data] attributes:nil];
    }else{
        isCreated = YES;
    }
    return isCreated;
}


@end




#pragma mark - tip windows

#import "UIViewController+Collection.h"

#import "JDStatusBarNotification.h"
#import <MBProgressHUD.h>

#define kStatusBarTip_Auto_Dismiss 2.0

NSString* const loginTip                    = @"正在登陆";
NSString* const registerTip                 = @"正在注册";

NSString* const networkErrorTip             = @"网络似乎出了点问题,获取数据失败";
NSString* const networkNeedLoginTip         = @"操作失败,建议重新登录";
NSString* const networkAuthorizationTip     = @"貌似您没有权限进行这个操作哦~";
NSString* const networkSendingTip           = @"正在发送中";
NSString* const networkOperationTip         = @"操作正在保存";

@implementation NSObject (ShowTip)

+ (void)showHUD:(NSString* )str{
    [self hideStatusNoti];
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:[UIViewController currentViewController].view animated:YES];
    if (str && str.length > 0) {
        hud.label.text = str;
    }
    
}
+ (void)showStatusNoti:(NSString* )str{
    if (!str || [str isEqual:(id)kCFNull])  return;
    [self hideAllHUD];
    
    if ([str isEqualToString:networkErrorTip]) {
        [JDStatusBarNotification showWithStatus:str styleName:JDStatusBarStyleError];
    }else if ([str isEqualToString:networkNeedLoginTip] || [str isEqualToString:networkAuthorizationTip]) {
        [JDStatusBarNotification showWithStatus:str styleName:JDStatusBarStyleWarning];
    }else{
        [JDStatusBarNotification showWithStatus:str styleName:JDStatusBarStyleSuccess];
    }
}

+ (void)hideAllTip{
    [self hideAllHUD];
    [self hideStatusNoti];
}
+ (void)hideAllHUD{
    [MBProgressHUD hideHUDForView:[UIViewController currentViewController].view animated:YES];
}
+ (void)hideStatusNoti{
    [JDStatusBarNotification dismissAnimated:YES];
}

@end








