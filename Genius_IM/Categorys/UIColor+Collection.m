//
//  UIColor+Collection.m
//  Genius_IM
//
//  Created by Graphic-one on 17/3/1.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "UIColor+Collection.h"

@implementation UIColor (Collection)

+ (instancetype)ColorWithHex:(int)hexValue alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue  & 0xFF))/255.0
                           alpha:alpha];
}
+ (instancetype)ColorWithHex:(int)hexValue{
    return [self ColorWithHex:hexValue alpha:1.0];
}

@end
