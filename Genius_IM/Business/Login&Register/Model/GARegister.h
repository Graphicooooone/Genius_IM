//
//  GARegister.h
//  Genius_IM
//
//  Created by Graphic-one on 17/3/1.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GARegister : NSObject

@property (nonatomic,strong) NSString* account;

@property (nonatomic,strong) NSString* password;

@property (nonatomic,strong) NSString* name;

- (instancetype)initWithAccount:(NSString* )account
                       password:(NSString* )password
                           name:(NSString* )name;

@end
