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
@property (strong, nonatomic) IBOutlet UIView *infoView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *ownerLabel;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation DetailPhotoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.detailImageView.image = self.photoObject.photoImage;
    self.titleLabel.text= self.photoObject.photoTitle;
    self.ownerLabel.text = self.photoObject.photographer;
    self.infoLabel.text = self.photoObject.photoAnimalCategory;
    self.infoView.alpha = 1.0;
}

- (IBAction)imageTapped:(id)sender
{
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        [UIView animateWithDuration:0.7 animations:^{
            self.navigationController.navigationBarHidden = NO;
            self.infoView.alpha = 0.7;
            self.infoView.center = CGPointMake(self.infoView.center.x, 260.0);
        }];
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        self.detailImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.navigationController.navigationBarHidden = YES;
//        if (self.detailImageView.image.size.width>self.detailImageView.image.size.height) {
//            self.detailImageView.frame = CGRectMake(0.0, -20.0, self.view.frame.size.width, self.view.frame.size.height);
//        }
    }
    else
    {
        self.detailImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.navigationController.navigationBarHidden = NO;
    }

}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];

    if (fromInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || fromInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        self.detailImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.navigationController.navigationBarHidden = NO;
    }
    else
    {
        self.detailImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.navigationController.navigationBarHidden = YES;
//        if (self.detailImageView.image.size.width>self.detailImageView.image.size.height) {
//            self.detailImageView.frame = CGRectMake(0.0, -20.0, self.view.frame.size.width, self.view.frame.size.height);
//        }
    }
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
