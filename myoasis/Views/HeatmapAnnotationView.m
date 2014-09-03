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
    
    // if ((currentTime - timeSinceFire) > 0) {
        // int frequency = (int)((12)/((currentTime - timeSinceFire) / (60*60)));
    // }
    // else {
        // frequency = 0;
    // }
    
    // NSArray *imageNames = @[@"red_1.png", @"red_2.png", @"red_3.png", @"red_4.png",
    // @"red_5.png", @"red_6.png", @"red_7.png", @"red_8.png",
    // @"red_9.png", @"red_10.png", @"red_11.png", @"red_12.png"];
    
    // NSMutableArray *images = [[NSMutableArray alloc] init];
    // for (int i = 0; i < (imageNames.count - frequency); i++) {
        // [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    // }
    
    // UIImageView *animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 95, 86, 193)];
    // animationImageView.animationImages = images;
    // animationImageView.animationDuration = 1;
    
    if( self ) {
        
        RatingAnnotation *pin = (RatingAnnotation*)annotation;
        
        UIImage *annotationImage;
        if( pin.tag == 0 ) {
            annotationImage = [UIImage imageNamed: @"green"];
            // annotationImage = images.image;
        } else if( pin.tag == 1 ) {
            annotationImage = [UIImage imageNamed: @"yellow"];
        } else {
            annotationImage = [UIImage imageNamed: @"red"];
        }
        
        CGRect frame = [self frame];
        frame.size = [annotationImage size];
        
        [self setFrame:frame];
        [self setImage:annotationImage];
        
        [self setEnabled:NO];
        [self setCanShowCallout:NO];
        
        // TODO: Determine alpha based on the annotation/density/time
        self.alpha = 0.25;
        
    }
    
    return self;
}

@end
