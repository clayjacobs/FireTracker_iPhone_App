//
//  RatingMenuView.m
//  myoasis
//
//  Created by Andrew on 10/1/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import "RatingMenuView.h"

#import "AppDelegate.h"


@implementation RatingMenuView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame menus:nil];
    
    if (self) {
        
        self.delegate = self;
        
        //--// Add the AwesomeMenu button
        UIImage *ratingItemImage        = [UIImage imageNamed:@"bg-rating-item.png"];
        UIImage *ratingItemImagePressed = [UIImage imageNamed:@"bg-rating-item-highlighted.png"];
       
        [self setImage: [UIImage imageNamed:@"bg-add-rating.png"]];
        
        AwesomeMenuItem *starMenuItem1 = [[AwesomeMenuItem alloc] initWithImage: ratingItemImage
                                                               highlightedImage: ratingItemImagePressed
                                                                   ContentImage: [UIImage imageNamed:@"meh.png"]
                                                        highlightedContentImage: nil];

        AwesomeMenuItem *starMenuItem2 = [[AwesomeMenuItem alloc] initWithImage: ratingItemImage
                                                               highlightedImage: ratingItemImagePressed
                                                                   ContentImage: [UIImage imageNamed:@"sad.png"]
                                                        highlightedContentImage: nil];
        
        AwesomeMenuItem *starMenuItem3 = [[AwesomeMenuItem alloc] initWithImage: ratingItemImage
                                                               highlightedImage: ratingItemImagePressed
                                                                   ContentImage: [UIImage imageNamed:@"biohazard"]
                                                        highlightedContentImage: nil];
        
        [self setMenusArray:[NSArray arrayWithObjects:starMenuItem1, starMenuItem2, starMenuItem3, nil]];
        
        self.startPoint = CGPointMake( 160.0, self.bounds.size.height - 64.0 );
        
        self.rotateAngle = - M_PI / 3;
        self.menuWholeAngle = M_PI;
        
        self.endRadius = 80.0f;
        
        self.farRadius = self.endRadius + 5;
        self.nearRadius = self.endRadius - 5;
        
        self.timeOffset = 0.01f;
        [self setNeedsLayout];
        
    }
    return self;
}

- (void) AwesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx {
    
    [[AppDelegate instance] takePicture:self withTag:idx];
    
}

@end
