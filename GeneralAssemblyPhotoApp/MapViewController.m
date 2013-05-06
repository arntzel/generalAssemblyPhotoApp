//
//  MapViewController.m
//  GeneralAssemblyPhotoApp
//
//  Created by Eliot Arntz on 5/4/13.
//  Copyright (c) 2013 EliotArntz. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveButtonPressed:)];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
}

-(void)saveButtonPressed:(id)sender {
    self.photo.placemark = [BFLocation sharedInstance]. placemark;
    [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
    [self.navigationController popToRootViewControllerAnimated:YES];
    NSLog(@"%@", [Photo findAll]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)recenterButtonPressed:(UIButton *)sender {
    
    [[BFLocation sharedInstance] startLocationManagerWithCompletion:^(BOOL foundLocation) {
        [self centerMapWithLocation:[BFLocation sharedInstance].placemark];
        NSLog(@"*** %@", [BFLocation sharedInstance].placemark.country);
    }];
}

#pragma mark - Helper

-(void)centerMapWithLocation:(CLPlacemark *)currentLocation{
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(currentLocation.location.coordinate.latitude, currentLocation.location.coordinate.longitude);
    
    if (currentLocation.region.radius < 100) {
        MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:MKCoordinateRegionMakeWithDistance(center, 400, 370)];
        [self.mapView setRegion:adjustedRegion animated:NO];
    }
    else{
        MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:MKCoordinateRegionMakeWithDistance(center, currentLocation.region.radius, currentLocation.region.radius)];
        [self.mapView setRegion:adjustedRegion animated:NO];
    }
}
@end
