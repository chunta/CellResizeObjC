//
//  CollectionNewsTextAndImageCell.h
//  RexApp
//
//  Created by Rex Chen on 2021/3/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CollectionNewsTextImageCellDelegate <NSObject>
- (void)collectionNewsImageDownloaded:(UICollectionViewCell *)cell;
@end

@interface CollectionNewsTextImageCell : UICollectionViewCell
- (void)setWidth:(NSInteger)width;
- (void)setCellData:(NSDictionary *)dictionary;
+(NSString *)xibName;
@property (nonatomic, weak)id<CollectionNewsTextImageCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
