//
//  GAThemeHelper.h
//  Genius_IM
//
//  Created by Graphic-one on 17/1/23.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <Foundation/Foundation.h>

/** default UI setting */
///< about naviBar ...
FOUNDATION_EXPORT NSString* const GAThemeHelper_NaviBar_BgColor_Key;
FOUNDATION_EXPORT NSString* const GAThemeHelper_NaviBar_Title_TextColor_Key;
FOUNDATION_EXPORT NSString* const GAThemeHelper_NaviBar_Title_TextFontName_Key;
FOUNDATION_EXPORT NSString* const GAThemeHelper_NaviBar_Title_TextFontSize_Key;
FOUNDATION_EXPORT NSString* const GAThemeHelper_NaviBar_Item_TextColor_Key;
FOUNDATION_EXPORT NSString* const GAThemeHelper_NaviBar_Item_TextFontName_Key;
FOUNDATION_EXPORT NSString* const GAThemeHelper_NaviBar_Item_TextFontSize_Key;
///< about tabBar ...
FOUNDATION_EXPORT NSString* const GAThemeHelper_TabBar_BgColor_Key;
FOUNDATION_EXPORT NSString* const GAThemeHelper_TabBar_Item_TextColor_Key;
FOUNDATION_EXPORT NSString* const GAThemeHelper_TabBar_Item_TextFontName_Key;
FOUNDATION_EXPORT NSString* const GAThemeHelper_TabBar_Item_TextFontSize_Key;
FOUNDATION_EXPORT NSString* const GAThemeHelper_TabBar_Item_Images_Key;

/** about msgList theme */
FOUNDATION_EXPORT NSString* const GAThemeHelper_MsgList_BgColor_Key;
FOUNDATION_EXPORT NSString* const GAThemeHelper_MsgList_TextColor_Key;
FOUNDATION_EXPORT NSString* const GAThemeHelper_MsgList_TextFontName_Key;
FOUNDATION_EXPORT NSString* const GAThemeHelper_MsgList_TextFontSize_Key;

/** about msgChat theme */
FOUNDATION_EXPORT NSString* const GAThemeHelper_MsgChat_SenderBgColor_Key;
FOUNDATION_EXPORT NSString* const GAThemeHelper_MsgChat_SenderTextColor_Key;
FOUNDATION_EXPORT NSString* const GAThemeHelper_MsgChat_SenderTextFontName_Key;
FOUNDATION_EXPORT NSString* const GAThemeHelper_MsgChat_SenderTextFontSize_Key;

FOUNDATION_EXPORT NSString* const GAThemeHelper_MsgChat_SelfBgColor_Key;
FOUNDATION_EXPORT NSString* const GAThemeHelper_MsgChat_SelfTextColor_Key;
FOUNDATION_EXPORT NSString* const GAThemeHelper_MsgChat_SelfTextFontName_Key;
FOUNDATION_EXPORT NSString* const GAThemeHelper_MsgChat_SelfTextFontSize_Key;


/** 
 Theme manager, the establishment of the manager's purpose is to convenient to expand the theme of the App . 
 Or all of the UI used to the theme of the related Settings can be distributed by the server ....
 */
@interface GAThemeHelper : NSObject

+ (instancetype)shareThemeHelper;

@property (nonatomic,strong,readonly) NSDictionary* themeList;///< curThemeList

+ (void)updateThemeList:(NSDictionary* )themeList;

+ (void)update2ThemeListWithKey:(NSString* )key value:(id)value;

/** global UI setting */
///< about naviBar ...
+ (UIColor* )naviBar_BgColor;
+ (UIColor* )naviBar_Title_TextColor;
+ (NSString*)naviBar_Title_TextFontName;
+ (CGFloat  )naviBar_Title_TextFontSize;
+ (UIColor* )naviBar_Item_TextColor;
+ (NSString*)naviBar_Item_TextFontName;
+ (CGFloat  )naviBar_Item_TextFontSize;
///< about tabBar ...
+ (UIColor* )tabBar_BgColor;
+ (UIColor* )tabBar_Item_TextColor;
+ (NSString*)tabBar_Item_TextFontName;
+ (CGFloat  )tabBar_Item_TextFontSize;
+ (NSArray<UIImage* >* )tabBar_Item_Images;


/** about msgList theme */
+ (UIColor* )msgList_BgColor;
+ (UIColor* )msgList_TextColor;
+ (NSString*)msgList_TextFontName;
+ (CGFloat  )msgList_TextFontSize;


/** about msgChat theme */
///< sender theme setting ...
+ (UIColor* )msgChat_SenderBgColor;
+ (UIColor* )msgChat_SenderTextColor;
+ (NSString*)msgChat_SenderTextFontName;
+ (CGFloat  )msgChat_SenderTextFontSize;
///< self theme setting ...
+ (UIColor* )msgChat_SelfBgColor;
+ (UIColor* )msgChat_SelfTextColor;
+ (NSString*)msgChat_SelfTextFontName;
+ (CGFloat  )msgChat_SelfTextFontSize;

@end


/** Categorys helper*/
@interface UIColor (GAThemeHelper)

///< about naviBar ...
+ (instancetype)naviBarBgColor;
+ (instancetype)naviBarTitleTextColor;
+ (instancetype)naviBarItemTextColor;

///< about tabBar ...
+ (instancetype)tabBarBgColor;
+ (instancetype)tabBarItemTextColor;

///< about msgList & msgChat ...
+ (instancetype)msgListBgColor;
+ (instancetype)msgListTextColor;
+ (instancetype)msgChatSenderBgColor;
+ (instancetype)msgChatSenderTextColor;
+ (instancetype)msgChatSelfBgColor;
+ (instancetype)msgChatSelfTextColor;

@end


@interface UIImage (GAThemeHelper)

@end


@interface UIFont (GAThemeHelper)

///< about naviBar ...
+ (instancetype)naviBarTitleTextFont;
+ (instancetype)naviBarItemTextFont;

///< about tabBar ...
+ (instancetype)tabBarItemTextFont;

///< about msgList & msgChat ...
+ (instancetype)msgListTextFont;
+ (instancetype)msgChatSenderTextFont;
+ (instancetype)msgChatSelfTextFont;

@end












