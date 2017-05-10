//
//  GAThemeHelper.m
//  Genius_IM
//
//  Created by Graphic-one on 17/1/23.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "GAThemeHelper.h"

/** UserDefault keys*/
NSString * const GAUserDefaultsCurThemme = @"GAUserDefaultsCurThemme";

/** default UI setting */
///< about naviBar ...
NSString* const GAThemeHelper_NaviBar_BgColor_Key = @"GAThemeHelperNaviBarBgColorKey";
NSString* const GAThemeHelper_NaviBar_Title_TextColor_Key = @"GAThemeHelperNaviBarTitleTextColorKey";
NSString* const GAThemeHelper_NaviBar_Title_TextFontName_Key = @"GAThemeHelperNaviBarTitleTextFontNameKey";
NSString* const GAThemeHelper_NaviBar_Title_TextFontSize_Key = @"GAThemeHelperNaviBarTitleTextFontSizeKey";
NSString* const GAThemeHelper_NaviBar_Item_TextColor_Key = @"GAThemeHelperNaviBarItemTextColorKey";
NSString* const GAThemeHelper_NaviBar_Item_TextFontName_Key = @"GAThemeHelperNaviBarItemTextFontNameKey";
NSString* const GAThemeHelper_NaviBar_Item_TextFontSize_Key = @"GAThemeHelperNaviBarItemTextFontSizeKey";
///< about tabBar ...
NSString* const GAThemeHelper_TabBar_BgColor_Key = @"GAThemeHelperTabBarBgColorKey";
NSString* const GAThemeHelper_TabBar_Item_TextColor_Key = @"GAThemeHelperTabBarItemTextColorKey";
NSString* const GAThemeHelper_TabBar_Item_TextFontName_Key = @"GAThemeHelperTabBarItemTextFontNameKey";
NSString* const GAThemeHelper_TabBar_Item_TextFontSize_Key = @"GAThemeHelperTabBarItemTextFontSizeKey";
NSString* const GAThemeHelper_TabBar_Item_Images_Key = @"GAThemeHelperTabBarItemImagesKey";

/** about msgList theme */
NSString* const GAThemeHelper_MsgList_BgColor_Key = @"GAThemeHelperMsgListBgColorKey";
NSString* const GAThemeHelper_MsgList_TextColor_Key = @"GAThemeHelperMsgListTextColorKey";
NSString* const GAThemeHelper_MsgList_TextFontName_Key = @"GAThemeHelperMsgListTextFontNameKey";
NSString* const GAThemeHelper_MsgList_TextFontSize_Key = @"GAThemeHelperMsgListTextFontSizeKey";

/** about msgChat theme */
NSString* const GAThemeHelper_MsgChat_SenderBgColor_Key = @"GAThemeHelperMsgChatSenderBgColorKey";
NSString* const GAThemeHelper_MsgChat_SenderTextColor_Key = @"GAThemeHelperMsgChatSenderTextColorKey";
NSString* const GAThemeHelper_MsgChat_SenderTextFontName_Key = @"GAThemeHelperMsgChatSenderTextFontNameKey";
NSString* const GAThemeHelper_MsgChat_SenderTextFontSize_Key = @"GAThemeHelperMsgChatSenderTextFontSizeKey";

NSString* const GAThemeHelper_MsgChat_SelfBgColor_Key = @"GAThemeHelperMsgChatSelfBgColorKey";
NSString* const GAThemeHelper_MsgChat_SelfTextColor_Key = @"GAThemeHelperMsgChatSelfTextColorKey";
NSString* const GAThemeHelper_MsgChat_SelfTextFontName_Key = @"GAThemeHelperMsgChatSelfTextFontNameKey";
NSString* const GAThemeHelper_MsgChat_SelfTextFontSize_Key = @"GAThemeHelperMsgChatSelfTextFontSizeKey";

@interface GAThemeHelper ()
@property (nonatomic,strong,readwrite) NSDictionary* themeList;
@end

@implementation GAThemeHelper

#pragma mark - Private
+ (NSDictionary* )_defaultThemeList{
    static NSDictionary* _shareDefaultThemeList;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareDefaultThemeList = @{
       GAThemeHelper_NaviBar_BgColor_Key : kUINaviBarDefaultBgColor,///< about naviBar ...
       GAThemeHelper_NaviBar_Title_TextColor_Key : kUINaviBarDefaultTitleTextColor,
       GAThemeHelper_NaviBar_Title_TextFontName_Key : kUINaviBarDefaultTitleTextFontName,
       GAThemeHelper_NaviBar_Title_TextFontSize_Key : @(kUINaviBarDefaultTitleTextFontSize),
       GAThemeHelper_NaviBar_Item_TextColor_Key : kUINaviBarDefaultItemTextColor,
       GAThemeHelper_NaviBar_Item_TextFontName_Key : kUINaviBarDefaultItemTextFontName,
       GAThemeHelper_NaviBar_Item_TextFontSize_Key : @(kUINaviBarDefaultItemTextFontSize),
       
       GAThemeHelper_TabBar_BgColor_Key : kUITabBarDefaultBgColor,///< about tabBar ...
       GAThemeHelper_TabBar_Item_TextColor_Key : kUITabBarDefaultItemTextColor,
       GAThemeHelper_TabBar_Item_TextFontName_Key : kUITabBarDefaultItemTextFontName,
       GAThemeHelper_TabBar_Item_TextFontSize_Key : @(kUITabBarDefaultItemTextFontSize),
       GAThemeHelper_TabBar_Item_Images_Key : kUITabBarDefaultItemImages,
       
       GAThemeHelper_MsgList_BgColor_Key : kMsgListDefaultBgColor,/** about msgList theme */
       GAThemeHelper_MsgList_TextColor_Key : kMsgListDefaultTextColor,
       GAThemeHelper_MsgList_TextFontName_Key : kMsgListDefaultTextFontName,
       GAThemeHelper_MsgList_TextFontSize_Key : @(kMsgListDefaultTextFontSize),
       
       GAThemeHelper_MsgChat_SenderBgColor_Key : kMsgChatSenderDefaultBgColor,///< sender theme setting ...
       GAThemeHelper_MsgChat_SenderTextColor_Key : kMsgChatSenderDefaultTextColor,
       GAThemeHelper_MsgChat_SenderTextFontName_Key : kMsgChatSenderDefaultTextFontName,
       GAThemeHelper_MsgChat_SenderTextFontSize_Key : @(kMsgChatDefaultFontSize),
       
       GAThemeHelper_MsgChat_SelfBgColor_Key : kMsgChatSelfDefaultBgColor,///< self theme setting ...
       GAThemeHelper_MsgChat_SelfTextColor_Key : kMsgChatSelfDefaultTextColor,
       GAThemeHelper_MsgChat_SelfTextFontName_Key : kMsgChatSelfDefaultTextFontName,
       GAThemeHelper_MsgChat_SelfTextFontSize_Key : @(kMsgChatDefaultFontSize),
                                   };
    });
    return _shareDefaultThemeList;
}

#pragma mark - Public
static GAThemeHelper* _shareThemeHelper;
+ (instancetype)shareThemeHelper{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareThemeHelper = [GAThemeHelper new];
        id value = [[NSUserDefaults standardUserDefaults] valueForKey:GAUserDefaultsCurThemme];
        if (value && ![value isEqual:[NSNull null]] && [value isKindOfClass:[NSDictionary class]]) {
            _shareThemeHelper.themeList = (NSDictionary* )value;
        }else{
            _shareThemeHelper.themeList = [self _defaultThemeList];
        }
    });
    return _shareThemeHelper;
}

- (NSDictionary *)themeList{
    if (!_themeList || [_themeList isEqual:[NSNull null]]) return [[self class] _defaultThemeList];
    return _themeList;
}

+ (void)updateThemeList:(NSDictionary* )themeList{
    if (!themeList || [themeList isEqual:[NSNull null]]) return;
    if (!_shareThemeHelper || [_shareThemeHelper isEqual:[NSNull null]]) [self shareThemeHelper];
    
    _shareThemeHelper.themeList = themeList;
}

+ (void)update2ThemeListWithKey:(NSString* )key value:(id)value{
    if (!key || [key isEqual:[NSNull null]] || !value || [value isEqual:[NSNull null]]) return;
    if (!_shareThemeHelper || [_shareThemeHelper isEqual:[NSNull null]]) [self shareThemeHelper];

    NSMutableDictionary* mDic = _shareThemeHelper.themeList.mutableCopy;
    [mDic setValue:value forKey:key];
    _shareThemeHelper.themeList = mDic.copy;
}


#pragma mark - global UI setting ...
/** global UI setting */
///< about naviBar ...
+ (UIColor* )naviBar_BgColor{
    if (!_shareThemeHelper || [_shareThemeHelper isEqual:[NSNull null]]) [self shareThemeHelper];
    
    UIColor* color = _shareThemeHelper.themeList[GAThemeHelper_NaviBar_BgColor_Key];
    if (!color || [color isEqual:[NSNull null]]) {
        color = kUINaviBarDefaultBgColor;
    }
    return color;
}
+ (UIColor* )naviBar_Title_TextColor{
    if (!_shareThemeHelper || [_shareThemeHelper isEqual:[NSNull null]]) [self shareThemeHelper];

    UIColor* color = _shareThemeHelper.themeList[GAThemeHelper_NaviBar_Title_TextColor_Key];
    if (!color || [color isEqual:[NSNull null]]) {
        color = kUINaviBarDefaultTitleTextColor;
    }
    return color;
}
+ (NSString*)naviBar_Title_TextFontName{
    if (!_shareThemeHelper || [_shareThemeHelper isEqual:[NSNull null]]) [self shareThemeHelper];

    NSString* font = _shareThemeHelper.themeList[GAThemeHelper_NaviBar_Title_TextFontName_Key];
    if (!font || [font isEqual:[NSNull null]]) {
        font = kUINaviBarDefaultTitleTextFontName;
    }
    return font;
}
+ (CGFloat)naviBar_Title_TextFontSize{
    if (!_shareThemeHelper || [_shareThemeHelper isEqual:[NSNull null]]) [self shareThemeHelper];

    CGFloat size = [_shareThemeHelper.themeList[GAThemeHelper_NaviBar_Title_TextFontSize_Key] floatValue];
    if (size == CGFLOAT_MIN || size == 0) {
        size = kUINaviBarDefaultTitleTextFontSize;
    }
    return size;
}
+ (UIColor* )naviBar_Item_TextColor{
    if (!_shareThemeHelper || [_shareThemeHelper isEqual:[NSNull null]]) [self shareThemeHelper];

    UIColor* color = _shareThemeHelper.themeList[GAThemeHelper_NaviBar_Item_TextColor_Key];
    if (!color || [color isEqual:[NSNull null]]) {
        color = kUINaviBarDefaultItemTextColor;
    }
    return color;
}
+ (NSString*)naviBar_Item_TextFontName{
    if (!_shareThemeHelper || [_shareThemeHelper isEqual:[NSNull null]]) [self shareThemeHelper];

    NSString* font = _shareThemeHelper.themeList[GAThemeHelper_NaviBar_Item_TextFontName_Key];
    if (!font || [font isEqual:[NSNull null]]) {
        font = kUINaviBarDefaultItemTextFontName;
    }
    return font;
}
+ (CGFloat)naviBar_Item_TextFontSize{
    if (!_shareThemeHelper || [_shareThemeHelper isEqual:[NSNull null]]) [self shareThemeHelper];

    CGFloat size = [_shareThemeHelper.themeList[GAThemeHelper_NaviBar_Item_TextFontSize_Key] floatValue];
    if (size == CGFLOAT_MIN || size == 0) {
        size = kUINaviBarDefaultItemTextFontSize;
    }
    return size;
}
///< about tabBar ...
+ (UIColor* )tabBar_BgColor{
    if (!_shareThemeHelper || [_shareThemeHelper isEqual:[NSNull null]]) [self shareThemeHelper];

    UIColor* color = _shareThemeHelper.themeList[GAThemeHelper_TabBar_BgColor_Key];
    if (!color || [color isEqual:[NSNull null]]) {
        color = kUITabBarDefaultBgColor;
    }
    return color;
}
+ (UIColor* )tabBar_Item_TextColor{
    if (!_shareThemeHelper || [_shareThemeHelper isEqual:[NSNull null]]) [self shareThemeHelper];

    UIColor* color = _shareThemeHelper.themeList[GAThemeHelper_TabBar_Item_TextColor_Key];
    if (!color || [color isEqual:[NSNull null]]) {
        color = kUITabBarDefaultItemTextColor;
    }
    return color;
}
+ (NSString*)tabBar_Item_TextFontName{
    if (!_shareThemeHelper || [_shareThemeHelper isEqual:[NSNull null]]) [self shareThemeHelper];

    NSString* font = _shareThemeHelper.themeList[GAThemeHelper_TabBar_Item_TextFontName_Key];
    if (!font || [font isEqual:[NSNull null]]) {
        font = kUITabBarDefaultItemTextFontName;
    }
    return font;
}
+ (CGFloat)tabBar_Item_TextFontSize{
    if (!_shareThemeHelper || [_shareThemeHelper isEqual:[NSNull null]]) [self shareThemeHelper];

    CGFloat size = [_shareThemeHelper.themeList[GAThemeHelper_TabBar_Item_TextFontSize_Key] floatValue];
    if (size == CGFLOAT_MIN || size == 0) {
        size = kUITabBarDefaultItemTextFontSize;
    }
    return size;
}
+ (NSArray<UIImage* >* )tabBar_Item_Images{
    if (!_shareThemeHelper || [_shareThemeHelper isEqual:[NSNull null]]) [self shareThemeHelper];

    NSArray<UIImage* >* array = _shareThemeHelper.themeList[GAThemeHelper_TabBar_Item_Images_Key];
    if (!array || [array isEqual:[NSNull null]]) {
        array = kUITabBarDefaultItemImages;
    }
    return array;
}

#pragma mark - msgList & msgChat UI setting ...
/** about msgList theme */
+ (UIColor* )msgList_BgColor{
    if (!_shareThemeHelper || [_shareThemeHelper isEqual:[NSNull null]]) [self shareThemeHelper];

    UIColor* color = _shareThemeHelper.themeList[GAThemeHelper_MsgList_BgColor_Key];
    if (!color || [color isEqual:[NSNull null]]) {
        color = kMsgListDefaultBgColor;
    }
    return color;
}
+ (UIColor* )msgList_TextColor{
    if (!_shareThemeHelper || [_shareThemeHelper isEqual:[NSNull null]]) [self shareThemeHelper];

    UIColor* color = _shareThemeHelper.themeList[GAThemeHelper_MsgList_TextColor_Key];
    if (!color || [color isEqual:[NSNull null]]) {
        color = kMsgListDefaultTextColor;
    }
    return color;
}
+ (NSString*)msgList_TextFontName{
    if (!_shareThemeHelper || [_shareThemeHelper isEqual:[NSNull null]]) [self shareThemeHelper];

    NSString* font = _shareThemeHelper.themeList[GAThemeHelper_MsgList_TextFontName_Key];
    if (!font || [font isEqual:[NSNull null]]) {
        font = kMsgListDefaultTextFontName;
    }
    return font;
}
+ (CGFloat)msgList_TextFontSize{
    if (!_shareThemeHelper || [_shareThemeHelper isEqual:[NSNull null]]) [self shareThemeHelper];

    CGFloat size = [_shareThemeHelper.themeList[GAThemeHelper_MsgList_TextFontSize_Key] floatValue];
    if (size == CGFLOAT_MIN || size == 0) {
        size = kMsgListDefaultTextFontSize;
    }
    return size;
}

/** about msgChat theme */
///< sender theme setting ...
+ (UIColor* )msgChat_SenderBgColor{
    if (!_shareThemeHelper || [_shareThemeHelper isEqual:[NSNull null]]) [self shareThemeHelper];

    UIColor* color = _shareThemeHelper.themeList[GAThemeHelper_MsgChat_SenderBgColor_Key];
    if (!color || [color isEqual:[NSNull null]]) {
        color = kMsgChatSenderDefaultBgColor;
    }
    return color;
}
+ (UIColor* )msgChat_SenderTextColor{
    if (!_shareThemeHelper || [_shareThemeHelper isEqual:[NSNull null]]) [self shareThemeHelper];

    UIColor* color = _shareThemeHelper.themeList[GAThemeHelper_MsgChat_SenderTextColor_Key];
    if (!color || [color isEqual:[NSNull null]]) {
        color = kMsgChatSenderDefaultTextColor;
    }
    return color;
}
+ (NSString*)msgChat_SenderTextFontName{
    if (!_shareThemeHelper || [_shareThemeHelper isEqual:[NSNull null]]) [self shareThemeHelper];

    NSString* font = _shareThemeHelper.themeList[GAThemeHelper_MsgChat_SenderTextFontName_Key];
    if (!font || [font isEqual:[NSNull null]]) {
        font = kMsgChatSenderDefaultTextFontName;
    }
    return font;
}
+ (CGFloat)msgChat_SenderTextFontSize{
    if (!_shareThemeHelper || [_shareThemeHelper isEqual:[NSNull null]]) [self shareThemeHelper];

    CGFloat size = [_shareThemeHelper.themeList[GAThemeHelper_MsgChat_SenderTextFontSize_Key] floatValue];
    if (size == CGFLOAT_MIN || size == 0) {
        size = kMsgChatDefaultFontSize;
    }
    return size;
}

///< self theme setting ...
+ (UIColor* )msgChat_SelfBgColor{
    if (!_shareThemeHelper || [_shareThemeHelper isEqual:[NSNull null]]) [self shareThemeHelper];

    UIColor* color = _shareThemeHelper.themeList[GAThemeHelper_MsgChat_SelfBgColor_Key];
    if (!color || [color isEqual:[NSNull null]]) {
        color = kMsgChatSelfDefaultBgColor;
    }
    return color;
}
+ (UIColor* )msgChat_SelfTextColor{
    if (!_shareThemeHelper || [_shareThemeHelper isEqual:[NSNull null]]) [self shareThemeHelper];

    UIColor* color = _shareThemeHelper.themeList[GAThemeHelper_MsgChat_SelfTextColor_Key];
    if (!color || [color isEqual:[NSNull null]]) {
        color = kMsgChatSelfDefaultTextColor;
    }
    return color;
}
+ (NSString*)msgChat_SelfTextFontName{
    if (!_shareThemeHelper || [_shareThemeHelper isEqual:[NSNull null]]) [self shareThemeHelper];

    NSString* font = _shareThemeHelper.themeList[GAThemeHelper_MsgChat_SelfTextFontName_Key];
    if (!font || [font isEqual:[NSNull null]]) {
        font = kMsgChatSelfDefaultTextFontName;
    }
    return font;
}
+ (CGFloat)msgChat_SelfTextFontSize{
    if (!_shareThemeHelper || [_shareThemeHelper isEqual:[NSNull null]]) [self shareThemeHelper];

    CGFloat size = [_shareThemeHelper.themeList[GAThemeHelper_MsgChat_SelfTextFontSize_Key] floatValue];
    if (size == CGFLOAT_MIN || size == 0) {
        size = kMsgChatDefaultFontSize;
    }
    return size;
}

@end



#pragma mark - Categorys Comment
/** Categorys helper*/
@implementation UIColor (GAThemeHelper)

///< about naviBar ...
+ (instancetype)naviBarBgColor{
    return [GAThemeHelper naviBar_BgColor];
}
+ (instancetype)naviBarTitleTextColor{
    return [GAThemeHelper naviBar_Title_TextColor];
}
+ (instancetype)naviBarItemTextColor{
    return [GAThemeHelper naviBar_Item_TextColor];
}

///< about tabBar ...
+ (instancetype)tabBarBgColor{
    return [GAThemeHelper tabBar_BgColor];
}
+ (instancetype)tabBarItemTextColor{
    return [GAThemeHelper tabBar_Item_TextColor];
}

///< about msgList & msgChat ...
+ (instancetype)msgListBgColor{
    return [GAThemeHelper msgList_BgColor];
}
+ (instancetype)msgListTextColor{
    return [GAThemeHelper msgList_TextColor];
}
+ (instancetype)msgChatSenderBgColor{
    return [GAThemeHelper msgChat_SenderBgColor];
}
+ (instancetype)msgChatSenderTextColor{
    return [GAThemeHelper msgChat_SenderTextColor];
}
+ (instancetype)msgChatSelfBgColor{
    return [GAThemeHelper msgChat_SelfBgColor];
}
+ (instancetype)msgChatSelfTextColor{
    return [GAThemeHelper msgChat_SelfTextColor];
}

@end


@implementation UIImage (GAThemeHelper)


@end


@implementation UIFont (GAThemeHelper)

///< about naviBar ...
+ (instancetype)naviBarTitleTextFont{
    return [UIFont fontWithName:[GAThemeHelper naviBar_Title_TextFontName] size:[GAThemeHelper naviBar_Title_TextFontSize]];
}
+ (instancetype)naviBarItemTextFont{
    return [UIFont fontWithName:[GAThemeHelper naviBar_Item_TextFontName] size:[GAThemeHelper naviBar_Item_TextFontSize]];
}

///< about tabBar ...
+ (instancetype)tabBarItemTextFont{
    return [UIFont fontWithName:[GAThemeHelper tabBar_Item_TextFontName] size:[GAThemeHelper tabBar_Item_TextFontSize]];
}

///< about msgList & msgChat ...
+ (instancetype)msgListTextFont{
    return [UIFont fontWithName:[GAThemeHelper msgList_TextFontName] size:[GAThemeHelper msgList_TextFontSize]];
}
+ (instancetype)msgChatSenderTextFont{
    return [UIFont fontWithName:[GAThemeHelper msgChat_SenderTextFontName] size:[GAThemeHelper msgChat_SenderTextFontSize]];
}
+ (instancetype)msgChatSelfTextFont{
    return [UIFont fontWithName:[GAThemeHelper msgChat_SelfTextFontName] size:[GAThemeHelper msgChat_SelfTextFontSize]];
}

@end



















