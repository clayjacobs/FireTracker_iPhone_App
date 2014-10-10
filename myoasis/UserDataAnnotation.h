//
//  UserDataAnnotation.h
//  FireTracker
//
//  Created by CJ Jacobs on 10/9/14.
//  Copyright (c) 2014 DHLabs. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface UserDataAnnotation : NSObject<MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *category;
@property (copy, nonatomic) NSString *size;
@property (nonatomic, copy) NSString *title;

-(id)initCategory:(NSString *)newCategory Location:(CLLocationCoordinate2D)newLocation Size:(NSString *)newSize;
- (MKAnnotationView *)annotationView;


@end
