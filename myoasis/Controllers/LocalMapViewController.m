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
#import "HeatmapAnnotationView.h"

#import "KeepData.h"

#define MAP_VIEW_PINS       0
#define MAP_VIEW_HEATMAP    1

// The distance a user has to scroll before we update our annotations for the screen.
#define SCROLL_UPDATE_DISTANCE      80.00

#define SYSTEM_VERSION_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface LocalMapViewController () {
    
    NSMutableArray *keepAnnotations;
    CLLocationCoordinate2D lastMapLocation;
    
}

- (void) showCloseDetailViewButton;
- (void) hideCloseDetailViewButton;

- (void) recenterMap;

@end

@implementation LocalMapViewController

@synthesize location;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        // Track the user's location.
        [mapView setUserTrackingMode: MKUserTrackingModeFollow];
        [self setTitle:@"My Oasis"];
        
        keepAnnotations = [[NSMutableArray alloc] init];
        lastMapLocation = mapView.centerCoordinate;
        
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

- (void) viewDidLayoutSubviews {
    
    // For iOS 6, we need to move the segmented bar/button up
    // a bit since the header isn't as big.
    if( SYSTEM_VERSION_LESS_THAN( @"7.0" ) ) {
        
        // Change the font size
        UIFont *font = [UIFont boldSystemFontOfSize:14.0f];
        NSDictionary *attributes = [NSDictionary dictionaryWithObject: font
                                                               forKey: UITextAttributeFont];
        
        [mapViewOptionsControl setTitleTextAttributes: attributes
                                             forState: UIControlStateNormal];
    }
}

- (void) addAnnotation: (int)tagType withImage:(UIImage*)taggedImage {
    
    RatingAnnotation *annotation = [[RatingAnnotation alloc] init];
    [annotation setIsLocal: YES];
    [annotation setCoordinate: self.location.coordinate];
    [annotation setTag: tagType];
    [annotation setTaggedImage: taggedImage];
    
    [mapView addAnnotation: annotation];
    
}

- (NSString*) boundingBox {
    
    // Find the corners of the map
    CGPoint nePoint = CGPointMake( mapView.bounds.origin.x + mapView.bounds.size.width, mapView.bounds.origin.y );
    CGPoint swPoint = CGPointMake( mapView.bounds.origin.x, mapView.bounds.origin.y + mapView.bounds.size.height );
    
    //Then transform those point into lat,lng values
    CLLocationCoordinate2D neCoord;
    neCoord = [mapView convertPoint:nePoint toCoordinateFromView:mapView];
    
    CLLocationCoordinate2D swCoord;
    swCoord = [mapView convertPoint:swPoint toCoordinateFromView:mapView];
    
    NSString *bbox = [NSString stringWithFormat:@"%f,%f,%f,%f",
                                                swCoord.longitude, swCoord.latitude,
                                                neCoord.longitude, neCoord.latitude];
    
    NSLog( @"BBOX: %@", bbox );
    
    return bbox;
    
}

- (IBAction) mapViewOptionSelected:(id)sender {
    
    // TODO: Find a better way of updating annotations
    // At the moment, the way we update the annotation view is to re-add every annotation
    // back into the map.
    for( id<MKAnnotation> annotation in [mapView annotations] ) {
        
        if( annotation == mapView.userLocation ) {
            continue;
        }
        
        [mapView removeAnnotation: annotation];
        [mapView addAnnotation: annotation];
        
    }
    
}

- (IBAction) recenterMap:(id)sender {
    [self recenterMap];
}

#pragma mark -
#pragma mark Private Functions

- (void) showCloseDetailViewButton {
    UIBarButtonItem *homeMenu = [[UIBarButtonItem alloc] initWithTitle: @"Close"
                                                                 style: UIBarButtonItemStylePlain
                                                                target: self
                                                                action: @selector(hideCloseDetailViewButton) ];
    
    self.navigationItem.rightBarButtonItem = homeMenu;
    
}

- (void) hideCloseDetailViewButton {
    
    // Create zoom-out animation when the user closes the detail view.
    [[AppDelegate instance] toggleRatingMenu];
    [UIView animateWithDuration:0.25 animations:^{
        
        annotationDetail.transform = CGAffineTransformMakeScale( 0.1, 0.1 );
        
    } completion:^(BOOL finished) {
        
        self.navigationItem.rightBarButtonItem = nil;
        [annotationDetail removeFromSuperview];
        
    }];
}

- (void) recenterMap {
    
    MKCoordinateRegion region;
    region.center = self.location.coordinate;
    region.span   = MKCoordinateSpanMake( 0.05, 0.05 );
    
    region = [mapView regionThatFits:region];
    [mapView setRegion:region animated:NO];
    
}

#pragma mark -
#pragma mark KeepSDKDelegate functions

- (void) didFetchData: (NSArray*) data {
    
    if( data == (id)[NSNull null] ) {
        return;
    }
    
    // Delete the old annotations
    for( RatingAnnotation *annotation in keepAnnotations ) {
        [mapView removeAnnotation: annotation];
    }
    
    [keepAnnotations removeAllObjects];
    
    for( NSDictionary *datum in data ) {
        
        NSDictionary *dataRow = [datum valueForKey: @"data"];
        
        NSDictionary *geopoint = [dataRow valueForKey: @"location"];
        
        CLLocationDegrees lng = [(NSNumber*)[geopoint valueForKey:@"coordinates"][0] doubleValue];
        CLLocationDegrees lat = [(NSNumber*)[geopoint valueForKey:@"coordinates"][1] doubleValue];
   
        RatingAnnotation *annotation = [[RatingAnnotation alloc] init];
        [annotation setIsLocal: NO];
        [annotation setCoordinate: CLLocationCoordinate2DMake( lat, lng )];
        [annotation setTag: [[dataRow valueForKey: @"rating"] intValue] ];
        NSString * category = [dataRow objectForKey:@"category"];
        if ( category && ![category isEqualToString:@"None"]) {
            annotation.category = category;
        } else {
            category = nil;
        }
        
        NSURL *imageURL = [NSURL URLWithString: [dataRow valueForKey: @"photo"] ];
        [annotation setTaggedImageURL: imageURL];
        
        [keepAnnotations addObject: annotation];
        [mapView addAnnotation: annotation];

    }
}

#pragma mark -
#pragma mark MKMapViewDelegate functions

- (void) mapView:(MKMapView *)map regionDidChangeAnimated:(BOOL)animated {
    
    MKCoordinateRegion mapRegion;
    mapRegion.center = map.centerCoordinate;
    
    double lat = mapRegion.center.latitude;
    double lng = mapRegion.center.longitude;
    
    if( isnan( lat ) || isnan( lng ) ) {
        return;
    }
    
    NSLog( @"%f -> %f", lastMapLocation.latitude, lat );
    
    CLLocation *before = [[CLLocation alloc] initWithLatitude: lastMapLocation.latitude
                                                    longitude: lastMapLocation.longitude];

    CLLocation *after = [[CLLocation alloc] initWithLatitude: lat
                                                   longitude: lng ];
    
    CLLocationDistance distance = [before distanceFromLocation: after];
    
    NSLog( @"Scrolled distance: %@", [NSString stringWithFormat: @"%.02f", distance ] );
    
    if( distance > SCROLL_UPDATE_DISTANCE ) {
        
        NSLog( @"Refreshing annotation bounding box" );
        KeepSDK *keep = [[AppDelegate instance] keep];
        [keep fetchDataWithBBox: [self boundingBox]];
        
    }
    
    lastMapLocation.latitude = lat;
    lastMapLocation.longitude = lng;
    
}

- (void) mapView:(MKMapView *)map didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    // We only want to recenter the map if the location was nil before.
    BOOL recenterMap = self.location == nil;
    
    self.location = userLocation.location;

    if( recenterMap ) {
        [self recenterMap];
    }
    
}

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id<MKAnnotation>)annotation {
    
    // If this is the annotation for the user's location, ignore it.
    if( annotation == map.userLocation ) {
        return nil;
    }
    
    MKAnnotationView *pinView = nil;
    
    if( [mapViewOptionsControl selectedSegmentIndex] == MAP_VIEW_PINS ) {
    
        // All other annotation's on the screen will be <RatingAnnotation>.
        RatingAnnotation *pin = (RatingAnnotation*)annotation;
        pinView = [map dequeueReusableAnnotationViewWithIdentifier: pin.identifier];
        
        // If this pin view doesn't exist already, create it!
        if( !pinView ) {
            pinView = [[RatingAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier: pin.identifier];
        }
    
    } else {
        
        static NSString *const kHeatmapAnnotationId = @"HeatmapAnnotation";
        
        // All other annotation's on the screen will be <RatingAnnotation>.
        pinView = [map dequeueReusableAnnotationViewWithIdentifier: @"HEATMAP"];
        
        // If this pin view doesn't exist already, create it!
        if( !pinView ) {
            pinView = [[HeatmapAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier: kHeatmapAnnotationId ];
        }
        
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
    annotationDetail.bounds = self.view.bounds;
    [annotationDetail setNeedsLayout];
    
    annotationDetail.transform = CGAffineTransformMakeScale( 0.1, 0.1 );
    [self.view addSubview: annotationDetail];
    
    [[AppDelegate instance] toggleRatingMenu];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        annotationDetail.transform = CGAffineTransformMakeScale( 1, 1 );
        
    } completion:^(BOOL finished) {
        
        [self showCloseDetailViewButton];
        
    }];
    
}

@end
