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
#import "CALFireAnnotation.h"
#import "UserDataAnnotation.h"

#import "KeepData.h"
#import "AFNetworking.h"

#define MAP_VIEW_PINS       0
#define MAP_VIEW_HEATMAP    1

// The distance a user has to scroll before we update our annotations for the screen.
#define SCROLL_UPDATE_DISTANCE      80.00

#define SYSTEM_VERSION_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface LocalMapViewController ()<UIActionSheetDelegate> {
    
    NSMutableArray *keepAnnotations;
    NSMutableArray *calfireAnnotations;
    CLLocationCoordinate2D lastMapLocation;
    NSString * filterCategory;
}
- (void) showCloseDetailViewButton;
- (void) hideCloseDetailViewButton;

- (void) recenterMap;
- (void) openInfo;

@end

@implementation LocalMapViewController

@synthesize location;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        // Track the user's location.
        [mapView setUserTrackingMode: MKUserTrackingModeFollow];
        [self setTitle:@"Fire Tracker"];

        filterCategory = nil;
        
        keepAnnotations = [[NSMutableArray alloc] init];
        lastMapLocation = mapView.centerCoordinate;
        calfireAnnotations = [[NSMutableArray alloc] init];
        
//        UIBarButtonItem *homeMenu = [[UIBarButtonItem alloc] initWithTitle: @"Menu"
//                                                                     style: UIBarButtonItemStylePlain
//                                                                    target: [AppDelegate instance]
//                                                                    action: @selector(showHomeMenu:) ];
//        
//        self.navigationItem.leftBarButtonItem = homeMenu;

    }
    return self;
    
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"About to create coord1 on load");
    CLLocationCoordinate2D coord1 = CLLocationCoordinate2DMake(38.517952, -122.097931);
    CALFireAnnotation *annotation1 = [[CALFireAnnotation alloc]initWithTitle:@"CALFire Warning" Location:coord1];
    [calfireAnnotations addObject: annotation1];
    [mapView addAnnotation: annotation1];
    
    CLLocationCoordinate2D coord2 = CLLocationCoordinate2DMake(38.667149, -122.45327);
    CALFireAnnotation *annotation2 = [[CALFireAnnotation alloc]initWithTitle:@"CALFire Warning" Location:coord2];
    [calfireAnnotations addObject: annotation2];
    [mapView addAnnotation: annotation2];
    
    CLLocationCoordinate2D coord3 = CLLocationCoordinate2DMake(38.816006, -121.012428);
    CALFireAnnotation *annotation3 = [[CALFireAnnotation alloc]initWithTitle:@"CALFire Warning" Location:coord3];
    [calfireAnnotations addObject: annotation3];
    [mapView addAnnotation: annotation3];
    
    CLLocationCoordinate2D coord4 = CLLocationCoordinate2DMake(40.571899, -121.341499);
    CALFireAnnotation *annotation4 = [[CALFireAnnotation alloc]initWithTitle:@"CALFire Warning" Location:coord4];
    [calfireAnnotations addObject: annotation4];
    [mapView addAnnotation: annotation4];
    
    CLLocationCoordinate2D coord5 = CLLocationCoordinate2DMake(39.188694, -121.270226);
    CALFireAnnotation *annotation5 = [[CALFireAnnotation alloc]initWithTitle:@"CALFire Warning" Location:coord5];
    [calfireAnnotations addObject: annotation5];
    [mapView addAnnotation: annotation5];
    
    CLLocationCoordinate2D coord6 = CLLocationCoordinate2DMake(41.488998, -120.903999);
    CALFireAnnotation *annotation6 = [[CALFireAnnotation alloc]initWithTitle:@"CALFire Warning" Location:coord6];
    [calfireAnnotations addObject: annotation6];
    [mapView addAnnotation: annotation6];
    
    CLLocationCoordinate2D coord7 = CLLocationCoordinate2DMake(41.889999, -120.790001);
    CALFireAnnotation *annotation7 = [[CALFireAnnotation alloc]initWithTitle:@"CALFire Warning" Location:coord7];
    [calfireAnnotations addObject: annotation7];
    [mapView addAnnotation: annotation7];
    
    CLLocationCoordinate2D coord9 = CLLocationCoordinate2DMake(35.697964, -118.618523);
    CALFireAnnotation *annotation9 = [[CALFireAnnotation alloc]initWithTitle:@"CALFire Warning" Location:coord9];
    [calfireAnnotations addObject: annotation9];
    [mapView addAnnotation: annotation9];
    
    CLLocationCoordinate2D coord10 = CLLocationCoordinate2DMake(40.41, -123.239998);
    CALFireAnnotation *annotation10 = [[CALFireAnnotation alloc]initWithTitle:@"CALFire Warning" Location:coord10];
    [calfireAnnotations addObject: annotation10];
    [mapView addAnnotation: annotation10];
    
    CLLocationCoordinate2D coord11 = CLLocationCoordinate2DMake(37.22575, -121.820526);
    CALFireAnnotation *annotation11 = [[CALFireAnnotation alloc]initWithTitle:@"CALFire Warning" Location:coord11];
    [calfireAnnotations addObject: annotation11];
    [mapView addAnnotation: annotation11];
    
    NSLog(@"Created coord1");
    NSLog(@"coord1Annotation create... attempting to add annotation");
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://warm-ridge-5036.herokuapp.com/submissions.json"
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSMutableArray *jsonArray = [NSMutableArray arrayWithArray:responseObject];
             NSLog(@"Response: %@", jsonArray);
             NSString *category = [[jsonArray objectAtIndex:0]valueForKey:@"category"];
             NSLog(@"Category ?: %@",category);
             [self addIcon:jsonArray];
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
    
    
    NSLog(@"%f",self.location.coordinate.latitude);
}

- (void) viewDidAppear:(BOOL)animated {

    [annotationDetail setFrame: self.view.bounds];
    [annotationDetail layoutIfNeeded];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(filter) ];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:255.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(settings) ];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:255.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
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

- (void) addIcon: (NSMutableArray*)datum {
    
    NSLog(@"Made it to addIcon method");
    
    int limit = 100;
    
    if ([datum count] < 100) {
        limit = [datum count];
    }
    
    //Take up to most recent 100 icons
    for (int i=0; i<limit; i++)
    {
        NSString *category = [[datum objectAtIndex:i]valueForKey:@"category"];
        CLLocationDegrees latitude = [(NSNumber*)[[datum objectAtIndex:i]valueForKey:@"lat"] doubleValue];
        CLLocationDegrees longtitude = [(NSNumber*)[[datum objectAtIndex:i]valueForKey:@"long"] floatValue];
        NSString *size = [[datum objectAtIndex:i]valueForKey:@"severity"];
        
        
        UserDataAnnotation *annotation = [[UserDataAnnotation alloc] initCategory:category Location:CLLocationCoordinate2DMake(latitude, longtitude) Size:size];
        [mapView addAnnotation: annotation];
        
    }
}

- (void) settings {
    UIActionSheet * viewCoordinates = [[UIActionSheet alloc] initWithTitle:@"Add, view, or modify your important coordinates" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Add Current Coordinate", nil];
    
    [viewCoordinates showInView:self.view];
}

//filter annotations based on category
- (void) filter {
    UIActionSheet * filterSelect = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"No Filter", @"Trash Fire", @"Wildfire", @"House Fire",@"Other Uncontrolled Fire", nil];

    [filterSelect showInView:self.view];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            filterCategory = nil;
            break;
        case 1:
            filterCategory = @"Trash Fire";
            break;
        case 2:
            filterCategory = @"Wildfire";
            break;
        case 3:
            filterCategory = @"House Fire";
            break;
        case 4:
            filterCategory = @"Other Uncontrolled Fire";
            break;

        default:
            break;
    }

    [self mapView:mapView regionDidChangeAnimated:YES];
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

- (IBAction) openInfo:(id)sender {
    [self openInfo];
}

/*- (IBAction) takeImage:(id)sender {
    [self takeImage];
}*/

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

/*- (void) takeImage {
    [[AppDelegate instance] takePhoto:self];
}*/

- (void) openInfo {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Information"
                                                      message:@"Alert body"
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
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
    for (id <MKAnnotation> annotation in mapView.annotations) {
        NSLog(@"Removing Annotation");
        [[mapView viewForAnnotation:annotation] removeObserver:self forKeyPath:@"selected"];
    }
    
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
            annotation.category = nil;
        }
        
        NSURL *imageURL = [NSURL URLWithString: [dataRow valueForKey: @"photo"] ];
        [annotation setTaggedImageURL: imageURL];

        if( filterCategory ) {
            if( annotation.category && [annotation.category isEqualToString:filterCategory] ) {
                [keepAnnotations addObject: annotation];
                [mapView addAnnotation: annotation];
            }
        } else {
            [keepAnnotations addObject: annotation];
            [mapView addAnnotation: annotation];
        }
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
    [[AppDelegate instance] setCurrentLat:(self.location.coordinate.latitude)];
    [[AppDelegate instance] setCurrentLong:(self.location.coordinate.longitude)];

    if( recenterMap ) {
        [self recenterMap];
    }
    
}

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id<MKAnnotation>)annotation {
    NSLog(NSStringFromClass([annotation class]));
    if ([annotation isKindOfClass:[CALFireAnnotation class]]) {
        NSLog(@"Not returning nil");
        CALFireAnnotation *myLocation = (CALFireAnnotation *)annotation;
        
        MKAnnotationView *annotationView1 = [mapView dequeueReusableAnnotationViewWithIdentifier:@"CALFireAnnotation"];
        
        if (annotationView1 == nil) {
            annotationView1 = myLocation.annotationView;
        }
        else {
            annotationView1.annotation = annotation;
        }
        
        return annotationView1;
    }
    
    if ([annotation isKindOfClass:[UserDataAnnotation class]]) {
        NSLog(@"Adding UserDataAnnotation");
        UserDataAnnotation *myLocation = (UserDataAnnotation *)annotation;
        
        MKAnnotationView *annotationView1 = [mapView dequeueReusableAnnotationViewWithIdentifier:@"UserDataAnnotation"];
        
        if (annotationView1 == nil) {
            annotationView1 = myLocation.annotationView;
        }
        else {
            annotationView1.annotation = annotation;
        }
        
        return annotationView1;
    }
    
    
    /*else
    {
        NSLog(@"Returning nil");
        return nil;
    }*/
    // If this is the annotation for the user's location, ignore it.
    if( annotation == map.userLocation ) {
        return nil;
    }
    
    MKAnnotationView *pinView = nil;
    
    NSLog(@"Made it to Rating Annotation");
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
    
    NSLog(@"Returning pinView");
    return pinView;
}

/*- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id<MKAnnotation>)annotation {
    
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
    
}*/

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
