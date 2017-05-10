//
//  GAPhotoGroup.h
//  Genius_IM
//
//  Created by Graphic-one on 17/3/9.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GAPhotoGroupItem : NSObject
@property (nonatomic,strong) UIView* thumbView;
@property (nonatomic,assign) CGSize largeImageSize;
@property (nonatomic,strong) NSData* largeImage;
@property (nonatomic,strong) NSString* networkPath;
- (instancetype)initWithThumbView:(UIView* )thumbView
                   largeImageSize:(CGSize)largeImageSize
                       largeImage:(NSData* )largeImage
                      networkPath:(NSString* )networkPath;

@property (nonatomic,assign) BOOL usingThumbImage;///< Whether to use thumbImage as a placeholder , default is YES
@end


@interface GAPhotoGroup : UIView

- (instancetype)initWithItems:(NSArray<GAPhotoGroupItem* >* )items;

- (void)presentFromImageView:(UIView* )fromView
                 toContainer:(UIView *)container
                    animated:(BOOL)animated
                  completion:(void (^)(void))completion;

- (void)dismissAnimated:(BOOL)animated completion:(void (^)(void))completion;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithFrame:(CGRect)frame UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

@end


