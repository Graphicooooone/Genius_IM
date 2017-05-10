//
//  GAModel.h
//  Genius_IM
//
//  Created by Graphic-one on 17/2/4.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 泛型model */
@interface GAModel<ObjectType> : NSObject

@property (nonatomic,assign) ResultCode code;

@property (nonatomic,strong) NSString* message;

@property (nonatomic,strong) NSString* time;

@end
