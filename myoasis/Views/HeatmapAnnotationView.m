//
//  HeatmapAnnotationView.m
//  myoasis
//
//  Created by Andrew on 10/7/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import "HeatmapAnnotationView.h"
#import "RatingAnnotation.h"

@implementation HeatmapAnnotationView

- (id) initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if( self ) {
        
        RatingAnnotation *pin = (RatingAnnotation*)annotation;
        
        UIImage *annotationImage;
        if( pin.tag == 0 ) {
            annotationImage = [UIImage imageNamed: @"green"];
        } else if( pin.tag == 1 ) {
            annotationImage = [UIImage imageNamed: @"yellow"];
        } else {
            annotationImage = [UIImage imageNamed: @"red"];
        }
        
        CGRect frame = [self frame];
        frame.size = [annotationImage size];
        
        [self setFrame:frame];
        [self setImage:annotationImage];
        
        [self setEnabled:NO];
        [self setCanShowCallout:NO];
        
        // TODO: Determine alpha based on the annotation/density/time
        self.alpha = 0.25;
        
    }
    
    return self;
}

@end
