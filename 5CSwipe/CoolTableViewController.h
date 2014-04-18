//
//  CoolTableViewController.h
//  CoolTable
//
//  Created by Brian Moakley on 2/15/13.
//  Copyright (c) 2013 Razeware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoolTableViewController : UIViewController

@property (nonatomic, strong) NSString *flex;
@property (nonatomic, strong) NSString *claremontCash;
@property (nonatomic, strong) NSString *meals;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
- (IBAction)logoutButton:(UIButton *)sender;

@end
