//
//  GARLMMessage.h
//  Genius_IM
//
//  Created by Graphic-one on 17/2/28.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <Realm/Realm.h>

@class GARLMUser,GARLMGroup;

@interface GARLMMessage : RLMObject

@property NSString* id;

@property NSString* content;

@property NSString* attach;

@property MessageType type;

@property NSDate* pushlish;

@property MessageStatus status;

@property NSString* senderId;
@property GARLMUser* sender;

@property NSString* groupId;
@property GARLMGroup* group;

@property NSString* receiverId;
@property GARLMUser* receiver;

@end
