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

- (void)viewDidLoad {
    
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void) addAnnotation: (int)tagType {
    
    RatingAnnotation *annotation = [[RatingAnnotation alloc] init];
    [annotation setCoordinate: self.location.coordinate];
    [annotation setTitle: @"TESTING"];
    [annotation setTag:tagType];
    
    [mapView addAnnotation: annotation];
    
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
    
    static NSString *const kMehAnnotationId         = @"MehAnnotation";
    static NSString *const kSadAnnotationId         = @"SadAnnotation";
    static NSString *const kBiohazardAnnotationId   = @"BiohazardAnnotation";

    if( annotation == map.userLocation ) {
        return nil;
    }
    
    RatingAnnotation *pin = (RatingAnnotation*)annotation;
    
    NSString *kAnnotationIdentifier = nil;
    if( pin.tag == 0 ) {
        kAnnotationIdentifier = kMehAnnotationId;
    } else if( pin.tag == 1 ) {
        kAnnotationIdentifier = kSadAnnotationId;
    } else {
        kAnnotationIdentifier = kBiohazardAnnotationId;
    }
    
    RatingAnnotationView *pinView = (RatingAnnotationView*)[map dequeueReusableAnnotationViewWithIdentifier:kAnnotationIdentifier];
    
    if( !pinView ) {
        pinView = [[RatingAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:kAnnotationIdentifier];
    }
    
    [pinView setAnnotation:annotation];
    return pinView;
    
}

@end
