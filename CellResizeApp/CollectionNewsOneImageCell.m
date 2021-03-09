//
//  CollectionNewsOneImageCell.m
//  RexApp
//
//  Created by Rex Chen on 2021/3/7.
//

#import "CollectionNewsOneImageCell.h"
#import <SDWebImage/SDWebImage.h>

@interface CollectionNewsOneImageCell() {
    
}
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *maxWidthConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *maxHeightConstraint;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, assign) CGFloat imageRatio; // -> width / height
@end

@implementation CollectionNewsOneImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageRatio = 1.0;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    [self.maxWidthConstraint setActive:NO];
    [self.maxHeightConstraint setActive:NO];
}

- (void)setWidth:(NSInteger)width {
    
    self.maxWidthConstraint.constant = width;
    self.maxHeightConstraint.constant = width / self.imageRatio;
    [self.maxHeightConstraint setActive:YES];
    [self.maxWidthConstraint setActive:YES];
}

- (void)setCellData:(NSDictionary *)dictionary {
    
    NSString *urlString = dictionary[@"url"];
    if (urlString && [urlString isKindOfClass:[NSString class]]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:urlString]
                          placeholderImage:nil
                                 completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            self.imageView.contentMode = UIViewContentModeScaleAspectFit;
            if (!error && image) {
                self.imageRatio = image.size.width / image.size.height;
                [self.delegate collectionNewsImageDownloaded:self];
            }
        }];
    }
}

+(NSString *)xibName {
    return NSStringFromClass(self.class);
}
@end
