//
//  CategoryPickerViewController.h
//  myoasis
//
//  Created by Sean Patno on 12/23/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalMapViewController.h"

@interface CategoryPickerViewController : UITableViewController

@property (nonatomic, strong) UIImage * image;
@property (nonatomic, retain) CLLocation* location;

@end
