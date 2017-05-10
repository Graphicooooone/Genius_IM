//
//  GABaseTableViewController.h
//  Genius_IM
//
//  Created by Graphic-one on 17/2/3.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//
#import "GABaseController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GABaseTableViewController : GABaseController <UITableViewDelegate,UITableViewDataSource>

///< The only way to create the controller ...
- (instancetype)initWithHeaderView:(__kindof UIView* )headerView
                        footerView:(__kindof UIView* )footerView;

/**
 curController.tableView.tableHeaderView = tableViewHeaderView;
 */
@property (nonatomic,strong,readonly,nullable) __kindof UIView* tableViewHeaderView;

/**
 default setting :: 
 
 tableView.backgroundColor = [UIColor msgListBgColor];
 */
@property (nonatomic,strong,readonly) UITableView* tableView;

/**
 curController.tableView.tableFooterView = tableViewFooterView;
 */
@property (nonatomic,strong,readonly,nullable) __kindof UIView* tableViewFooterView;


- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

@end

NS_ASSUME_NONNULL_END
