//
//  HeatmapAnnotationView.m
//  myoasis
//
//  Created by Andrew on 10/7/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import "HeatmapAnnotationView.h"
#import "RatingAnnotation.h"

@implementation HeatmapAnnotationView

- (id) initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if( self ) {

        UIImage *annotationImage = [UIImage imageNamed:@"heatmap.png"];
        
        CGRect frame = [self frame];
        frame.size = [annotationImage size];
        
        [self setFrame:frame];
        [self setImage:annotationImage];
        
        [self setEnabled:NO];
        [self setCanShowCallout:NO];
        
    }
    
    return self;
}

@end
