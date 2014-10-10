//
//  LocalMapViewController.h
//  myoasis
//
//  Created by Andrew on 10/1/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "keep.h"
#import "RatingDetailView.h"
#import "AppDelegate.h"


@interface LocalMapViewController : UIViewController<MKMapViewDelegate, KeepSDKDelegate, NSXMLParserDelegate> {
    
    IBOutlet MKMapView *mapView;
    IBOutlet RatingDetailView *annotationDetail;
    IBOutlet UISegmentedControl *mapViewOptionsControl;
    IBOutlet UIButton *recenterButton;
    IBOutlet UIButton *infoButton;
    
    // User's current location
    CLLocation *location;
}

@property (nonatomic, retain) CLLocation* location;

- (void) addAnnotation: (int) tagType withImage: (UIImage*) taggedImage;
- (NSString*) boundingBox;
- (void) addIcon: (NSMutableArray*)datum;

- (IBAction) mapViewOptionSelected: (id)sender;
- (IBAction) recenterMap:(id)sender;
- (IBAction) openInfo:(id)sender;

@end
