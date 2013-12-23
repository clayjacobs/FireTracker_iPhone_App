//
//  CategoryPickerViewController.m
//  myoasis
//
//  Created by Sean Patno on 12/23/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import "CategoryPickerViewController.h"

#import "AppDelegate.h"

@interface CategoryPickerViewController ()
{
    NSString * selectedCategory;
    NSInteger selectedRow;
}

@end

@implementation CategoryPickerViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        selectedRow = -1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Select Category";

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(finish)];
}

-(void) cancel
{
    [self dismissViewControllerAnimated:YES completion:^(){
        [[AppDelegate instance] toggleRatingMenu];
    }];
}

- (void) finish
{
    if( selectedCategory ) {
        [self dismissViewControllerAnimated:YES completion:^(){

            [[AppDelegate instance] addAnnotation:self.image withCategory:selectedCategory];
            [[AppDelegate instance] toggleRatingMenu];
        }];
    } else {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please select a category" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Trash";
            break;
        case 1:
            cell.textLabel.text = @"Biohazard";
            break;
        case 2:
            cell.textLabel.text = @"Contaminated Food";
            break;
        case 3:
            cell.textLabel.text = @"Contaminated Water";
            break;
        case 4:
            cell.textLabel.text = @"Possible Infectious Illness";
            break;
        case 5:
            cell.textLabel.text = @"Physical Hazard";
            break;

        default:
            break;
    }

    if( indexPath.row == selectedRow ) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        selectedCategory = cell.textLabel.text;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedRow = indexPath.row;
    [tableView reloadData];
}


@end
