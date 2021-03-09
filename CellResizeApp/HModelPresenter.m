//
//  HModelPresenter.m
//  RexApp
//
//  Created by chunta on 2021/3/5.
//

#import "HModelPresenter.h"
//static NSString *url = @"https://dl.dropboxusercontent.com/s/mvntajts2o3qqr0/pageRex.json";
static NSString *url = @"https://dl.dropboxusercontent.com/s/uq2wxwn9intgzj5/pageRex.json";

//@"https://5fbe26735923c90016e6a962.mockapi.io/users?page=1&limit=10";
@interface HModelPresenter()
@property (nonatomic, strong) NSArray *dataModel;
@end

@implementation HModelPresenter
- (void)requestData {
    
    NSString *urlString = url;
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:urlString]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
        // handle response
        if (error) {
            NSLog(@"%@", error.debugDescription);
            return;
        }
        
        @try {
            self.dataModel = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        }
        @catch (NSException *exception) {
            NSLog(@"%@ exception encoding recommandation data: %@", self, exception);
        }
        
        [self.delegate hmodelPresentDidGetData];
        
    }] resume];
}

- (NSInteger)modelCount {
    
    return self.dataModel.count;
}

- (NSDictionary *)modelAtCellIndex:(NSInteger)index {
    
    assert(index < self.dataModel.count);
    return [self.dataModel objectAtIndex:index];
}
@end
