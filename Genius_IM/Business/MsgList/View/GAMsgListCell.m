//
//  GAMsgListCell.m
//  Genius_IM
//
//  Created by Graphic-one on 17/2/3.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "GAMsgListCell.h"

///< models
#import "GARLMMessage.h"
#import "GARLMSession.h"

///< subNodes
#import "GAContactCell.h"

@interface GAMsgListCell (){

}
@end

@implementation GAMsgListCell

#pragma mark - Private
+ (__kindof GAMsgListCell* )_curUsingCellWithViewModel:(id)viewModel
                                           inTableView:(UITableView* )tableView
{
    GAMsgListCell* cell ;
    
    if ([[viewModel class] isSubclassOfClass:[GARLMSession class]]) {
        cell = [GAContactCell MsgListCellWithTableView:tableView viewModel:viewModel];
    }
    
    return cell;
}

#pragma mark - Public
+ (__kindof instancetype)MsgListCellWithTableView:(UITableView *)tableView
                                        viewModel:(id)viewModel
{
    return [self _curUsingCellWithViewModel:tableView inTableView:viewModel];
}

@end
