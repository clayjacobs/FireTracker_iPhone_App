//
//  ImageTaggerViewController.h
//  myoasis
//
//  Created by Andrew on 10/2/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageTaggerViewController : NSObject<UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    
    UIImagePickerController *imagePicker;
    
}

@property (strong, nonatomic) UIImagePickerController *imagePicker;

@end
