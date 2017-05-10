//
//  NSObject+YYKit_GA.m
//  Genius_IM
//
//  Created by Graphic-one on 17/3/9.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "NSObject+YYKit_GA.h"

@implementation NSObject (YYKit_GA)

@end


/** YYKit hook性分类 */

/** YYKit 补充性分类 */
@implementation YYImageCache (YYImageCache_GA)

+ (instancetype)GAShareCache{
    YYImageCache* cache = [[YYImageCache alloc] initWithPath:[[NSString cachesFolderPath] stringByAppendingPathComponent:@"YYImageCache_GA"]];
    return cache;
}

@end
