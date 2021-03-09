//
//  ListViewController.m
//  RexApp
//
//  Created by Rex Chen on 2021/3/5.
//

#import "CollectionNewsPlainTextList.h"
#import "HModelPresenter.h"
#import "CollectionNewsPlainTextCell.h"
#import <SDWebImage/SDWebImage.h>

static NSInteger kDefaultWidth = 100;
static NSInteger kDefaultHeight = 300;
static NSString *kCellIdentifier = @"kCellIdentifier";

@interface CollectionNewsPlainTextList ()<UICollectionViewDelegate,
                                              UICollectionViewDataSource,
                                              UICollectionViewDelegateFlowLayout,
                                              HModelPresenterDelegate>
@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)HModelPresenter *modelPresenter;
@end

@implementation CollectionNewsPlainTextList

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kDefaultWidth, kDefaultHeight)
                                             collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:[CollectionNewsPlainTextCell xibName] bundle:Nil]
          forCellWithReuseIdentifier:kCellIdentifier];
    [self.view addSubview:self.collectionView];
    
    self.modelPresenter = [HModelPresenter new];
    self.modelPresenter.delegate = self;
    
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        
        [self.modelPresenter requestData];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%@", NSStringFromCGRect(self.view.frame));
    NSLog(@"%@", NSStringFromCGRect(self.view.bounds));
    self.collectionView.frame = self.view.frame;
}

#pragma mark - CollectionView
-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section {
    
    return [self.modelPresenter modelCount];
}

- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                  cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    CollectionNewsPlainTextCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    [cell setCellData:[self.modelPresenter modelAtCellIndex:indexPath.row]];
    [cell setWidth:[UIScreen mainScreen].bounds.size.width];
    return cell;
}

#pragma mark - CollectionView Layout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}

#pragma mark - Model Data
- (void)hmodelPresentDidGetData {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}
@end
