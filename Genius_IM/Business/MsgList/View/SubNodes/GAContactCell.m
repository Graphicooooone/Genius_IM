//
//  GAContactCell.m
//  Genius_IM
//
//  Created by Graphic-one on 17/2/10.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "GAContactCell.h"
///< models
#import "GARLMSession.h"

NSString* const GAContactCellIdentifier = @"GAContactCellIdentifier";

@interface GAContactCell (){
    __weak UIImageView* _userPortraitImageView;
    __weak YYLabel* _userNameLabel;
    __weak YYTextView* _messageTextView;
    __weak YYLabel* _timeLabel;
    __weak CALayer* _statusIcon;
    
    BOOL _trackingUserPortrait;
}
@end

@implementation GAContactCell

+ (__kindof instancetype)MsgListCellWithTableView:(UITableView *)tableView
                                        viewModel:(id)viewModel
{
    if (![[viewModel class] isSubclassOfClass:[GARLMSession class]]) return nil;
    
    viewModel = (GARLMSession* )viewModel;
    GAContactCell* cell = [tableView dequeueReusableCellWithIdentifier:GAContactCellIdentifier];
    if (!cell) {
        cell = [[GAContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GAContactCellIdentifier];
    }
    cell.viewModel = viewModel;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _settingSubViews];
    }
    return self;
}

- (void)setViewModel:(GARLMSession* )viewModel{
    [_userPortraitImageView sd_setImageWithURL:[NSURL URLWithString:viewModel.picture] placeholderImage:[GAListCell PortraitImage]];
    
    [_userNameLabel setText:viewModel.title];
    [_messageTextView setText:viewModel.content];
    [_timeLabel setText:viewModel.pushlish];
}

#pragma mark - setting subViews & layout
- (void)_settingSubViews{
    UIImageView* userPortraitImageView = [UIImageView new];
    _userPortraitImageView = userPortraitImageView;
    [self.contentView addSubview:_userPortraitImageView];
    
    YYLabel* userNameLabel = [YYLabel new];
    _userNameLabel = userNameLabel;
    [self.contentView addSubview:_userNameLabel];
    
    YYTextView* messageTextView = [YYTextView new];
    _messageTextView = messageTextView;
    [self.contentView addSubview:_messageTextView];
    
    YYLabel* timeLabel = [YYLabel new];
    _timeLabel = timeLabel;
    [self.contentView addSubview:_timeLabel];
    
    CALayer* statusIcon = [CALayer layer];
    _statusIcon = statusIcon;
    [self.contentView.layer addSublayer:_statusIcon];
}
- (void)layoutSubviews{
    [super layoutSubviews];
}

#pragma mark - touch handle
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _trackingUserPortrait = NO;
    UITouch* t = [touches anyObject];
    CGPoint p_1 = [t locationInView:_userPortraitImageView];
    if (CGRectContainsPoint(_userPortraitImageView.bounds, p_1)) {
        _trackingUserPortrait = YES;
    }else{
        [super touchesBegan:touches withEvent:event];
    }
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_trackingUserPortrait && [self.delegate respondsToSelector:@selector(msgListCellClickUserPortrait:curClickView:)]) {
        [self.delegate msgListCellClickUserPortrait:self curClickView:_userPortraitImageView];
    }else{
        [super touchesEnded:touches withEvent:event];
    }
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!_trackingUserPortrait) {
        [super touchesCancelled:touches withEvent:event];
    }
}
@end








