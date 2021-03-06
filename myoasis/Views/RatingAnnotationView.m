//
//  RatingAnnotation.m
//  myoasis
//
//  Created by Andrew on 10/2/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import "RatingAnnotationView.h"
#import "RatingAnnotation.h"

@implementation RatingAnnotationView

- (id) initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if( self ) {
        
        RatingAnnotation *pin = (RatingAnnotation*)annotation;
        
        UIImage *annotationImage = nil;
        if( pin.tag == 0 ) {
            annotationImage = [UIImage imageNamed:@"trash-annotation.png"];
        } else if( pin.tag == 1 ) {
            annotationImage = [UIImage imageNamed:@"wildfire-annotation.png"];
        } else if( pin.tag == 2) {
            annotationImage = [UIImage imageNamed:@"brush.png"];
        }
        else {
            annotationImage = [UIImage imageNamed:@"misc-annotation.png"];
        }
        
        CGRect frame = [self frame];
        frame.size = [annotationImage size];
        
        [self setFrame:frame];
        [self setImage:annotationImage];
        
        [self setEnabled:YES];
        [self setCanShowCallout:NO];
        
    }

    return self;
}

@end
