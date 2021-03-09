//
//  HModelPresenter.h
//  RexApp
//
//  Created by chunta on 2021/3/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol HModelPresenterDelegate <NSObject>
- (void)hmodelPresentDidGetData;
@end

@interface HModelPresenter : NSObject
@property (nonatomic, weak)id<HModelPresenterDelegate> delegate;
- (void)requestData;
- (NSInteger)modelCount;
- (NSDictionary *)modelAtCellIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
