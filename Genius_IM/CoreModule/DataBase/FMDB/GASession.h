//
//  GASession.h
//  Genius_IM
//
//  Created by Graphic-one on 17/2/24.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GAMessage;

@interface GASession : NSObject

@property (nonatomic,strong) NSString* id;///<Primary Key

@property (nonatomic,assign) SessionType type;

@property (nonatomic,strong) NSString* picture;

@property (nonatomic,strong) NSString* title;

@property (nonatomic,strong) NSString* content;

@property (nonatomic,strong) NSString* pushlish;

@property (nonatomic,assign) NSUInteger nuReadCount;

@property (nonatomic,strong) NSString* messageId;
@property (nonatomic,strong,readonly) GAMessage* message;

@end
