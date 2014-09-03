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
        
        AwesomeMenuItem *citizenItem = [[AwesomeMenuItem alloc] initWithImage: ratingItemImage
                                                         highlightedImage: ratingItemImagePressed
                                                             ContentImage: [UIImage imageNamed:@"citizen.png"]
                                                  highlightedContentImage: nil];
        
        AwesomeMenuItem *firefighterItem = [[AwesomeMenuItem alloc] initWithImage: ratingItemImage
                                                         highlightedImage: ratingItemImagePressed
                                                             ContentImage: [UIImage imageNamed:@"firehat.png"]
                                                  highlightedContentImage: nil];
        
        
        [self setMenusArray: [NSArray arrayWithObjects: citizenItem, firefighterItem, nil]];
        
        // Align the button in the horizontal middle, a bit from the bottom of the screen.
        self.startPoint = CGPointMake( self.bounds.size.width / 2, self.bounds.size.height - 64.0 );
        
        // Rotate so that the menu pops above the + icon.
        self.rotateAngle    = -M_PI / 6;
        self.menuWholeAngle = M_PI / 1.5;
        
        // Set how far away the buttons will fly out.
        self.endRadius  = 80.0f;
        
        // Set the bounce/flying animation parameters
        self.farRadius  = self.endRadius + 5;
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