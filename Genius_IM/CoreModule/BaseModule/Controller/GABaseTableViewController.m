//
//  GABaseTableViewController.m
//  Genius_IM
//
//  Created by Graphic-one on 17/2/3.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "GABaseTableViewController.h"
#import "MsgListInfo.h"

@interface GABaseTableViewController ()
@property (nonatomic,strong,readwrite) UITableView* tableView;
@end

@implementation GABaseTableViewController
{
    __kindof UIView* _Nullable _headerView;
    __kindof UIView* _Nullable _footerView;
}

- (instancetype)initWithHeaderView:(__kindof UIView *)headerView footerView:(__kindof UIView *)footerView
{
    self = [super init];
    if (self) {
        if (headerView && ![headerView isEqual:[NSNull null]]) _headerView = headerView;
        
        if (footerView && ![footerView isEqual:[NSNull null]]) _footerView = footerView;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor msgListBgColor];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 30, 0, 0);
    if (_headerView) _tableView.tableHeaderView = _headerView;
    if (_footerView) _tableView.tableFooterView = _footerView;
    [self.view addSubview:_tableView];
    [self.view insertSubview:_tableView atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView delegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSAssert(NO, @"subClass must overridden...");
    return 0;
}

- (UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSAssert(NO, @"subClass must overridden...");
    return nil;
}

@end
