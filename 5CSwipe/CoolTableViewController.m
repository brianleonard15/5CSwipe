//
//  CoolTableViewController.m
//  CoolTable
//
//  Created by Brian Moakley on 2/15/13.
//  Copyright (c) 2013 Razeware. All rights reserved.
//

#import "CoolTableViewController.h"
#import "CustomCellBackground.h"
#import "CustomHeader.h"
#import "CustomFooter.h"

@interface CoolTableViewController ()

@property (copy) NSMutableArray *flexSection;
@property (copy) NSMutableArray *claremontCashSection;
@property (copy) NSMutableArray *mealsSection;

@end

@implementation CoolTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Core Graphics 101";
    self.flexSection = [@[[NSString stringWithFormat:@"$%@ remaining", self.flex]] mutableCopy];
    self.claremontCashSection = [@[[NSString stringWithFormat:@"$%@ remaining", self.claremontCash]] mutableCopy];
    self.mealsSection = [@[[NSString stringWithFormat:@"%@ meals remaining", self.meals]] mutableCopy];
    
    UIImageView * background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_bg.jpg"]];
    self.tableView.backgroundView = background;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[CustomFooter alloc] init];
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CustomHeader * header = [[CustomHeader alloc] init];
    header.titleLabel.text = [self tableView: tableView titleForHeaderInSection:section];
    if (section == 1) {
        header.lightColor = [UIColor colorWithRed:147.0/255.0 green:105.0/255.0 blue:216.0/255.0 alpha:1.0];
        header.darkColor = [UIColor colorWithRed:72.0/255.0 green:22.0/255.0 blue:137.0/255.0 alpha:1.0];
    }
    else if (section == 2) {
        header.lightColor = [UIColor colorWithRed:10.0/255.0 green:102.0/255.0 blue:90.0/255.0 alpha:1.0];
        header.darkColor = [UIColor colorWithRed:10.0/255.0 green:72.0/255.0 blue:93.0/255.0 alpha:1.0];
    }
    return header;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.flexSection.count;
    } else if (section == 1) {
        return self.claremontCashSection.count;
    }
    else {
        return self.mealsSection.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (![cell.backgroundView isKindOfClass:[CustomCellBackground class]]) {
        CustomCellBackground * backgroundCell = [[CustomCellBackground alloc] init];
        cell.backgroundView = backgroundCell;
    }
    
    if (![cell.selectedBackgroundView isKindOfClass:[CustomCellBackground class]]) {
        CustomCellBackground * selectedBackgroundCell = [[CustomCellBackground alloc] init];
        selectedBackgroundCell.selected = YES;
        cell.selectedBackgroundView = selectedBackgroundCell;
    }
    
    NSString * entry;
    
    if (indexPath.section == 0) {
        entry = self.flexSection[indexPath.row];
        ((CustomCellBackground *) cell.backgroundView).lastCell = indexPath.row == self.flexSection.count - 1;
        ((CustomCellBackground *)cell.selectedBackgroundView).lastCell = indexPath.row == self.flexSection.count - 1;
    } else if (indexPath.section == 1) {
        entry = self.claremontCashSection[indexPath.row];
        ((CustomCellBackground *)cell.backgroundView).lastCell = indexPath.row == self.claremontCashSection.count - 1;
        ((CustomCellBackground *)cell.selectedBackgroundView).lastCell = indexPath.row == self.claremontCashSection.count - 1;
    }
    else {
        entry = self.mealsSection[indexPath.row];
        ((CustomCellBackground *)cell.backgroundView).lastCell = indexPath.row == self.mealsSection.count - 1;
        ((CustomCellBackground *)cell.selectedBackgroundView).lastCell = indexPath.row == self.mealsSection.count - 1;
    }
    cell.textLabel.text = entry;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.highlightedTextColor = [UIColor blackColor];
    
    return cell;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Flex";
    } else if (section == 1) {
        return @"Claremont Cash";
    }
    else {
        return @"Meals";
    }
    
}

@end