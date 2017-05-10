//
//  GAChatImageCell.m
//  Genius_IM
//
//  Created by Graphic-one on 17/2/4.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "GAImageCell.h"

NSString* const GAImageCellIdentifier = @"GAImageCellIdentifier";

@interface GAImageCell (){
    __weak UIImageView* _contentImageView;
    __weak YYLabel* _timeLabel;
}
@end

@implementation GAImageCell

+ (instancetype)MsgChatCellWithTableView:(UITableView *)tableView
                               viewModel:(id)viewModel
{
    GAImageCell* cell = [tableView dequeueReusableCellWithIdentifier:GAImageCellIdentifier];
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

- (void)_settingSubViews{

}

- (void)layoutSubviews{

}


@end
