//
//  GAPhotoGroup.m
//  Genius_IM
//
//  Created by Graphic-one on 17/3/9.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "GAPhotoGroup.h"

#import <YYImageCache.h>
#import "NSObject+YYKit_GA.h"

static CGSize CalculateLargeSize(CGSize curSize , CGFloat targetW){
    NSUInteger scale = curSize.width / curSize.height;
    CGFloat resultH = targetW / scale;
    return (CGSize){targetW,resultH};
}

@interface GAPhotoGroupItem (){
@public
    NSString* _imageIdentifier;
}
@end

@implementation GAPhotoGroupItem
- (instancetype)initWithThumbView:(UIView* )thumbView
                   largeImageSize:(CGSize)largeImageSize
                       largeImage:(NSData* )largeImage
                      networkPath:(NSString* )networkPath
{
    self = [super init];
    if (self) {
        _thumbView = thumbView;
        _largeImageSize = largeImageSize;
        _largeImage = largeImage;
        _networkPath = networkPath;
        _usingThumbImage = YES;
        _imageIdentifier = @"";
    }
    return self;
}
@end



@interface _GAPhotoGroupCell : UICollectionViewCell
@property (nonatomic,strong) GAPhotoGroupItem* item;

@property (nonatomic,strong) UIScrollView* scrollView;
@property (nonatomic,strong) UIImageView* imageView;
@end

@implementation _GAPhotoGroupCell
- (void)setItem:(GAPhotoGroupItem *)item{
    _item = item;
    
    ///< convert frame of reference
    CGSize resultSize = CalculateLargeSize(item.largeImageSize, self.contentView.bounds.size.width);
    _imageView.frame = (CGRect){{0,0},resultSize};
    _scrollView.contentSize = resultSize;
    if (resultSize.height <= self.contentView.bounds.size.height) {
        _imageView.center = self.contentView.center;
    }
    
    ///< selective assignment
    YYImageCache* cache = [YYImageCache GAShareCache];
    if (item->_imageIdentifier && item->_imageIdentifier != (id)kCFNull) {
        UIImage* image = [cache getImageForKey:item->_imageIdentifier];
        if (image) {
            [_imageView setImage:image];
            return;
        }
    }
    
    if (item.largeImage && item.largeImage != (id)kCFNull) {
        UIImage* image = [UIImage imageWithData:item.largeImage];
        [_imageView setImage:image];
        
        item->_imageIdentifier = [NSString stringWithFormat:@"%lu",(unsigned long)item.largeImage.hash];
        [cache setImage:image imageData:nil forKey:item->_imageIdentifier withType:YYImageCacheTypeAll];
        return ;
    }
    
    if (item.largeImage && item.largeImage != (id)kCFNull) {
        UIImage* image = [UIImage imageWithData:item.largeImage];
        _imageView.image = image;
        [cache setImage:nil imageData:item.largeImage forKey:[NSString stringWithFormat:@"%lu",(unsigned long)item.largeImage.hash] withType:YYImageCacheTypeAll];
        return ;
    }
    
    if (item.thumbView && [item.thumbView isKindOfClass:[UIImageView class]]) {
        UIImageView* thumbImageView = (UIImageView* )item.thumbView;
        if (item.usingThumbImage && thumbImageView.image) _imageView.image = thumbImageView.image;
    }
    
    UIActivityIndicatorView* activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activity.center = _imageView.center;
    [_imageView addSubview:activity];
    [activity startAnimating];
    
    [_imageView setImageWithURL:[NSURL URLWithString:item.networkPath] placeholder:nil options:YYWebImageOptionUseNSURLCache completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (error)  return ;
        
        NSData* data = UIImagePNGRepresentation(image);
        item->_imageIdentifier = [NSString stringWithFormat:@"%lu",data.hash];
        [cache setImage:image imageData:nil forKey:item->_imageIdentifier withType:YYImageCacheTypeAll];
    }];
    
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator   = NO;
        _scrollView.backgroundColor = [UIColor clearColor];
        
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleToFill;
        _imageView.backgroundColor = [UIColor clearColor];
        [_scrollView addSubview:_imageView];
     
        self.contentView.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:_scrollView];
    }
    return self;
}
@end


static NSString* const _GAPhotoGroupCellStr = @"_GAPhotoGroupCellStr";
@interface GAPhotoGroup () <UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic,strong) NSArray<GAPhotoGroupItem* >* dataSource;

@property (nonatomic,strong) UICollectionView* collectionView;
@end

@implementation GAPhotoGroup
{
    NSUInteger _currentIndex;
}

#pragma mrak - public
- (instancetype)initWithItems:(NSArray<GAPhotoGroupItem* >* )items{
    self = [super init];
    if (self) {
        _dataSource = items;
        [self _settingUI];
        [self _settingGesture];
    }
    return self;
}

- (void)presentFromImageView:(UIView *)fromView
                 toContainer:(UIView *)container
                    animated:(BOOL)animated
                  completion:(void (^)(void))completion{
    if (!container || container == (id)kCFNull)  return;
    
    CGSize resultSize = CalculateLargeSize(fromView.size, container.bounds.size.width);
    CGRect targetFrame = (CGRect){{0,container.center.y - resultSize.height * 0.5},resultSize};
    if (resultSize.height >= container.bounds.size.height) {
        targetFrame = (CGRect){{0,0},resultSize};
    }

    NSTimeInterval timeInterval = animated ? 1.25 : 0;
    [UIView animateWithDuration:timeInterval animations:^{
//        fromView.transform = CGAffineTransformMakeScale(container.bounds.size.width / fromView.size.width, container.bounds.size.width / fromView.size.width);
        fromView.frame = targetFrame;
        
    } completion:^(BOOL finished) {
//        fromView.transform = CGAffineTransformIdentity;
        
        self.frame = container.bounds;
        [container addSubview:self];
        if (completion) completion();
    }];
}

- (void)dismissAnimated:(BOOL)animated completion:(void (^)(void))completion{
    NSTimeInterval timeInterval = animated ? 1.25 : 0;
    GAPhotoGroupItem* item = _dataSource[_currentIndex];
    
    if (item.thumbView) {
        CGRect convertRect = [item.thumbView convertRect:item.thumbView.frame toView:self.superview];
        [UIView animateWithDuration:timeInterval animations:^{
            self.frame = convertRect;
        } completion:^(BOOL finished) {
            if (self.superview) {
                [self removeFromSuperview];
            }
            if (completion) completion();
        }];
    }else{
        [UIView animateWithDuration:timeInterval animations:^{
            self.transform = CGAffineTransformMakeScale(1.3, 1.3);
            self.alpha = 0.15;
        } completion:^(BOOL finished) {
            if (self.superview) {
                [self removeFromSuperview];
            }
            if (completion) completion();
        }];
    }
}

#pragma mark - private
- (void)_settingUI{
    [self addSubview:({
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = [UIScreen mainScreen].bounds.size;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
        [_collectionView registerClass:[_GAPhotoGroupCell class] forCellWithReuseIdentifier:_GAPhotoGroupCellStr];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView;
    })];
}

- (void)_settingGesture{
    UILongPressGestureRecognizer* longPress = [[UILongPressGestureRecognizer alloc] initWithActionBlock:^(UILongPressGestureRecognizer*  _Nonnull sender) {
        
    }];
    longPress.delegate = self;
    longPress.minimumPressDuration = 1.2;
    [self addGestureRecognizer:longPress];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(UITapGestureRecognizer*  _Nonnull sender) {
        
    }];
    tap.delegate = self;
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:tap];
    
    UIPinchGestureRecognizer* pinch = [[UIPinchGestureRecognizer alloc] initWithActionBlock:^(UIPinchGestureRecognizer*  _Nonnull sender) {
        
    }];
    [self addGestureRecognizer:pinch];
}

#pragma mark - UIGestureRecognizer delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

#pragma mark - UICollectionView delegate & datasource ... 
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    _GAPhotoGroupCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:_GAPhotoGroupCellStr forIndexPath:indexPath];
    cell.item = _dataSource[indexPath.row];
    return cell;
}

@end



