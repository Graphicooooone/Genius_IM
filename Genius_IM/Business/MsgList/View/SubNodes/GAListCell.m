//
//  GAListCell.m
//  Genius_IM
//
//  Created by Graphic-one on 17/2/10.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "GAListCell.h"

@implementation GAListCell

static UIImage* _PortraitImage;
+ (UIImage *)PortraitImage{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _PortraitImage = [UIImage imageNamed:@""];
    });
    return _PortraitImage;
}

@end
