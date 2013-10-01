//
//  LocalMapViewController.m
//  myoasis
//
//  Created by Andrew on 10/1/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import "LocalMapViewController.h"

@interface LocalMapViewController ()

@end

@implementation LocalMapViewController

@synthesize location;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Zoom the map in on the current user's location.
    [mapView setUserTrackingMode: MKUserTrackingModeFollow];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void) mapView:(MKMapView *)map didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    self.location = userLocation.location;
    
    MKCoordinateRegion region;
    region.center = map.userLocation.coordinate;
    region.span   = MKCoordinateSpanMake( 0.2, 0.2 );
    
    region = [map regionThatFits:region];
    [map setRegion:region animated:YES];

    
}

@end
