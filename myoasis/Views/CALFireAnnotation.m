//
//  CALFireAnnotation.m
//  FireTracker
//
//  Created by CJ Jacobs on 7/7/14.
//  Copyright (c) 2014 DHLabs. All rights reserved.
//

#import "CALFireAnnotation.h"

@implementation CALFireAnnotation
@synthesize coordinate, title;


-(id)initWithTitle:(NSString *)newTitle Location:(CLLocationCoordinate2D)location
{
    self = [super init];
    
    if (self) {
    title = newTitle;
    coordinate = location;
    }
    
    return self;
}


- (MKAnnotationView *)annotationView
{
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"CALFireAnnotation"];
    
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    annotationView.image = [UIImage imageNamed:@"calfire.png"];
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return annotationView;
}

@end
