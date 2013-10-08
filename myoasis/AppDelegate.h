//
//  AppDelegate.h
//  myoasis
//
//  Created by Andrew on 10/1/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "keep-sdk/keep_sdk.h"

#import "RatingMenuView.h"
#import "ImageTaggerViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate> {

    UINavigationController *rootViewController;
    
    ImageTaggerViewController *imageTagger;
    
    RatingMenuView *menuView;
    
    KeepSDK *keep;
    
    int currentTag;
    
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *rootViewController;

+ (AppDelegate*) instance;

- (void) addAnnotation: (UIImage*) taggedImage;
- (void) showHomeMenu: (id)sender;
- (void) takePicture: (id)sender withTag: (int)tag;
- (void) toggleRatingMenu;

@end
