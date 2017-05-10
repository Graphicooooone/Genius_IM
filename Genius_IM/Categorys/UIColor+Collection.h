//
//  UIColor+Collection.h
//  Genius_IM
//
//  Created by Graphic-one on 17/3/1.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Collection)

+ (instancetype)ColorWithHex:(int)hexValue alpha:(CGFloat)alpha;

+ (instancetype)ColorWithHex:(int)hexValue;

@end
