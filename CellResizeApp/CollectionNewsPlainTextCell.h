//
//  CollectionNewsDetailCell.h
//  RexApp
//
//  Created by Rex Chen on 2021/3/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionNewsPlainTextCell : UICollectionViewCell
- (void)setCellData:(NSDictionary *)dictionary;
- (void)setWidth:(CGFloat)width;
+ (NSString *)xibName;
@end

NS_ASSUME_NONNULL_END
