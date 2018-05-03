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
#import "EXFlipTransition.h"

#define kListTitlesAndAnimators @{  @"Alpha Push/System Pop with Edge Pan Transition" : @"EXHomeTransition", \
                                    @"Flip Transiton" : @"EXFlipTransition", \
                                    @"FallenMirror Transition" : @"EXFallenMirrorTransition"\
}

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
    return kListTitlesAndAnimators.allKeys.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EXListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([EXListCell class]) forIndexPath:indexPath];
    NSString *title = kListTitlesAndAnimators.allKeys[indexPath.item];
    [cell setupWithTitle:title];
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    EXAppStoreFeedViewController *vc = [[EXAppStoreFeedViewController alloc] init];
    NSString *key = kListTitlesAndAnimators.allKeys[indexPath.item];
    NSString *classNameStr = [kListTitlesAndAnimators objectForKey:key];
    id  transition = [[NSClassFromString(classNameStr) alloc] init];
    [self.navigationDelegate setupWithTransition:transition];
    if (indexPath.row == 0) {
        self.navigationDelegate.interactiveTransitionViewController = @[vc];
    }
    self.navigationController.delegate = self.navigationDelegate;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - Accessor
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.itemSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 50);
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
        _navigationDelegate = [[PLNavigationTransitionDelegate alloc] init];
    }
    return _navigationDelegate;
}

@end
