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

- (void) showCloseDetailViewButton;
- (void) hideCloseDetailViewButton;

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

- (void) viewDidAppear:(BOOL)animated {
    
    [annotationDetail setFrame: self.view.bounds];
    [annotationDetail layoutIfNeeded];
    
}

- (void) addAnnotation: (int)tagType withImage:(UIImage*)taggedImage {
    
    RatingAnnotation *annotation = [[RatingAnnotation alloc] init];
    [annotation setCoordinate: self.location.coordinate];
    [annotation setTag: tagType];
    [annotation setTaggedImage: taggedImage];

    
    [mapView addAnnotation: annotation];
    
}

- (void) showCloseDetailViewButton {
    UIBarButtonItem *homeMenu = [[UIBarButtonItem alloc] initWithTitle: @"Close"
                                                                 style: UIBarButtonItemStylePlain
                                                                target: self
                                                                action: @selector(hideCloseDetailViewButton) ];
    
    self.navigationItem.rightBarButtonItem = homeMenu;
    
}

- (void) hideCloseDetailViewButton {
    
    // Create zoom-out animation when the user closes the detail view.
    CGRect frame = [self.view bounds];
    
    [[AppDelegate instance] toggleRatingMenu];
    [UIView animateWithDuration:0.25 animations:^{
        
        annotationDetail.transform = CGAffineTransformMakeScale( 1 / frame.size.width,
                                                                 1 / frame.size.height );
        
    } completion:^(BOOL finished) {
        
        self.navigationItem.rightBarButtonItem = nil;
        [annotationDetail removeFromSuperview];
        
    }];
}

#pragma mark -
#pragma mark MKMapViewDelegate functions

- (void) mapView:(MKMapView *)map didAddAnnotationViews:(NSArray *)views {
    
    // Hide the user location annotation.
    MKAnnotationView *ulv = [map viewForAnnotation: mapView.userLocation];
    ulv.enabled = NO;
    
}

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

- (void) mapView:(MKMapView *)map didSelectAnnotationView:(MKAnnotationView *)view {
    
    // Ignore taps on the current location annotation
    if( view.annotation == map.userLocation ) {
        return;
    }
    
    // Create animation!
    // We want the view to look like it's zooming in from the center of the screen.
    [annotationDetail setAnnotation: view.annotation];
    CGRect frame = annotationDetail.bounds;
    
    // Start off completely zoomed out.
    annotationDetail.transform = CGAffineTransformMakeScale( 1 / frame.size.width, 1 / frame.size.height );
    [self.view addSubview: annotationDetail];
    
    [[AppDelegate instance] toggleRatingMenu];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        annotationDetail.transform = CGAffineTransformMakeScale( 1, 1 );
        
    } completion:^(BOOL finished) {
        
        [self showCloseDetailViewButton];
        
    }];
    
}

@end
