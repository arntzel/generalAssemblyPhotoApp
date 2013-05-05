//
//  BFLocation.m
//  Koala
//
//  Created by Kevin Joslin on 12/12/12.
//  Copyright (c) 2012 BitFountain. All rights reserved.
//

#import "BFLocation.h"

@implementation BFLocation{
    BOOL updatingLocation;
    NSError *lastLocationError;
    BOOL didFindLocation;
}

+(BFLocation *)sharedInstance{
    
    static dispatch_once_t pred;
    static BFLocation *locationInstance = nil;
    dispatch_once(&pred, ^{
        locationInstance = [[BFLocation alloc]init];
    });
    
    return locationInstance;
}

-(void)startLocationManagerWithCompletion:(void (^)(BOOL foundLocation))completionBlock{
    [self stopLocationManager];
    
    _completionBlock = completionBlock;
    
    if (!_locationManager)
        _locationManager = [[CLLocationManager alloc] init];
    
    // Configure location manager
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // Set a movement threshold for new events.
    _locationManager.distanceFilter = 500;
    [_locationManager startUpdatingLocation];
    
    // Tell ourselves we're updating
    updatingLocation = YES;
}

-(void)stopLocationManager {
    NSLog(@"stopLocationManager called from BFPicker");
    if(updatingLocation){
        [_locationManager stopUpdatingLocation];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(didTimeOut:) object:nil];
        _locationManager.delegate = self;
        updatingLocation = NO;
    }
}

-(void)didTimeOut:(id)obj {
    
    NSLog(@"Location timed out");
    if (!_location) {
        [self stopLocationManager];
        lastLocationError = [NSError errorWithDomain:@"MyLocationsErrorDomain" code:1 userInfo:nil];
    }
}

#pragma mark - TestCoreLocationManager delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    didFindLocation = YES;
    _location = [locations objectAtIndex:0];
    
    NSLog(@"Updated location %@", _location);
    
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc]init];
    }
    
    [_geocoder reverseGeocodeLocation:_location completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Finished reverse geocoding: %@", _placemark);
        _placemark = [placemarks objectAtIndex:0];
        [self.delegate didFindPlaceMark];
        _completionBlock(YES);
        
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError %@", error);
    
    _completionBlock(NO);
    
    if (error.code == kCLErrorLocationUnknown){
        return;
    }
    [self stopLocationManager];
    lastLocationError = error;
    NSLog(@"lastlocerror %@", lastLocationError);
    
}

-(void)resetLocation{
    _location = nil;
}

-(void)searchLocationWithString:(NSString *)string completion:(void (^)(BOOL foundLocation))completionBlock{
    
    _completionBlock = completionBlock;
    
    
    if (nil == _geocoder) {
        _geocoder = [[CLGeocoder alloc]init];
    }
    [_geocoder geocodeAddressString:string
                  completionHandler:^(NSArray* placemarks, NSError* error){
                      //for (CLPlacemark* aPlacemark in placemarks)
                      CLPlacemark *placemark = [placemarks objectAtIndex:0];
                      _placemark = placemark;
                      _location = placemark.location;
                      _completionBlock(YES);
                  }];
    
}

-(NSString *)title{
    if (_placemark.subLocality) {
        _title = _placemark.subLocality;
        return _title;
    }
    else if (_placemark.subAdministrativeArea){
        _title = _placemark.subAdministrativeArea;
        return _title;
    }
    
    _title = _placemark.administrativeArea;
    return _title;
}


@end
