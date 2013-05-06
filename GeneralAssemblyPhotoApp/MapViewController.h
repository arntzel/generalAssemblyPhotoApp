//
//  MapViewController.h
//  GeneralAssemblyPhotoApp
//
//  Created by Eliot Arntz on 5/4/13.
//  Copyright (c) 2013 EliotArntz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFLocation.h"
#import <MapKit/MapKit.h>
#import "Photo.h"

@interface MapViewController : UIViewController

- (IBAction)recenterButtonPressed:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) Photo *photo;



@end
