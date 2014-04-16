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
- (IBAction)buttonPress:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *idInput;
@property (strong, nonatomic) IBOutlet UITextField *passwordInput;



@end
