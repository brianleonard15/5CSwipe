//
//  ViewController.h
//  5CSwipe
//
//  Created by Brian on 4/16/14.
//  Copyright (c) 2014 Brian Leonard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
- (IBAction)logoutButton:(UIButton *)sender;
@property (nonatomic, strong) NSString *flex;
@property (nonatomic, strong) NSString *claremontCash;
@property (nonatomic, strong) NSString *meals;
@property (nonatomic, strong) NSString *flexHTML;
@property (nonatomic, strong) NSString *claremontCashHTML;
@property (nonatomic, strong) NSString *mealsHTML;
@property (nonatomic, strong) NSString *detailHTML;
@property (strong, nonatomic) IBOutlet UILabel *flexLabel;
@property (strong, nonatomic) IBOutlet UILabel *claremontCashLabel;
@property (strong, nonatomic) IBOutlet UILabel *mealsLabel;
@property (strong, nonatomic) IBOutlet UIButton *flexButton;
@property (strong, nonatomic) IBOutlet UIButton *claremontCashButton;
@property (strong, nonatomic) IBOutlet UIButton *mealsButton;
- (IBAction)flexButtonPressed:(UIButton *)sender;
- (IBAction)claremontCashButtonPressed:(UIButton *)sender;
- (IBAction)mealsButtonPressed:(UIButton *)sender;

@end
