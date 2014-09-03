//
//  AppDelegate.h
//  myoasis
//
//  Created by Andrew on 10/1/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "keep-sdk/keep.h"

#import "RatingMenuView.h"
#import "ImageTaggerViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate> {

    UINavigationController *rootViewController;
    
    ImageTaggerViewController *imageTagger;
    
    RatingMenuView *menuView;
    
    KeepSDK *keep;
    
    int currentTag;
    
    double currentLat;
    
    double currnetLong;
    
    NSInteger categoryNum;
    
    NSString *severity;
    
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *rootViewController;

// Readonly variables
@property (nonatomic, readonly) KeepSDK *keep;

+ (AppDelegate*) instance;

- (void) addAnnotation: (UIImage*) taggedImage;
- (void) addAnnotation: (UIImage*) taggedImage withCategory:(NSString*) category;
- (void) addAnnotation: (UIImage*) taggedImage withDictionary:(NSDictionary*) dictionary;
- (void) showHomeMenu: (id)sender;
- (void) takePicture: (id)sender withTag: (int)tag;
- (void) addCategoryWithImage:(UIImage*) image;
- (void) toggleRatingMenu;
- (int) getCurrentTag;
- (double) getCurrentLat;
- (double) getCurrentLong;

@end