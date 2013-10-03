//
//  RatingAnnotation.m
//  myoasis
//
//  Created by Andrew on 10/2/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import "RatingAnnotation.h"

@implementation RatingAnnotation

@synthesize coordinate, title, subtitle;

@synthesize tag;

- (NSString*) identifier {
    
    static NSString *const kMehAnnotationId         = @"MehAnnotation";
    static NSString *const kSadAnnotationId         = @"SadAnnotation";
    static NSString *const kBiohazardAnnotationId   = @"BiohazardAnnotation";
    
    if( tag == 0 ) {
        return kMehAnnotationId;
    } else if( tag == 1 ) {
        return kSadAnnotationId;
    }
    
    return kBiohazardAnnotationId;
    
}

@end
