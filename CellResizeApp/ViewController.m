//
//  ViewController.m
//  RexApp
//
//  Created by Rex Chen on 2021/3/5.
//

#import "ViewController.h"
#import "CollectionNewsPlainTextList.h"
#import "CollectionNewsOneImageList.h"
#import "CollectionNewsTextImageList.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)onCollectionViewPlainTextList:(id)sender {
    
    [self.navigationController pushViewController:[CollectionNewsPlainTextList new] animated:YES];
}

- (IBAction)onCollectionViewOneImageList:(id)sender {
    
    [self.navigationController pushViewController:[CollectionNewsOneImageList new] animated:YES];
}

- (IBAction)onCollectionViewTextAndImageList:(id)sender {
 
    [self.navigationController pushViewController:[CollectionNewsTextImageList new] animated:YES];
}
@end
