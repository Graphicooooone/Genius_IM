//
//  UIViewController+Collection.m
//  Genius_IM
//
//  Created by Graphic-one on 17/3/8.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "UIViewController+Collection.h"

@implementation UIViewController (Collection)

+ (UIViewController *)topViewControllerForViewController:(UIViewController *)rootViewController{
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController* )rootViewController;
        return [self topViewControllerForViewController:navigationController.visibleViewController];
    }
    
    if (rootViewController.presentedViewController) {
        return [self topViewControllerForViewController:rootViewController.presentedViewController];
    }
    
    return rootViewController;
}

+ (UIViewController *)currentViewController{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [UIApplication sharedApplication].windows[0];
    }
    return [self topViewControllerForViewController:window.rootViewController];
}

@end
