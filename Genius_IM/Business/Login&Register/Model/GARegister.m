//
//  GARegister.m
//  Genius_IM
//
//  Created by Graphic-one on 17/3/1.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "GARegister.h"

@implementation GARegister

- (instancetype)initWithAccount:(NSString* )account
                       password:(NSString* )password
                           name:(NSString* )name
{
    self = [super init];
    if (self) {
        _account = account;
        _password = password;
        _name = name;
    }
    return self;
}

@end
