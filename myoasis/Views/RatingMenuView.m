//
//  RatingMenuView.m
//  myoasis
//
//  Created by Andrew on 10/1/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import "RatingMenuView.h"

@implementation RatingMenuView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame menus:nil];
    
    if (self) {
        
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
        
        // the start item, similar to "add" button of Path
        AwesomeMenuItem *startItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg-addbutton.png"]
                                                           highlightedImage:[UIImage imageNamed:@"bg-addbutton-highlighted.png"]
                                                               ContentImage:[UIImage imageNamed:@"icon-plus.png"]
                                                    highlightedContentImage:[UIImage imageNamed:@"icon-plus-highlighted.png"]];
        
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
