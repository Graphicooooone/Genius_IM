//
//  GALogIn.m
//  Genius_IM
//
//  Created by Graphic-one on 17/3/1.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "GALogIn.h"

@implementation GALogIn

- (instancetype)initWithUserName:(NSString *)userName password:(NSString *)password{
    self = [super init];
    if (self) {
        _userName = userName;
        _password = password;
    }
    return self;
}

@end
