//
//  NSObject+Collection.h
//  Genius_IM
//
//  Created by Graphic-one on 17/3/2.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - serialize
/** cache comment*/
typedef NS_ENUM (NSInteger,SandboxCacheType){
    SandboxCacheType_list               = 0,
    SandboxCacheType_detail             = 1,
    SandboxCacheType_other              = 2,
    SandboxCacheType_temporary          = 3,
    SandboxCacheType_webViewImages      = 4,
    
    SandboxCacheTypeNone                = -100,
};///新增缓存类型需要更新 +(NSArray* )_sandboxCacheTypes;
FOUNDATION_EXPORT NSString * const SandboxCacheType_listFolderName;
FOUNDATION_EXPORT NSString * const SandboxCacheType_detailFolderName;
FOUNDATION_EXPORT NSString * const SandboxCacheType_otherFolderName;
FOUNDATION_EXPORT NSString * const SandboxCacheType_temporaryFolderName;
FOUNDATION_EXPORT NSString * const SandboxCacheType_webViewImagesFolderName;

@interface NSObject (Serialize)

/** resource name constructor */
+ (NSString* )cacheResourceNameWithURL:(NSString* )requestUrl
               parameterDictionaryDesc:(nullable NSString* )paraDicDesc;
/** networking Handle */
+ (BOOL)handleResponseObject:(id)responseObject
                    resource:(NSString* )resourceName
                   cacheType:(SandboxCacheType)sandboxCacheType;

+ (nullable id)responseObjectWithResource:(NSString* )resourceName
                                cacheType:(SandboxCacheType)sandboxCacheType;

///< file M
+ (nullable NSDate* )getFileCreatDateWithResourceName:(NSString* )resourceName
                                            cacheType:(SandboxCacheType)sandboxCacheType;///< 获取文件的创建日期

+ (NSString* )cacheFilePathWithResourceName:(NSString* )resourceName
                                  cacheType:(SandboxCacheType)sandboxCacheType;///< 根据'resourceName'获取文件的全路径

+ (BOOL)createCacheFileWithResourceName:(NSString* )resourceName
                              cacheType:(SandboxCacheType)sandboxCacheType;///< 根据'resourceName'创建缓存文件夹下面的文件

@end



#pragma mark - tip windows
/** business tips */
FOUNDATION_EXTERN NSString* const loginTip;
FOUNDATION_EXTERN NSString* const registerTip;

/** global tips */
FOUNDATION_EXTERN NSString* const networkErrorTip;
FOUNDATION_EXTERN NSString* const networkNeedLoginTip;
FOUNDATION_EXTERN NSString* const networkAuthorizationTip;
FOUNDATION_EXTERN NSString* const networkSendingTip;
FOUNDATION_EXTERN NSString* const networkOperationTip;

@interface NSObject (ShowTip)

+ (void)showHUD:(NSString* )str;
+ (void)showStatusNoti:(NSString* )str;

+ (void)hideAllTip;
+ (void)hideAllHUD;
+ (void)hideStatusNoti;

@end





NS_ASSUME_NONNULL_END







