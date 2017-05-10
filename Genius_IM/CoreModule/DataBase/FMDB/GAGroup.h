//
//  GAGroup.h
//  Genius_IM
//
//  Created by Graphic-one on 17/2/23.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GAGroupMember;

@interface GAGroup : NSObject

@property (nonatomic,strong) NSString* id;///<Primary Key

@property (nonatomic,strong) NSString* name;

@property (nonatomic,strong) NSString* desc;

@property (nonatomic,strong) NSString* pricture;

@property (nonatomic,strong,readonly) NSString* createrId;
@property (nonatomic,strong) GAGroupMember* creater;

@end
