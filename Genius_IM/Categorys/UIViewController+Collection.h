//
//  UIViewController+Collection.h
//  Genius_IM
//
//  Created by Graphic-one on 17/3/8.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Collection)

+ (UIViewController *)topViewControllerForViewController:(UIViewController *)rootViewController;

+ (UIViewController *)currentViewController;

@end
