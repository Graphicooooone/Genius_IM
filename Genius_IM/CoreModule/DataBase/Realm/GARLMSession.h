//
//  GARLMSession.h
//  Genius_IM
//
//  Created by Graphic-one on 17/2/28.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <Realm/Realm.h>

@class GARLMMessage;

@interface GARLMSession : RLMObject

@property NSString* id;

@property SessionType type;

@property NSString* picture;

@property NSString* title;

@property NSString* content;

@property NSString* pushlish;

@property NSUInteger nuReadCount;

@property GARLMMessage* message;

@end
