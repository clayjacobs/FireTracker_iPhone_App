//
//  LocalMapViewController.m
//  myoasis
//
//  Created by Andrew on 10/1/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import "LocalMapViewController.h"

#import "AppDelegate.h"

#import "RatingAnnotation.h"
#import "RatingAnnotationView.h"


@interface LocalMapViewController ()

@end

@implementation LocalMapViewController

@synthesize location;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Track the user's location.
        [mapView setUserTrackingMode: MKUserTrackingModeFollow];
        
        [self setTitle:@"My Oasis"];
        
//        UIBarButtonItem *homeMenu = [[UIBarButtonItem alloc] initWithTitle: @"Menu"
//                                                                     style: UIBarButtonItemStylePlain
//                                                                    target: [AppDelegate instance]
//                                                                    action: @selector(showHomeMenu:) ];
//        
//        self.navigationItem.leftBarButtonItem = homeMenu;

    }
    return self;
    
}

- (void) addAnnotation: (int)tagType {
    
    RatingAnnotation *annotation = [[RatingAnnotation alloc] init];
    [annotation setCoordinate: self.location.coordinate];
    [annotation setTitle: @"TESTING"];
    [annotation setTag:tagType];
    
    [mapView addAnnotation: annotation];
    
}

#pragma mark -
#pragma mark MKMapViewDelegate functions

- (void) mapView:(MKMapView *)map didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    self.location = userLocation.location;
    
    MKCoordinateRegion region;
    region.center = map.userLocation.coordinate;
    region.span   = MKCoordinateSpanMake( 0.05, 0.05 );
    
    region = [map regionThatFits:region];
    [map setRegion:region animated:YES];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id<MKAnnotation>)annotation {
    
    // If this is the annotation for the user's location, ignore it.
    if( annotation == map.userLocation ) {
        return nil;
    }
    
    // All other annotation's on the screen will be <RatingAnnotation>.
    RatingAnnotation *pin = (RatingAnnotation*)annotation;
    RatingAnnotationView *pinView = (RatingAnnotationView*)[map dequeueReusableAnnotationViewWithIdentifier: pin.identifier];
    
    // If this pin view doesn't exist already, create it!
    if( !pinView ) {
        pinView = [[RatingAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier: pin.identifier];
    }
    
    // Setup the views/etc. for this annotation
    [pinView setAnnotation:annotation];
    
    
    return pinView;
    
}

@end
