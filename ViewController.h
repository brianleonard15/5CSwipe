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
@property (strong, nonatomic) IBOutlet UIButton *transparentButton;

@end
