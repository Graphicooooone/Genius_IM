//
//  GAMsgListCell.h
//  Genius_IM
//
//  Created by Graphic-one on 17/2/3.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GAMsgListCell;

@protocol GAMsgListCellDelegate <NSObject>
@optional

- (void)msgListCellClickUserPortrait:(GAMsgListCell* )msgListCell
                        curClickView:(__kindof UIView* )view;

@end

@interface GAMsgListCell : UITableViewCell

+ (__kindof instancetype)MsgListCellWithTableView:(UITableView* )tableView
                                        viewModel:(id)viewModel;

@property (nonatomic,strong) id viewModel;

@property (nonatomic,weak) id<GAMsgListCellDelegate> delegate;

@end
