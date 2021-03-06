//
//  ViewController.m
//  WildKingdom
//
//  Created by Robert Figueras on 5/30/14.
//
//

#import "ViewController.h"
#import "PhotoDataManager.h"
#import "Photo.h"
#import "PhotoCustomCollectionViewCell.h"
#import "DetailPhotoViewController.h"

@interface ViewController () <PhotoDataManagerDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property NSMutableArray *photoObjectsArray;
@property PhotoDataManager *photoDataManager;
@property UICollectionViewFlowLayout *layout;
//@property Photo *selectedPhotoObject;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.photoObjectsArray = [[NSMutableArray alloc] init];
    self.photoDataManager = [[PhotoDataManager alloc]init];
    self.photoDataManager.delegate = self;
    if ([self.title isEqualToString:@"Lions"])
    {
        [self.photoDataManager getArrayOfPhotoObjectsforTheSearchTerm:@"lion,wild"];
    }
    else if ([self.title isEqualToString:@"Tigers"])
    {
        [self.photoDataManager getArrayOfPhotoObjectsforTheSearchTerm:@"tigers,wild,animals"];
    }
    else if ([self.title isEqualToString:@"Bears"])
    {
        [self.photoDataManager getArrayOfPhotoObjectsforTheSearchTerm:@"bears,wild,animals"];
    }
    self.layout = (UICollectionViewFlowLayout *)[self.collectionView collectionViewLayout];

    [self.activityIndicator startAnimating];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.layout.minimumLineSpacing = 1000.0;
    }
    else
    {
        self.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.layout.minimumLineSpacing = 5.0;
    }

}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];

    if (fromInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || fromInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        self.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.layout.minimumLineSpacing = 5.0;
    }
    else
    {
        self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.layout.minimumLineSpacing = 1000.0;
    }
}

#pragma mark - PhotoDataManagerDelegate

- (void) photoDataManagerDidFinishGettingPhotos: (NSArray *)array
{
    for (Photo *eachPhoto in array)
    {
        [self.photoObjectsArray addObject:eachPhoto];
    }
    [self.collectionView reloadData];
    [self.activityIndicator stopAnimating];
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return self.photoObjectsArray.count;
}


- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCustomCollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    Photo *currentPhotoObject = [self.photoObjectsArray objectAtIndex:indexPath.row];
    cell.photoCellImageView.image = currentPhotoObject.photoThumbnailImage;
    return cell;
}


/*- (UICollectionReusableView *)collectionView:
 (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
 {
 return [[UICollectionReusableView alloc] init];
 }*/

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    self.selectedPhotoObject = [self.photoObjectsArray objectAtIndex:indexPath.row];
//    NSLog(@"didSelectItem");
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Deselect item

}

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    Photo *currentPhotoObject = [self.photoObjectsArray objectAtIndex:indexPath.row];
    CGSize retval = currentPhotoObject.photoThumbnailImage.size.width > 0 ? currentPhotoObject.photoThumbnailImage.size : CGSizeMake(100, 100);
    retval.height += 25; retval.width += 25;

    return retval;
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20,25,20,25);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailPhotoViewController *nextVC = segue.destinationViewController;
    NSIndexPath *indexPathOfSelectedPhoto = [self.collectionView indexPathsForSelectedItems][0];
    nextVC.photoObject = [self.photoObjectsArray objectAtIndex:indexPathOfSelectedPhoto.row];
}

@end
