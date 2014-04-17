//
//  ViewController.m
//  5CSwipe
//
//  Created by Brian on 4/16/14.
//  Copyright (c) 2014 Brian Leonard. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

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
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"balanceCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    UILabel *balance = (UILabel*) [cell viewWithTag:0];

        switch (indexPath.row) {
            case 0:
                balance.text = [NSString stringWithFormat:@"Flex: $%@", self.flex];
                break;
            case 1:
                balance.text = [NSString stringWithFormat:@"Claremont Cash: $%@", self.claremontCash];
                break;
            case 2:
                balance.text = [NSString stringWithFormat:@"Meals: %@", self.meals];
                break;
            default:
                break;
        }

    
    return cell;
}


- (IBAction)logoutButton:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
