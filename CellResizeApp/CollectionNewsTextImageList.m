//
//  CollectionViewNewsTextImageList.m
//  RexApp
//
//  Created by Rex Chen on 2021/3/7.
//

#import "CollectionNewsTextImageList.h"
#import "CollectionNewsTextImageCell.h"
#import "HModelPresenter.h"
#import <SDWebImage/SDWebImage.h>

@interface CollectionNewsTextImageList ()<UICollectionViewDelegate,
                                          UICollectionViewDataSource,
                                          UICollectionViewDelegateFlowLayout,
                                          HModelPresenterDelegate,
                                          CollectionNewsTextImageCellDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) HModelPresenter *hmodelPresenter;
@end

@implementation CollectionNewsTextImageList

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) collectionViewLayout:flowLayout];
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:[CollectionNewsTextImageCell xibName] bundle:nil]
          forCellWithReuseIdentifier:[CollectionNewsTextImageCell xibName]];

    self.hmodelPresenter = [HModelPresenter new];
    self.hmodelPresenter.delegate = self;
    
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        [self.hmodelPresenter requestData];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.collectionView.frame = self.view.bounds;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.hmodelPresenter.modelCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionNewsTextImageCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[CollectionNewsTextImageCell xibName] forIndexPath:indexPath];
    cell.delegate = self;
    [cell setCellData:[self.hmodelPresenter modelAtCellIndex:indexPath.row]];
    [cell setWidth:[UIScreen mainScreen].bounds.size.width];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

#pragma mark - Image Downloaded
- (void)collectionNewsImageDownloaded:(UICollectionViewCell *)cell {
    if (self.collectionView.visibleCells && self.collectionView.visibleCells.count) {
        
        if (NSNotFound != [self.collectionView.visibleCells indexOfObject:cell]) {
            [self.collectionView reloadData];
            [self.collectionView.collectionViewLayout invalidateLayout];
        }
    }
}

#pragma mark - Model Data
- (void)hmodelPresentDidGetData {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}
@end
