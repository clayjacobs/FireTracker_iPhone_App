//
//  RatingDetailView.h
//  myoasis
//
//  Created by Andrew on 10/2/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RatingAnnotation.h"


@interface RatingDetailView : UIView {
    
    IBOutlet UIImageView *taggedImage;

    RatingAnnotation *annotation;
    
}

@property (nonatomic, strong) RatingAnnotation *annotation;

@end
