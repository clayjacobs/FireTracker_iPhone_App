//
//  AppDelegate.m
//  myoasis
//
//  Created by Andrew on 10/1/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import <AwesomeMenu.h>
#import "AppDelegate.h"

#import "Controllers/LocalMapViewController.h"

@implementation AppDelegate

@synthesize rootViewController;

+ (AppDelegate*) instance {
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //--// Set up our navigation controller
    rootViewController = [[UINavigationController alloc] initWithNibName:@"MainNavView" bundle:nil];
                          
    //--// Load up our map view
    LocalMapViewController *mapView = [[LocalMapViewController alloc] initWithNibName:@"LocalMapView" bundle:nil];
    [rootViewController addChildViewController:mapView];
    
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

- (void) showHomeMenu:(id)sender {
    
    NSLog( @"Showing home menu" );
 
    UIViewController *test = [[UIViewController alloc] initWithNibName:@"MainMenu" bundle:nil];
    [rootViewController pushViewController:test animated:YES];

}

@end
