//
//  LocalMapViewController.h
//  myoasis
//
//  Created by Andrew on 10/1/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LocalMapViewController : UIViewController<MKMapViewDelegate> {
    
    IBOutlet MKMapView* mapView;
    CLLocation* location;
    
}

@property (nonatomic, retain) CLLocation* location;

@end
