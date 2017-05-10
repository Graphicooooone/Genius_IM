//
//  GAMessage.h
//  Genius_IM
//
//  Created by Graphic-one on 17/2/23.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GAUser,GAGroup;

@interface GAMessage : NSObject

@property (nonatomic,strong) NSString* id;///<Primary Key

@property (nonatomic,strong) NSString* content;

@property (nonatomic,strong) NSString* attach;

@property (nonatomic,assign) MessageType type;

@property (nonatomic,strong) NSString* pushlish;

@property (nonatomic,assign) MessageStatus status;

@property (nonatomic,strong) NSString* senderId;
@property (nonatomic,strong,readonly) GAUser* sender;

@property (nonatomic,strong) NSString* groupId;
@property (nonatomic,strong,readonly) GAGroup* group;

@property (nonatomic,strong) NSString* receiverId;
@property (nonatomic,strong,readonly) GAUser* receiver;

@end
