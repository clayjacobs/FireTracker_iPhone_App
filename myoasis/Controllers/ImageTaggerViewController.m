//
//  ImageTaggerViewController.m
//  myoasis
//
//  Created by Andrew on 10/2/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import "ImageTaggerViewController.h"
#import "AppDelegate.h"
#import "TargetConditionals.h"

@interface ImageTaggerViewController ()

@end

@implementation ImageTaggerViewController

@synthesize imagePicker;

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        imagePicker = [[UIImagePickerController alloc] init];
        [imagePicker setDelegate:self];
        
        if( [UIImagePickerController isCameraDeviceAvailable: UIImagePickerControllerCameraDeviceFront] ) {
            
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
        } else {
            
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
        }
        
    }
    
    return self;
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    UIImage *taggedImage = (UIImage*)[info valueForKey: UIImagePickerControllerOriginalImage];
    NSLog( @"IMAGE: %@", [taggedImage description] );


    [imagePicker dismissViewControllerAnimated:YES completion:^(void) {
        
        //[[AppDelegate instance] addAnnotation: taggedImage];
        //[[AppDelegate instance] toggleRatingMenu];

        [[AppDelegate instance] addCategoryWithImage:taggedImage];
        
    }];
    
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {

    [imagePicker dismissViewControllerAnimated:YES completion:^(void) {

        if( TARGET_IPHONE_SIMULATOR ) {
            [[AppDelegate instance] addAnnotation: [UIImage imageNamed:@"house.png"]];
        }
        
        [[AppDelegate instance] toggleRatingMenu];
        
    }];
    
}

@end
