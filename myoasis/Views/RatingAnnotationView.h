//
//  RatingAnnotation.h
//  myoasis
//
//  Created by Andrew on 10/2/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface RatingAnnotationView : MKAnnotationView

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier;

@end

