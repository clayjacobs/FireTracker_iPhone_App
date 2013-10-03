//
//  RatingAnnotation.h
//  myoasis
//
//  Created by Andrew on 10/2/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface RatingAnnotation : NSObject<MKAnnotation> {
    
    // Required for the MKAnnotation protocol
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
    
    // Custom annotation fields.
    UIImage *taggedImage;
    int tag;
    
}

@property (assign) int tag;
@property (nonatomic, strong) UIImage *taggedImage;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* subtitle;

- (NSString*) identifier;

@end
