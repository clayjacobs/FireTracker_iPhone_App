//
//  AppDelegate.m
//  myoasis
//
//  Created by Andrew on 10/1/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import <AwesomeMenu.h>
#import "AppDelegate.h"

#import "LocalMapViewController.h"


@interface AppDelegate () {
    
    LocalMapViewController *mapView;
    
}

@end

@implementation AppDelegate

@synthesize rootViewController;

+ (AppDelegate*) instance {
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

#pragma mark -
#pragma mark Application Delegate Functions

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //--// Set up our navigation controller
    rootViewController = [[UINavigationController alloc] initWithNibName:@"MainNavView" bundle:nil];
    
   
    //--// Load up our map view
    mapView = [[LocalMapViewController alloc] initWithNibName:@"LocalMapView" bundle:nil];
    
    [rootViewController addChildViewController:mapView];

    //--// Set up navigation style
    [rootViewController.navigationBar setTintColor: [UIColor orangeColor]];
    if( [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f ) {
        [rootViewController.navigationBar setBarTintColor: [UIColor whiteColor]];
    }

    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
    
    menuView = [[RatingMenuView alloc] initWithFrame:self.window.bounds];
    [self.window addSubview:menuView];
    
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
}

#pragma mark -
#pragma mark Public functions

- (void) addAnnotation {
    [mapView addAnnotation: currentTag];
}

- (void) showHomeMenu:(id)sender {
    
    NSLog( @"Showing home menu" );
 
    UIViewController *test = [[UIViewController alloc] initWithNibName:@"MainMenu" bundle:nil];
    [rootViewController pushViewController:test animated:YES];

}

- (void) takePicture:(id)sender withTag:(int)tag {
    
    currentTag = tag;
    
    if( imageTagger == nil ) {
        imageTagger = [[ImageTaggerViewController alloc] init];
    }
    
    [self toggleRatingMenu];
    [rootViewController presentViewController:imageTagger.imagePicker animated:YES completion:nil];
}

- (void) toggleRatingMenu {
    [menuView setHidden: !menuView.hidden];
}

@end
