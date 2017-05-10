//
//  UIView+Collection.m
//  Genius_IM
//
//  Created by Graphic-one on 17/3/9.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "UIView+Collection.h"

#pragma mark - Display
@implementation UIView (Display)
- (BOOL)isDisplayedInScreen{
    if (!self || self == (id)kCFNull) return NO;
    
    if (self.hidden || self.alpha == 0) return NO;
    
    if (!self.superview) return NO;
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGRect rect = [self convertRect:self.frame fromView:nil];
    
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect)) return NO;
    
    if (CGSizeEqualToSize(rect.size, CGSizeZero)) return NO;
    
    CGRect intersectionRect = CGRectIntersection(rect, screenRect);
    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)) return NO;
    
    return YES;
}
@end
