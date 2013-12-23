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
    
    // Whether this is a local annotation (thus using the
    // taggedImage instead of taggedImageURL)
    BOOL isLocal;
    
    // Custom annotation fields.
    NSURL *taggedImageURL;
    UIImage *taggedImage;
    int tag;
    
}

@property (assign) int tag;
@property (assign) BOOL isLocal;
@property (nonatomic, strong) NSURL *taggedImageURL;
@property (nonatomic, strong) UIImage *taggedImage;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* subtitle;
@property (nonatomic, copy) NSString* category;

- (NSString*) identifier;

@end
