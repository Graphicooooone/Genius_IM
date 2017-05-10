//
//  GAUser.h
//  Genius_IM
//
//  Created by Graphic-one on 17/2/23.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GAUser : NSObject

@property (nonatomic,strong) NSString* id;///<Primary Key

@property (nonatomic,strong) NSString* name;

@property (nonatomic,strong) NSString* phone;

@property (nonatomic,strong) NSString* portrait;

@property (nonatomic,strong) NSString* desc;

@property (nonatomic,assign) UserSex sex;

//extra

@property (nonatomic,assign) UserFollowStatus isFollow;

@property (nonatomic,strong) NSString* alias;

@end
