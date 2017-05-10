//
//  GARLMGroupMember.h
//  Genius_IM
//
//  Created by Graphic-one on 17/2/28.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <Realm/Realm.h>

@class GARLMGroup,GARLMUser;

@interface GARLMGroupMember : RLMObject

@property NSString* id;

@property NSString* alias;

@property GARLMGroup* group;

@property GARLMUser* user;

@property NSString* userId;

@end
