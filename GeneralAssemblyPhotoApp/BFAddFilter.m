//
//  BFAddFilter.m
//  Demo
//
//  Created by Eliot Arntz on 4/23/13.
//  Copyright (c) 2013 EliotArntz. All rights reserved.
//

#import "BFAddFilter.h"

@implementation BFAddFilter

+(UIImage *)addFilter:(UIImage *)image {
    CIImage *beginImage = [CIImage imageWithData: UIImagePNGRepresentation(image)];
    UIImageOrientation originalOrientation = image.imageOrientation;
    CGFloat originalScale = image.scale;
    CIContext *context = [CIContext contextWithOptions:nil];
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"
                                  keysAndValues: kCIInputImageKey, beginImage,
                        @"inputIntensity", [NSNumber numberWithFloat:0.8], nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newPtImage = [UIImage imageWithCGImage:cgimg scale:originalScale orientation:originalOrientation];

    return newPtImage;
}

@end
