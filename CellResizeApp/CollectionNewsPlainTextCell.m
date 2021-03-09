//
//  CollectionNewsDetailCell.m
//  RexApp
//
//  Created by Rex Chen on 2021/3/5.
//

#import "CollectionNewsPlainTextCell.h"

@interface CollectionNewsPlainTextCell() {
        
}
@property (nonatomic, strong) IBOutlet UILabel *headerLabel;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *maxWidthConstraint;
@end

@implementation CollectionNewsPlainTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.layer.borderWidth = 1;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    [self.maxWidthConstraint setActive:NO];
}

- (void)setCellData:(NSDictionary *)dictionary {
    
    NSString *headerString = dictionary[@"firstName"];
    if (headerString && [headerString isKindOfClass:[NSString class]]) {
        
        self.headerLabel.text = headerString;
        self.headerLabel.backgroundColor = UIColor.clearColor;
    }
    
    NSString *descriptionString = dictionary[@"lastName"];
    if (descriptionString && [descriptionString isKindOfClass:[NSString class]]) {
        
        self.descriptionLabel.text = descriptionString;
        self.descriptionLabel.backgroundColor = UIColor.clearColor;
    }
}

- (void)setWidth:(CGFloat)width {
    
    self.maxWidthConstraint.constant = width;
    [self.maxWidthConstraint setActive:YES];
}

+(NSString *)xibName {
    return NSStringFromClass(self.class);
}
@end
