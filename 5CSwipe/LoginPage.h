//
//  LoginPage.h
//  Claremont Card
//
//  Created by Brian on 4/15/14.
//  Copyright (c) 2014 Brian Leonard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginPage : UIViewController <UIWebViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)buttonPress:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *idInput;
@property (strong, nonatomic) IBOutlet UITextField *passwordInput;
@property (strong, nonatomic) IBOutlet UIButton *checkBox;
- (IBAction)checkButtonTapped:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *incorrectLabel;
@property (strong, nonatomic) IBOutlet UIImageView *check;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *myActivityView;

@end
