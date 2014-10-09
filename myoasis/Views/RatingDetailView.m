//
//  RatingDetailView.m
//  myoasis
//
//  Created by Andrew on 10/2/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import "RatingDetailView.h"

@implementation RatingDetailView

@synthesize annotation;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
    
}

- (void) willMoveToSuperview:(UIView *)newSuperview {

    if( annotation.category ) {
        categoryLabel.text = annotation.category;
    } else {
        categoryLabel.text = @"Uncategorized";
    }

    if( annotation.isLocal ) {
        taggedImage.image = annotation.taggedImage;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
