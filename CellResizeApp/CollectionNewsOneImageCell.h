//
//  CollectionNewsTextAndImageCell.h
//  RexApp
//
//  Created by Rex Chen on 2021/3/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CollectionNewsOneImageCellDelegate <NSObject>
- (void)collectionNewsImageDownloaded:(UICollectionViewCell *)cell;
@end

@interface CollectionNewsOneImageCell : UICollectionViewCell
- (void)setWidth:(NSInteger)width;
- (void)setCellData:(NSDictionary *)dictionary;
+(NSString *)xibName;
@property (nonatomic, weak)id<CollectionNewsOneImageCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
