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
#import "TargetConditionals.h"
#import "CategoryPickerViewController.h"

#if TARGET_IPHONE_SIMULATOR

    #define KEEP_USER   @"admin"
    #define KEEP_KEY    @"35f7d1fb1890bdc05f9988d01cf1dcab"

#else

    #define KEEP_USER   @"myoasis"
    #define KEEP_KEY    @"97372f138868fff37f7e1167b93945ca"

#endif



@interface AppDelegate () {
    
    LocalMapViewController *mapView;
    
}

@end

@implementation AppDelegate

@synthesize rootViewController, keep;

+ (AppDelegate*) instance {
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

#pragma mark -
#pragma mark Application Delegate Functions

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Initialize KEEP SDK
    keep = [[KeepSDK alloc] initWithUser: KEEP_USER andKey: KEEP_KEY];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //--// Set up our navigation controller.
    rootViewController = [[UINavigationController alloc] initWithNibName:@"MainNavView" bundle:nil];
    
    //--// Prep our image tagger view.
    imageTagger = [[ImageTaggerViewController alloc] init];
   
    //--// Load up our map view.
    mapView = [[LocalMapViewController alloc] initWithNibName:@"LocalMapView" bundle:nil];
    keep.delegate = mapView;
    
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

- (void) addAnnotation: (UIImage*) taggedImage {
    
    [self addAnnotation:taggedImage withCategory:nil];
    
}

- (void) addAnnotation:(UIImage *)taggedImage withCategory:(NSString *)category {
    // Add image to map
    [mapView addAnnotation: currentTag withImage: taggedImage];

    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];

    // User's UUID
    // See Apple Docs for identifierForVendor for more info on how
    // this identifier is created.
    [data setObject: [[[UIDevice currentDevice] identifierForVendor] UUIDString]
             forKey: @"uuid" ];

    // User's current location
    CLLocationCoordinate2D coords = [[mapView location] coordinate];
    [data setObject: [NSString stringWithFormat: @"%f,%f,%f", coords.longitude,
                      coords.latitude,
                      mapView.location.altitude]
             forKey: @"location" ];

    // Rating
    [data setObject: [NSString stringWithFormat:@"%d", currentTag]
             forKey: @"rating"];

    // Image data
    NSMutableDictionary *images = [[NSMutableDictionary alloc] init];
    [images setObject: taggedImage
               forKey: @"photo" ];

    //add category string
    if( category ) {
        [data setObject:category forKey:@"category"];
    }

    // Upload image to server
    [self.keep postData: data
              andImages: images];
}

- (void) showHomeMenu:(id)sender {

    NSLog( @"Showing home menu" );
 
    UIViewController *test = [[UIViewController alloc] initWithNibName:@"MainMenu" bundle:nil];
    [rootViewController pushViewController:test animated:YES];

}

- (void) addCategoryWithImage:(UIImage *)image {
    CategoryPickerViewController * categoryPicker = [[CategoryPickerViewController alloc] initWithStyle:UITableViewStyleGrouped];
    categoryPicker.image = image;
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:categoryPicker];
    [rootViewController presentViewController:nav animated:YES completion:nil];
}

- (void) takePicture:(id)sender withTag:(int)tag {
    
    currentTag = tag;
    
    [self toggleRatingMenu];
    [rootViewController presentViewController:imageTagger.imagePicker animated:YES completion:nil];
}

- (void) toggleRatingMenu {
    
    CGFloat alpha = 0.0;
    if( menuView.alpha < 1.0 ) {
        alpha = 1.0;
    }
    
    [UIView animateWithDuration:0.25 animations:^(void) {
        
        menuView.alpha = alpha;
        
    } completion:^(BOOL finished) {}];

}

@end
