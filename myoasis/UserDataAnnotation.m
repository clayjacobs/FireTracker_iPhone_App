//
//  UserDataAnnotation.m
//  FireTracker
//
//  Created by CJ Jacobs on 10/9/14.
//  Copyright (c) 2014 DHLabs. All rights reserved.
//

#import "UserDataAnnotation.h"

@implementation UserDataAnnotation
@synthesize coordinate, category, size;


-(id)initCategory:(NSString *)newCategory Location:(CLLocationCoordinate2D)newLocation Size:(NSString *)newSize
{
    self = [super init];
    
    if (self) {
        category = newCategory;
        coordinate = newLocation;
        size = newSize;
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
