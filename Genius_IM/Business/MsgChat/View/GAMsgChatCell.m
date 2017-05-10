//
//  GAMsgChatCell.m
//  Genius_IM
//
//  Created by Graphic-one on 17/2/4.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "GAMsgChatCell.h"

#import "GATextCell.h"
#import "GAImageCell.h"
#import "GAVoiceCell.h"
#import "GAVideoCell.h"
#import "GALocationCell.h"
#import "GAFileCell.h"

@implementation GAMsgChatCell

#pragma mark - Private
+ (__kindof GAMsgChatCell* )_curUsingCellWithViewModel:(id)viewModel
                                           inTableView:(UITableView* )tableView
{
    return nil;
}

#pragma mark - Public
+ (__kindof instancetype)MsgChatCellWithTableView:(UITableView *)tableView
                               viewModel:(id)viewModel
{
    GAMsgChatCell* cell = [self _curUsingCellWithViewModel:viewModel inTableView:tableView];
    
    return cell;
}







@end
