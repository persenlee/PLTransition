//
//  FirstViewController.m
//  PLTransition
//
//  Created by 一维 on 2018/4/24.
//  Copyright © 2018年 一维. All rights reserved.
//

#import "EXHomeViewController.h"
#import "EXListCell.h"
#import "EXAppStoreFeedViewController.h"
#import <PLTransition.h>
#import "EXHomeTransition.h"

@interface EXHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) PLNavigationTransitionDelegate *navigationDelegate;
@end

@implementation EXHomeViewController

- (void)loadView
{
    self.view = self.collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EXListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([EXListCell class]) forIndexPath:indexPath];
    [cell setupWithTitle:@"App Store"];
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        EXAppStoreFeedViewController *vc = [[EXAppStoreFeedViewController alloc] init];
        self.navigationDelegate.interactiveTransitionViewController = @[vc];
        self.navigationController.delegate = self.navigationDelegate;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark - Accessor
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.itemSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 100);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[EXListCell class] forCellWithReuseIdentifier:NSStringFromClass([EXListCell class])];
    }
    return _collectionView;
}

- (PLNavigationTransitionDelegate *)navigationDelegate
{
    if (!_navigationDelegate) {
        EXHomeTransition *transtion = [[EXHomeTransition alloc] init];
        _navigationDelegate = [[PLNavigationTransitionDelegate alloc] initWithTransition:transtion];
    }
    return _navigationDelegate;
}

@end
