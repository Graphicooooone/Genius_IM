//
//  GARLMUser.h
//  Genius_IM
//
//  Created by Graphic-one on 17/2/28.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <Realm/Realm.h>

@interface GARLMUser : RLMObject

@property NSString* id;

@property NSString* name;

@property NSString* phone;

@property NSString* portrait;

@property NSString* desc;

@property UserSex sex;

//extra
@property UserFollowStatus isFollow;

@property NSString* alias;

@end

