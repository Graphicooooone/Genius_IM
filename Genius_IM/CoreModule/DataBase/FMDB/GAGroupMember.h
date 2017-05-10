//
//  GAGroupMember.h
//  Genius_IM
//
//  Created by Graphic-one on 17/2/23.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GAUser,GAGroup;

@interface GAGroupMember : NSObject

@property (nonatomic,strong) NSString* id;///<Primary Key

@property (nonatomic,strong) NSString* alias;

@property (nonatomic,strong) NSString* groupId;
@property (nonatomic,strong,readonly) GAGroup* group;

@property (nonatomic,strong) NSString* userId;
@property (nonatomic,strong,readonly) GAUser* user;

@end
