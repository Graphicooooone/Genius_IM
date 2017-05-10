//
//  UIDevice+Collection.h
//  Genius_IM
//
//  Created by Peter Gra on 2017/4/5.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - JailBreak
/** 设备越狱判断 */
@interface UIDevice (JailBreak)

+ (BOOL)isJailBreakDevice;

@end
