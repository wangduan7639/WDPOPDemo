//
//  ViewController.m
//  WDPOPDemo
//
//  Created by wd on 15/12/24.
//  Copyright © 2015年 wd. All rights reserved.
//
//*http://cubic-bezier.com/获取贝塞尔曲线坐标的网站 *//

#import "ViewController.h"
#import "WDBasicAnimationViewController.h"
#import "WDDecayAnimationViewController.h"

@interface ViewController ()<RETableViewManagerDelegate>

@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) RETableViewManager    *tableViewManager;
@property (nonatomic, strong) RETableViewSection    *tableViewSection;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"POPAnimation";
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViews
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.tableViewManager = [[RETableViewManager alloc] initWithTableView:self.tableView delegate:self];
    self.tableViewSection = [RETableViewSection section];
    [self.tableViewManager addSection:self.tableViewSection];
    
    @weakify(self);
    RETableViewItem * item = [RETableViewItem itemWithTitle:@"BasicAnimation"
                                              accessoryType:UITableViewCellAccessoryDisclosureIndicator
                                           selectionHandler:^(RETableViewItem *item) {
                                               @strongify(self);
                                               UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:item.indexPath];
                                               cell.selected = NO;
                                               
                                               WDBasicAnimationViewController *vc = [[WDBasicAnimationViewController alloc] init];
                                               [self.navigationController pushViewController:vc animated:YES];
                                           }];
    [self.tableViewSection addItem:item];
    
    item = [RETableViewItem itemWithTitle:@"DecayAnimation"
                              accessoryType:UITableViewCellAccessoryDisclosureIndicator
                           selectionHandler:^(RETableViewItem *item) {
                               @strongify(self);
                               UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:item.indexPath];
                               cell.selected = NO;
                               
                               WDDecayAnimationViewController *vc = [[WDDecayAnimationViewController alloc] init];
                               [self.navigationController pushViewController:vc animated:YES];
                           }];
    [self.tableViewSection addItem:item];

    
}


@end
