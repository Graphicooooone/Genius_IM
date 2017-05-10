//
//  GAImageHelper.h
//  Genius_IM
//
//  Created by Graphic-one on 17/2/10.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GAImageHelper : NSObject

+ (UIImage* )ImageHelperWithOriginImage:(UIImage* )originImage
                            statusVaule:(UserStatus)status;

+ (UIImage* )ImageHelperWithOriginImage:(UIImage *)originImage
                            statusVaule:(UserStatus)status
                               decorate:(nullable UIImage* )decorateImage;

+ (UIImage* )ImageHelperWithOriginImage:(UIImage* )originImage
                            statusVaule:(UserStatus)status
                                 radius:(CGFloat)radius;

+ (UIImage* )ImageHelperWithOriginImage:(UIImage *)originImage
                            statusVaule:(UserStatus)status
                               decorate:(nullable UIImage* )decorateImage
                                 radius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
