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


@interface LocalMapViewController : UIViewController<MKMapViewDelegate, KeepSDKDelegate> {
    
    IBOutlet MKMapView *mapView;
    IBOutlet RatingDetailView *annotationDetail;
    IBOutlet UISegmentedControl *mapViewOptionsControl;
    
    // User's current location
    CLLocation *location;
    
}

@property (nonatomic, retain) CLLocation* location;

- (void) addAnnotation: (int) tagType withImage: (UIImage*) taggedImage;
- (NSString*) boundingBox;

- (IBAction) mapViewOptionSelected: (id)sender;

@end
