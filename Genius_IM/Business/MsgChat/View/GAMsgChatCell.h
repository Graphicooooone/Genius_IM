//
//  GAMsgChatCell.h
//  Genius_IM
//
//  Created by Graphic-one on 17/2/4.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgChatInfo.h"

@class GAMsgChatCell;
@protocol GAMsgChatCellDelegate <NSObject>

@optional

@end

@interface GAMsgChatCell : UITableViewCell

+ (__kindof instancetype)MsgChatCellWithTableView:(UITableView* )tableView
                                        viewModel:(id)viewModel;

@property (nonatomic,strong,readonly) id viewModel;

@property (nonatomic,assign) id<GAMsgChatCellDelegate> delegate;

@end
