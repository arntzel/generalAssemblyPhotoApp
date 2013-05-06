//
//  Photo.h
//  GeneralAssemblyPhotoApp
//
//  Created by Eliot Arntz on 5/5/13.
//  Copyright (c) 2013 EliotArntz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Photo : NSManagedObject

@property (nonatomic, retain) NSString * tag;
@property (nonatomic, retain) id image;
@property (nonatomic, retain) id placemark;

@end
