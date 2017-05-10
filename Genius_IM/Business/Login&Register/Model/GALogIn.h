//
//  GALogIn.h
//  Genius_IM
//
//  Created by Graphic-one on 17/3/1.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GALogIn : NSObject

@property (nonatomic,strong) NSString* userName;

@property (nonatomic,strong) NSString* password;

- (instancetype)initWithUserName:(NSString* )userName
                        password:(NSString* )password;

@end
