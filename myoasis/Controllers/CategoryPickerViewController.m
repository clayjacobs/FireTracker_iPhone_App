//
//  CategoryPickerViewController.m
//  myoasis
//
//  Created by Sean Patno on 12/23/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import "CategoryPickerViewController.h"

#import "AppDelegate.h"

#import "LocalMapViewController.h"

@interface CategoryPickerViewController ()
{
    NSString * selectedCategory;
    NSString * selectedTime;
    NSString * selectedSeverity;
    NSInteger selectedCategoryRow;
    NSInteger selectedTimeRow;
    NSInteger selectedSeverityRow;
    int currentTag;
    float currentLat;
    float currentLong;
    float time;
    UIImage *pic;
}

@end

@implementation CategoryPickerViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        selectedCategoryRow = -1;
        selectedTimeRow = 0;
        selectedSeverityRow = -1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Add Details";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:255.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(finish)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:255.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    currentTag = [[AppDelegate instance] getCurrentTag];
}

-(void) cancel
{
    [self dismissViewControllerAnimated:YES completion:^(){
        [[AppDelegate instance] toggleRatingMenu];
    }];
}

- (void) finish
{
    if ( selectedCategory ) {
        [self dismissViewControllerAnimated:YES completion:^(){
            time = (float)[[NSDate date] timeIntervalSince1970 ]*1000;
            currentLat = [[AppDelegate instance] getCurrentLat];
            currentLong = [[AppDelegate instance] getCurrentLong];
            pic = self.image;

            NSDictionary * jsonParams = @{@"category": selectedCategory, @"severity": selectedSeverity, @"lat": [NSNumber numberWithFloat:currentLat], @"long": [NSNumber numberWithFloat:currentLong], @"time_submitted": [NSNumber numberWithFloat:time], @"image": pic};
        
            NSLog( @"%@", jsonParams );
            //[[AppDelegate instance] addAnnotation:self.image withDictionary:jsonParams];
            [[AppDelegate instance] toggleRatingMenu];
        }];
    };
    /*if( selectedCategory ) {
        [self dismissViewControllerAnimated:YES completion:^(){
            
            NSDictionary * annotationParams = @{ @"category": selectedCategory, @"expiration_time": selectedTime};
            
            [[AppDelegate instance] addAnnotation:self.image withDictionary:annotationParams];
            [[AppDelegate instance] toggleRatingMenu];
        }];
    } else {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please select a category" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if( section == 0 ) {
        return @"Fire Subcategory";
    }
    else
        return @"Select Severity of Fire";
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if (currentTag == 0)
        return 2;
    else
        return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if( section == 0 ) {
        return 5;
    }
    else if( section == 1) {
        return 3;
    }
    else
        return 2;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    switch (indexPath.section) {
        case 0:
        {
            if( indexPath.row == selectedCategoryRow ) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                selectedCategory = cell.textLabel.text;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }{
            if (currentTag == 0) {
                switch (indexPath.row) {
                    case 0:
                    {
                        cell.textLabel.text = @"Forest Fire";
                        cell.imageView.image = [UIImage imageNamed:@"wildfire.png"];
                        break;
                    }
                    case 1:
                    {
                        cell.textLabel.text = @"Brush Fire";
                        cell.imageView.image = [UIImage imageNamed:@"brush.png"];
                        break;
                    }
                    case 2:
                    {
                        cell.textLabel.text = @"Building Fire";
                        cell.imageView.image = [UIImage imageNamed:@"house.png"];
                        break;
                    }
                    case 3:
                        cell.textLabel.text = @"Chemical Fire";
                        cell.imageView.image = [UIImage imageNamed:@"biohazard.png"];
                        break;
                    case 4:
                    {
                        cell.textLabel.text = @"Miscellaneous Fire";
                        cell.imageView.image = [UIImage imageNamed:@"misc.png"];
                        break;
                    }
                        
                    default:
                        break;
                }
                break;
            }
            else if (currentTag == 1) {
                switch (indexPath.row) {
                    case 0:
                    {
                        cell.textLabel.text = @"Wildfire Subcategory 1";
                        cell.imageView.image = [UIImage imageNamed:@"wildfire.png"];
                        break;
                    }
                    case 1:
                    {
                        cell.textLabel.text = @"Wildfire Subcategory 2";
                        cell.imageView.image = [UIImage imageNamed:@"wildfire.png"];
                        break;
                    }
                    case 2:
                    {
                        cell.textLabel.text = @"Wildfire Subcategory 3";
                        cell.imageView.image = [UIImage imageNamed:@"wildfire.png"];
                        break;
                    }
                    case 3:
                    {
                        cell.textLabel.text = @"Wildfire Subcategory 4";
                        cell.imageView.image = [UIImage imageNamed:@"wildfire.png"];
                        break;
                    }
                    case 4:
                    {
                        cell.textLabel.text = @"Wildfire Subcategory 5";
                        cell.imageView.image = [UIImage imageNamed:@"wildfire.png"];
                        break;
                    }
                        
                    default:
                        break;
                }
                break;
            }
                break;
            }}
        /*case 1:
        {
            if( indexPath.row == selectedTimeRow ) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                selectedTime = cell.textLabel.text;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"Never";
                    break;
                case 1:
                    cell.textLabel.text = @"1 hour";
                    break;
                case 2:
                    cell.textLabel.text = @"1 day";
                    break;
                case 3:
                    cell.textLabel.text = @"1 week";
                    break;
                    
                default:
                    break;
            }
            break;
        }*/
       case 1:
        {
            if( indexPath.row == selectedSeverityRow ) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                selectedSeverity = cell.textLabel.text;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            
            switch (indexPath.row) {
                case 0:
                {
                    cell.textLabel.text = @"Small (0-10 acres)";
                    cell.imageView.image = [UIImage imageNamed:@"fire-green.png"];
                    break;
                }
                case 1:
                {
                    cell.textLabel.text = @"Medium (10-50 acres)";
                    cell.imageView.image = [UIImage imageNamed:@"fire-yellow.png"];
                    break;
                }
                case 2:
                {
                    cell.textLabel.text = @"Large (50+ acres)";
                    cell.imageView.image = [UIImage imageNamed:@"fire-red.png"];
                    break;
                }
                    
                default:
                    break;
            }
            break;
        }
        /*if ( currentTag == 1)
        {
            case 2:
            {
                if( indexPath.row == selectedonSceneRow ) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                    selectedSeverity = cell.textLabel.text;
                } else {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
            
                switch (indexPath.row) {
                    case 0:
                    {
                        cell.textLabel.text = @"Yes";
                        cell.imageView.image = [UIImage imageNamed:@"checkmark.png"];
                        break;
                    }
                    case 1:
                    {
                        cell.textLabel.text = @"No";
                        cell.imageView.image = [UIImage imageNamed:@"x-mark.png"];
                        break;
                    }
                    
                    default:
                    break;
                }
                break;
            }
        }*/
        default:
            break;
    }
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( indexPath.section == 0 ) {
        selectedCategoryRow = indexPath.row;
    }
    else if( indexPath.section == 1) {
        selectedSeverityRow = indexPath.row;
    }
    
    [tableView reloadData];
}


@end