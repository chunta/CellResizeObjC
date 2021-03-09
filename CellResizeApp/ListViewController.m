//
//  ListViewController.m
//  HouzzApp
//
//  Created by Rex Chen on 2021/3/5.
//

#import "CollectionViewColumn.h"
#import "HModelPresenter.h"
#import "CollectionViewCell.h"
#import <SDWebImage/SDWebImage.h>

static NSInteger kDefaultWidth = 100;
static NSInteger kDefaultHeight = 300;
static NSString *kCellIdentifier = @"kCellIdentifier";
@interface CollectionViewColumn ()<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
HModelPresenterDelegate>
@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)HModelPresenter *hModelPresenter;
@end

@implementation CollectionViewColumn

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kDefaultWidth, kDefaultHeight)
                                             collectionViewLayout:[UICollectionViewFlowLayout new]];
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:Nil] forCellWithReuseIdentifier:kCellIdentifier];
    
    self.hModelPresenter = [HModelPresenter new];
    self.hModelPresenter.delegate = self;
    
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
    
        [self.hModelPresenter requestData];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.collectionView.frame = self.view.bounds;
}

#pragma mark - CollectionView
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.hModelPresenter modelCount];
}

- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                  cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    [cell setCellData:[self.hModelPresenter modelAtCellIndex:indexPath.row]];
    return cell;
}

#pragma mark - CollectionView Layout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(self.view.bounds.size.width, kDefaultHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {

    return 0;
}


#pragma mark - Model Data
- (void)hmodelPresentDidGetData {

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}
@end
