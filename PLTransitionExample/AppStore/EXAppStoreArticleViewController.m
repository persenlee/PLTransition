//
//  EXAppStoreArticleViewController.m
//  PLTransitionExample
//
//  Created by 一维 on 2018/4/25.
//  Copyright © 2018年 一维. All rights reserved.
//

#import "EXAppStoreArticleViewController.h"
#import <Masonry.h>
#import "EXAppStoreCardView.h"

@interface EXAppStoreArticleViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *closeButton;
@end

@implementation EXAppStoreArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupSubviews
{
    self.scrollView.frame = self.view.bounds;
    
    [self.view addSubview:self.scrollView];

    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 520)];
    EXAppStoreCardView *cardView = [[EXAppStoreCardView alloc] init];
    [_headerView addSubview:cardView];
    
    cardView.frame = _headerView.bounds;
    
    [self.scrollView addSubview:self.headerView];
    
    [self.scrollView addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), CGRectGetWidth(self.view.bounds), 5 * 100/*CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(self.headerView.frame)*/);

    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 1020);
    self.closeButton = [[UIButton alloc] init];
    [self.closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [self.view addSubview:self.closeButton];
    [self.closeButton sizeToFit];
    CGRect frame = self.closeButton.frame;
    frame.origin.x = CGRectGetWidth(self.view.bounds) - CGRectGetWidth(frame) - 24;
    frame.origin.y = CGRectGetHeight(frame) + 24;
    self.closeButton.frame = frame;
    [self.closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
}


- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        _scrollView.bounces = NO;
//        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.rowHeight = 100;
        _tableView.sectionHeaderHeight = 0;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.allowsSelection = NO;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    int R = (arc4random() % 256) ;
    int G = (arc4random() % 256) ;
    int B = (arc4random() % 256) ;
   
    UIColor *color = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
    cell.backgroundColor = color;
    return cell;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//
//}


- (void)closeAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)animateForTransition:(BOOL)presenting
{
    self.closeButton.alpha = presenting;
    self.tableView.alpha = presenting;
}
@end
