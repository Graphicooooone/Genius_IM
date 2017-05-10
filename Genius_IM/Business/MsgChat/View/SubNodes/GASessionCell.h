//
//  GASessionCell.h
//  Genius_IM
//
//  Created by Graphic-one on 17/2/7.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "GAMsgChatCell.h"

#import <objc/runtime.h>

UIKIT_EXTERN NSString* const GATextCellIdentifier;
UIKIT_EXTERN NSString* const GAImageCellIdentifier;
UIKIT_EXTERN NSString* const GAVideoCellIdentifier;
UIKIT_EXTERN NSString* const GAVoiceCellIdentifier;
UIKIT_EXTERN NSString* const GALocationCellIdentifier;
UIKIT_EXTERN NSString* const GAFileCellIdentifier;

/** 中间类 提供共享资源 */
@interface GASessionCell : GAMsgChatCell

///< share resouce ... 
+ (CALayer* )maskLayer;
- (CALayer* )maskLayer;

+ (NSDictionary* )linkTextAttributes;
- (NSDictionary* )linkTextAttributes;

+ (UIImage* )sendingImage;
- (UIImage* )sendingImage;

+ (UIImage* )sendedImage;
- (UIImage* )sendedImage;

+ (UIImage* )readedImage;
- (UIImage* )readedImage;

@end
