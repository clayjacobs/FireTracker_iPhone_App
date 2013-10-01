//
//  AppDelegate.h
//  myoasis
//
//  Created by Andrew on 10/1/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RatingMenuView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {

    UINavigationController *rootViewController;
    RatingMenuView *menuView;
    
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *rootViewController;

+ (AppDelegate*)instance;

@end
