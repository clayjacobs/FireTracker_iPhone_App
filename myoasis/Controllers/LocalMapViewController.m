//
//  LocalMapViewController.m
//  myoasis
//
//  Created by Andrew on 10/1/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import "AppDelegate.h"
#import "LocalMapViewController.h"


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
        
        UIBarButtonItem *homeMenu = [[UIBarButtonItem alloc] initWithTitle: @"Menu"
                                                                     style: UIBarButtonItemStylePlain
                                                                    target: [AppDelegate instance]
                                                                    action: @selector(showHomeMenu:) ];
        
        self.navigationItem.leftBarButtonItem = homeMenu;

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

- (void) mapView:(MKMapView *)map didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    self.location = userLocation.location;
    
    MKCoordinateRegion region;
    region.center = map.userLocation.coordinate;
    region.span   = MKCoordinateSpanMake( 0.05, 0.05 );
    
    region = [map regionThatFits:region];
    [map setRegion:region animated:YES];

    
}

@end
