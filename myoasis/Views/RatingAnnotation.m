//
//  RatingAnnotation.m
//  myoasis
//
//  Created by Andrew on 10/2/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import "RatingAnnotation.h"

@implementation RatingAnnotation

@synthesize coordinate, title, subtitle, category;

@synthesize tag, taggedImageURL, taggedImage, isLocal;

- (NSString*) identifier {
    
    static NSString *const kCitizenAnnotationId         = @"CitizenAnnotation";
    static NSString *const kFirefighterAnnotationId         = @"FirefighterAnnotation";
    
    if( tag == 0 )
        return kCitizenAnnotationId;
    else
        return kFirefighterAnnotationId;
    
}

@end
