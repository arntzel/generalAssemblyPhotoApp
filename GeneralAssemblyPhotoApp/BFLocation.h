//
//  BFLocation.h
//  Koala
//
//  Created by Kevin Joslin on 12/12/12.
//  Copyright (c) 2012 BitFountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BFLocationDelegate

-(void)didFindPlaceMark;

@end

typedef void (^MyCompletionBlock)(BOOL);

@interface BFLocation : NSObject <CLLocationManagerDelegate, MKAnnotation>{
}

@property (nonatomic, retain) id <BFLocationDelegate> delegate;


@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLPlacemark *placemark;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong) UIImage *coreDataImage;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, copy) __block MyCompletionBlock completionBlock;

+(BFLocation *)sharedInstance;

-(void)startLocationManagerWithCompletion:(void (^)(BOOL foundLocation))completionBlock;
-(void)searchLocationWithString:(NSString *)string completion:(void (^)(BOOL foundLocation))completionBlock;
@end

