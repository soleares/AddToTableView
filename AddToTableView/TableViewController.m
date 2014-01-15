//
//  TableViewController.m
//  AddToTableView
//
//  Created by Jesse Wolff on 1/14/14.
//  Copyright (c) 2014 Soleares. All rights reserved.
//

#import "TableViewController.h"
#import "AddViewController.h"

@interface TableViewController ()
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initial data
    self.data = [NSMutableArray arrayWithArray:@[@"Apples", @"Bananas", @"Grapes"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}

// Called after 'Save' is tapped on the AddViewController
- (IBAction)unwindToTableViewController:(UIStoryboardSegue *)sender
{
    if ([sender.identifier isEqualToString:@"dismissAddViewController"]) {
        // Get the value of the text field
        AddViewController *addViewController = (AddViewController *)sender.sourceViewController;
        NSString *text = addViewController.textField.text;
        
        // If nil/blank or whitespace
        if ([text length] == 0 ||
            [[text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
            text = @"<Blank>";
        }
        
        // Add it to the end of the datasource
        [self.data addObject:text];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self.data count] - 1) inSection:0];
        
        // Insert it into the tableview
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
    }
}

@end
