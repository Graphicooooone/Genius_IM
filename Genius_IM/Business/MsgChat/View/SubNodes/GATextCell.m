//
//  GAChatTextCell.m
//  Genius_IM
//
//  Created by Graphic-one on 17/2/4.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "GATextCell.h"

NSString* const GATextCellIdentifier = @"GATextCellIdentifier";

@interface GATextCell ()
{
    CALayer* _bgImageLayer;
    
    __weak YYTextView* _contentTextView;
    __weak YYLabel* _timeLabel;
}
@end

@implementation GATextCell

+ (instancetype)MsgChatCellWithTableView:(UITableView *)tableView
                               viewModel:(id)viewModel
{
    GATextCell* cell = [tableView dequeueReusableCellWithIdentifier:GATextCellIdentifier];
    [cell setValue:viewModel forKey:@"viewModel"];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _settingSubViews];
    }
    return self;
}



#pragma mark - Private 
- (void)_settingSubViews{
    CALayer* bgImageLayer = [CALayer layer];
    _bgImageLayer = bgImageLayer;
    [self.contentView.layer addSublayer:_bgImageLayer];
    
    YYTextView* contentTextView = [[YYTextView alloc] init];
    contentTextView.textVerticalAlignment = YYTextVerticalAlignmentTop;
    contentTextView.textAlignment = NSTextAlignmentLeft;
    contentTextView.linkTextAttributes = [self linkTextAttributes];
    contentTextView.selectable = NO;
    contentTextView.editable = NO;
    _contentTextView = contentTextView;
    [self.contentView addSubview:_contentTextView];
    
    YYLabel* timeLabel = [YYLabel new];
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.textVerticalAlignment = YYTextVerticalAlignmentBottom;
    _timeLabel = timeLabel;
    [self.contentView addSubview:_timeLabel];
}

- (void)layoutSubviews{
    
}

@end












