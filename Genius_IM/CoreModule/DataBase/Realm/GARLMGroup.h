//
//  GARLMGroup.h
//  Genius_IM
//
//  Created by Graphic-one on 17/2/28.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <Realm/Realm.h>

@class GARLMGroupMember;

@interface GARLMGroup : RLMObject

@property NSString* id;

@property NSString* name;

@property NSString* desc;

@property NSString* pricture;

@property GARLMGroupMember* creater;

@end
