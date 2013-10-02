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
        UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
        UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];
        UIImage *starImage = [UIImage imageNamed:@"sad.png"];
        
        AwesomeMenuItem *starMenuItem1 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:starImage
                                                        highlightedContentImage:nil];

        AwesomeMenuItem *starMenuItem2 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:starImage
                                                        highlightedContentImage:nil];
        
        AwesomeMenuItem *starMenuItem3 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:starImage
                                                        highlightedContentImage:nil];
        
        [self setMenusArray:[NSArray arrayWithObjects:starMenuItem1, starMenuItem2, starMenuItem3, nil]];
        
        self.startPoint = CGPointMake( 160.0, self.bounds.size.height - 32.0 );
        
        self.rotateAngle = - M_PI / 3;
        self.menuWholeAngle = M_PI;
        
        self.farRadius = 69.0f;
        self.nearRadius = 59.0f;
        self.endRadius = 64.0f;
        
        self.timeOffset = 0.01f;
        [self setNeedsLayout];
        
    }
    return self;
}

- (void) AwesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx {
    
    [[AppDelegate instance] takePicture:self withTag:idx];
    
}

@end
