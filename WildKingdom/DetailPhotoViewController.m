//
//  DetailPhotoViewController.m
//  WildKingdom
//
//  Created by Robert Figueras on 6/1/14.
//
//

#import "DetailPhotoViewController.h"

@interface DetailPhotoViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *detailImageView;
@property (strong, nonatomic) IBOutlet UILabel *photoTitleLabel;

@end

@implementation DetailPhotoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.detailImageView.image = self.photoObject.photoImage;
    self.photoTitleLabel.text = self.photoObject.photoTitle;

    self.tabBarController.tabBar.hidden = YES;
}




@end
