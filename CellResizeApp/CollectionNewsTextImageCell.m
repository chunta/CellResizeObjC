//
//  CollectionNewsTextAndImageCell.m
//  RexApp
//
//  Created by Rex Chen on 2021/3/7.
//

#import "CollectionNewsTextImageCell.h"
#import <SDWebImage/SDWebImage.h>

@interface CollectionNewsTextImageCell() {
    
}
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *maxWidthConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *maxHeightConstraint;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, assign) CGFloat imageRatio; // -> width / height
@end

@implementation CollectionNewsTextImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageRatio = 1.0;
    self.contentView.backgroundColor = UIColor.whiteColor;
    self.descriptionLabel.layer.borderWidth = 1;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    [self.maxWidthConstraint setActive:NO];
    [self.maxHeightConstraint setActive:NO];
}

- (void)setWidth:(NSInteger)width {
    
    self.maxWidthConstraint.constant = width;
    self.maxHeightConstraint.constant = width / self.imageRatio;
    [self.maxWidthConstraint setActive:YES];
    [self.maxHeightConstraint setActive:YES];
}

- (void)setCellData:(NSDictionary *)dictionary {
    
    NSString *descriptionString = dictionary[@"lastName"];
    if (descriptionString && [descriptionString isKindOfClass:[NSString class]]) {
        self.descriptionLabel.text = descriptionString;
    }
    
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
