//
//  ViewController.m
//  ExpandCell
//
//  Created by peidong on 16/8/31.
//  Copyright © 2016年 wolf. All rights reserved.
//

#define kCellIdentfier @"CellIdentfier"
#define kHeaderIdentifier @"kHeaderIdentifier"

#import "ViewController.h"
#import "HeaderView.h"
#import "SectionModel.h"
#import "CellModel.h"


@interface ViewController ()

@end

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *sectionDataSources;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:kCellIdentfier];
    [self.tableView registerClass:[HeaderView class] forHeaderFooterViewReuseIdentifier:kHeaderIdentifier];
}

- (NSMutableArray *)sectionDataSources {
    if (_sectionDataSources == nil) {
        _sectionDataSources = [[NSMutableArray alloc] init];
        
        for (NSUInteger i = 0; i < 20; ++i) {
            SectionModel *sectionModel = [[SectionModel alloc] init];
            sectionModel.isExpanded = NO;
            sectionModel.sectionTitle = [NSString stringWithFormat:@"section: %ld", i];
            NSMutableArray *itemArray = [[NSMutableArray alloc] init];
            for (NSUInteger j = 0; j < 10; ++j) {
                CellModel *cellModel = [[CellModel alloc] init];
                cellModel.cellTitle = [NSString stringWithFormat:@"section=%ld, row=%ld", i, j];
                [itemArray addObject:cellModel];
            }
            sectionModel.cellModels = itemArray;
            
            [_sectionDataSources addObject:sectionModel];
        }
    }
    
    return _sectionDataSources;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionDataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SectionModel *sectionModel = self.sectionDataSources[section];
    
    return sectionModel.isExpanded ? sectionModel.cellModels.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentfier
                                                            forIndexPath:indexPath];
    SectionModel *sectionModel = self.sectionDataSources[indexPath.section];
    CellModel *cellModel = sectionModel.cellModels[indexPath.row];
    cell.textLabel.text = cellModel.cellTitle;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kHeaderIdentifier];
    
    SectionModel *sectionModel = self.sectionDataSources[section];
    view.model = sectionModel;
    view.expandCallback = ^(BOOL isExpanded) {
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section]
                 withRowAnimation:UITableViewRowAnimationFade];
    };
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
