//
//  GAMsgListController.m
//  Genius_IM
//
//  Created by Graphic-one on 17/2/3.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "GAMsgListController.h"

#import "GAMsgListCell.h"

#import "GARLMMessage.h"

@interface GAMsgListController ()
@property (nonatomic,strong) NSArray<GARLMMessage* >* dataSource;
@end

@implementation GAMsgListController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self _settingSometing];
}

- (void)_settingSometing{
    
}


#pragma mark - UITableView delegate & dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GAMsgListCell* cell = [GAMsgListCell MsgListCellWithTableView:tableView viewModel:self.dataSource[indexPath.row]];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
