//
//  GASessionCell.m
//  Genius_IM
//
//  Created by Graphic-one on 17/2/7.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "GASessionCell.h"

@implementation GASessionCell

///< shareMaskLayer
static CALayer* _shareMaskLayer;
+ (CALayer* )shareMaskLayer{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareMaskLayer = [CALayer layer];
        _shareMaskLayer.backgroundColor = kMsgChatDefaultMaskColor.CGColor;
    });
    return _shareMaskLayer;
}
+ (CALayer* )maskLayer{
    if (!_shareMaskLayer || _shareMaskLayer == (id)kCFNull) {
        [self shareMaskLayer];
    }
    return _shareMaskLayer;
}
- (CALayer* )maskLayer{
    if (!_shareMaskLayer || _shareMaskLayer == (id)kCFNull) {
        [[self class] shareMaskLayer];
    }
    return _shareMaskLayer;
}

///< shareLinkTextAttributes
static NSDictionary* _shareLinkTextAttributes;
+ (NSDictionary* )shareLinkTextAttributes{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareLinkTextAttributes = @{
                                    NSForegroundColorAttributeName  : kMsgChatDefaultLinkColor ,
                                     };
    });
    return _shareLinkTextAttributes;
}
+ (NSDictionary* )linkTextAttributes{
    if (!_shareLinkTextAttributes || _shareLinkTextAttributes == (id)kCFNull) {
        [self shareLinkTextAttributes];
    }
    return _shareLinkTextAttributes;
}
- (NSDictionary* )linkTextAttributes{
    if (!_shareLinkTextAttributes || _shareLinkTextAttributes == (id)kCFNull) {
        [[self class] shareLinkTextAttributes];
    }
    return _shareLinkTextAttributes;
}

///< status Image ...
static UIImage* _shareSendingImage;
+ (UIImage* )shareSendingImage{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareSendingImage = [UIImage imageNamed:@""];
    });
    return _shareSendingImage;
}
static UIImage* _shareSendedImage;
+ (UIImage* )shareSendedImage{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareSendedImage = [UIImage imageNamed:@""];
    });
    return _shareSendedImage;
}
static UIImage* _shareReadedImage;
+ (UIImage* )shareReadedImage{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareReadedImage = [UIImage imageNamed:@""];
    });
    return _shareReadedImage;
}
+ (UIImage* )sendingImage{
    if (!_shareSendingImage || _shareSendingImage == (id)kCFNull) {
        [self shareSendingImage];
    }
    return _shareSendingImage;
}
- (UIImage* )sendingImage{
    if (!_shareSendingImage || _shareSendingImage == (id)kCFNull) {
        [[self class] shareSendingImage];
    }
    return _shareSendingImage;
}
+ (UIImage* )sendedImage{
    if (!_shareSendedImage || _shareSendedImage == (id)kCFNull) {
        [self shareSendedImage];
    }
    return _shareSendedImage;
}
- (UIImage* )sendedImage{
    if (!_shareSendedImage || _shareSendedImage == (id)kCFNull) {
        [[self class] shareSendedImage];
    }
    return _shareSendedImage;
}
+ (UIImage* )readedImage{
    if (!_shareReadedImage || _shareReadedImage == (id)kCFNull) {
        [self shareReadedImage];
    }
    return _shareReadedImage;
}
- (UIImage* )readedImage{
    if (!_shareReadedImage || _shareReadedImage == (id)kCFNull) {
        [[self class] shareReadedImage];
    }
    return _shareReadedImage;
}

@end
