//
//  CoolTableViewController.h
//  CoolTable
//
//  Created by Brian Moakley on 2/15/13.
//  Copyright (c) 2013 Razeware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoolTableViewController : UITableViewController

- (IBAction)logoutButton:(UIBarButtonItem *)sender;
@property (nonatomic, strong) NSString *flex;
@property (nonatomic, strong) NSString *claremontCash;
@property (nonatomic, strong) NSString *meals;

@end
