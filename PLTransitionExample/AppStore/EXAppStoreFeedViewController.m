//
//  EXAppStoreFeedViewController.m
//  PLTransitionExample
//
//  Created by 一维 on 2018/4/25.
//  Copyright © 2018年 一维. All rights reserved.
//

#import "EXAppStoreFeedViewController.h"
#import "EXHomeTransition.h"
#import <PLTransition.h>
#import "EXAppStoreFeedCell.h"
#import <Masonry.h>
#import <PLTransition/PLTransitionDefine.h>
#import "EXAppStoreArticleViewController.h"
#import "EXAppStoreTransition.h"

@interface EXAppStoreFeedViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) PLPresentTransitionDelegate *presentTransitionDelegate;
@end

@implementation EXAppStoreFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Today";
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 36;
        layout.itemSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 460);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[EXAppStoreFeedCell class]
            forCellWithReuseIdentifier:NSStringFromClass([EXAppStoreFeedCell class])];
    }
    return _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EXAppStoreFeedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([EXAppStoreFeedCell class]) forIndexPath:indexPath];
    WS(weakSelf)
    cell.didTapAction = ^{
        SS(strongSelf)
        [strongSelf gotoAriticleAtIndexPath:indexPath];
    };
    return cell;
}

- (void)gotoAriticleAtIndexPath:(NSIndexPath *)indexPath
{
    EXAppStoreFeedCell *cell = (EXAppStoreFeedCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    EXAppStoreArticleViewController *vc = [[EXAppStoreArticleViewController alloc] init];
    EXAppStoreTransition *transtion = [[EXAppStoreTransition alloc] init];
//    transtion.cardView = cell.cardView;

    CGRect convertedCardViewFrame = [cell convertRect:cell.cardView.frame toView:self.view];
    transtion.originCardViewFrame = convertedCardViewFrame;
    
    self.presentTransitionDelegate = [[PLPresentTransitionDelegate alloc] initWithTransition:transtion];
    self.presentTransitionDelegate.interactiveTransitionViewController = @[vc];
    vc.transitioningDelegate = self.presentTransitionDelegate;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:vc animated:YES completion:nil];
}
@end
