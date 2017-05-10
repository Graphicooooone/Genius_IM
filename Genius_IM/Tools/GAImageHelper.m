//
//  GAImageHelper.m
//  Genius_IM
//
//  Created by Graphic-one on 17/2/10.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "GAImageHelper.h"

@implementation GAImageHelper

+ (UIImage *)ImageHelperWithOriginImage:(UIImage *)originImage
                            statusVaule:(UserStatus)status
{
    return [self ImageHelperWithOriginImage:originImage statusVaule:status decorate:nil radius:(originImage.size.width * 0.5)];
}

+ (UIImage *)ImageHelperWithOriginImage:(UIImage *)originImage
                            statusVaule:(UserStatus)status
                               decorate:(UIImage *)decorateImage
{
    return [self ImageHelperWithOriginImage:originImage statusVaule:status decorate:decorateImage radius:(originImage.size.width * 0.5)];
}

+ (UIImage *)ImageHelperWithOriginImage:(UIImage *)originImage
                            statusVaule:(UserStatus)status
                                 radius:(CGFloat)radius
{
    return nil;
}

+ (UIImage *)ImageHelperWithOriginImage:(UIImage *)originImage
                            statusVaule:(UserStatus)status
                               decorate:(UIImage *)decorateImage
                                 radius:(CGFloat)radius
{
    return nil;
}

@end
