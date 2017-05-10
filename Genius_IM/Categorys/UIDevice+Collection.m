//
//  UIDevice+Collection.m
//  Genius_IM
//
//  Created by Peter Gra on 2017/4/5.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "UIDevice+Collection.h"

#pragma mark - JailBreak
/** 设备越狱判断 */
static const char* jailbreak_apps[] =
{
    "/Applications/limera1n.app",
    "/Applications/greenpois0n.app",
    "/Applications/blackra1n.app",
    "/Applications/blacksn0w.app",
    "/Applications/redsn0w.app",
    "/Applications/Absinthe.app",
    NULL,
};

@implementation UIDevice (JailBreak)

+ (BOOL)isJailBreakDevice{
    NSString* cydiaPath = @"/Applications/Cydia.app";
    NSString* aptPath = @"/private/var/lib/apt";
    
    ///< base check ...
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath] ||
        [[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
        return YES;
    }
    
    ///< more check ...
    for (int i = 0 ; jailbreak_apps[i] != NULL; i++) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:jailbreak_apps[i]]]) {
            NSLog(@"jailbreak_apps_name : %@",[NSString stringWithUTF8String:jailbreak_apps[i]]);
            return YES;
        }
    }
    
    return NO;
}

@end
