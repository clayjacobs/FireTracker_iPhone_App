//
//  CALFireAnnotationView.m
//  FireTracker
//
//  Created by CJ Jacobs on 7/7/14.
//  Copyright (c) 2014 DHLabs. All rights reserved.
//
/*
#import "CALFireAnnotationView.h"
#import "CALFireAnnotation.h"

@implementation CALFireAnnotationView

- (id) initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if( self ) {
        
        CALFireAnnotation *pin = (CALFireAnnotation*)annotation;
        
        UIImage *annotationImage = nil;
        annotationImage = [UIImage imageNamed:@"calfire.gif"];
        
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
*/