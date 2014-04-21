//
//  LoginPage.m
//  Claremont Card
//
//  Created by Brian on 4/15/14.
//  Copyright (c) 2014 Brian Leonard. All rights reserved.
//

#import "LoginPage.h"
#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "STKeychain.h"

#define FONT_CANDICE(s) [UIFont fontWithName:@"Candice" size:s]

@interface LoginPage () {
    
NSString *flexBalance;
NSString *claremontCashBalance;
NSString *mealsBalance;
NSString *flexTable;
NSString *claremontCashTable;
NSString *mealsTable;
    
}
@end

@implementation LoginPage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.loginButton.enabled = NO;
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"background.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
//    NSDictionary *fiveDict = [NSDictionary dictionaryWithObject: FONT_CANDICE(80.0f) forKey:NSFontAttributeName];
//    NSMutableAttributedString *fAttrString = [[NSMutableAttributedString alloc] initWithString:@"5" attributes: fiveDict];
//    NSDictionary *cSwipeDict = [NSDictionary dictionaryWithObject:FONT_CANDICE(50.0f) forKey:NSFontAttributeName];
//    NSMutableAttributedString *cAttrString = [[NSMutableAttributedString alloc]initWithString: @"C Swipe" attributes:cSwipeDict];
//    
//    [fAttrString appendAttributedString:cAttrString];
//    
//    self.titleLabel.attributedText = fAttrString;
    NSString* s2 = @"5C Swipe";
    NSMutableAttributedString* content2 =
    [[NSMutableAttributedString alloc]
     initWithString:s2
     attributes:
     @{
       NSFontAttributeName:
           FONT_CANDICE(50.0f)
       }];
    [content2 setAttributes:
     @{
       NSFontAttributeName:FONT_CANDICE(70.0f), NSBaselineOffsetAttributeName : @-4
       } range:NSMakeRange(0,1)];
    [content2 addAttributes:
     @{
       NSKernAttributeName:@-7
       } range:NSMakeRange(0,1)];
    
    NSMutableParagraphStyle* para2 = [NSMutableParagraphStyle new];
    para2.headIndent = 10;
    para2.firstLineHeadIndent = 10;
    para2.tailIndent = -10;
    para2.lineBreakMode = NSLineBreakByWordWrapping;
    para2.alignment = NSTextAlignmentJustified;
    para2.lineHeightMultiple = 1.2;
    para2.hyphenationFactor = 1.0;
    [content2 addAttribute:NSParagraphStyleAttributeName
                     value:para2 range:NSMakeRange(0,1)];
    self.titleLabel.attributedText = content2;
    self.checkBox.layer.cornerRadius = 5;
    self.checkBox.layer.borderWidth = 1;
    self.checkBox.layer.borderColor = [[UIColor whiteColor] CGColor];
//    self.loginButton.layer.cornerRadius = 6;
//    self.loginButton.layer.borderWidth = 2;
//    self.loginButton.layer.borderColor = [UIColor colorWithRed:10.0/255.0 green:72.0/255.0 blue:93.0/255.0 alpha:1.0].CGColor;
//    UIGraphicsBeginImageContext(self.loginButton.frame.size);
//    [[UIImage imageNamed:@"loginButton.png"] drawInRect:self.loginButton.bounds];
//    UIImage *loginImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    self.loginButton.backgroundColor = [UIColor colorWithPatternImage:loginImage];
    self.idInput.delegate = self;
    self.passwordInput.delegate = self;
    self.webView.hidden = YES;
    self.webView.delegate = self;
    self.idInput.layer.cornerRadius = 8;
    self.idInput.layer.borderWidth = 1.0f;
    self.idInput.layer.borderColor = [[UIColor whiteColor] CGColor];
    UIColor *placeholderColor =[UIColor grayColor];
    self.idInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Student ID" attributes:@{NSForegroundColorAttributeName: placeholderColor}];
    self.passwordInput.layer.cornerRadius = 8;
    self.passwordInput.layer.borderWidth = 1.0f;
    self.passwordInput.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.passwordInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: placeholderColor}];


    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    self.incorrectLabel.hidden = YES;
    
    NSURL *websiteUrl = [NSURL URLWithString:@"https://cards.cuc.claremont.edu/login.php"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    [self.webView loadRequest:urlRequest];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *rememberState = [prefs stringForKey:@"rememberState"];
    
    if ([rememberState isEqualToString:@"Remember"]) {
        NSError *error = nil;
        NSString *savedUsername = [prefs stringForKey:@"username"];
        self.idInput.text = savedUsername;
        self.passwordInput.text = [STKeychain getPasswordForUsername:savedUsername andServiceName:@"5CSwipe" error:&error];
        [self.checkBox setSelected:YES];
        self.check.hidden = NO;
    }
    else
    {
        [self.checkBox setSelected:NO];
        self.check.hidden = YES;
        self.idInput.text = nil;
        self.passwordInput.text = nil;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)buttonPress:(id)sender
{

    NSError *error = nil;
    NSString *username = self.idInput.text;
    NSString *password = self.passwordInput.text;
    
    if (!self.check.hidden)
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:username forKey:@"username"];
        [prefs synchronize];
        [STKeychain storeUsername:username andPassword:password forServiceName:@"5CSwipe" updateExisting:TRUE error:&error];
    }
    else
    {
        [STKeychain deleteItemForUsername:username andServiceName:@"5CSwipe" error:&error];
    }
    
    
    NSString *javascript = [NSString stringWithFormat: @"document.getElementById('loginphrase').value='%@';" "document.getElementById('password').value='%@';" "document.getElementsByTagName('input')[0].click();" "document.getElementsByTagName('input')[6].click();", self.idInput.text, self.passwordInput.text];
    [self.webView stringByEvaluatingJavaScriptFromString:javascript];
    
}

-(void) webViewDidFinishLoad:(UIWebView *)webView
{
    
    //Has fully loaded, do whatever you want here
    self.webView.scrollView.contentOffset = CGPointMake(100, 100);
    self.loginButton.enabled = YES;
    NSString *currentURL = [self.webView stringByEvaluatingJavaScriptFromString:@"window.location.href"];
    NSLog(@"%@", currentURL);
    if ([currentURL rangeOfString:@"https://cards.cuc.claremont.edu/login.php"].location == NSNotFound)
    {
        NSString *html = [webView stringByEvaluatingJavaScriptFromString: @"document.body.innerHTML"];
        flexTable = [webView stringByEvaluatingJavaScriptFromString: @"document.getElementsByTagName('table')[7].getElementsByTagName('table')[3].outerHTML;"];
        claremontCashTable = [webView stringByEvaluatingJavaScriptFromString: @"document.getElementsByTagName('table')[7].getElementsByTagName('table')[4].outerHTML;"];
        mealsTable = [webView stringByEvaluatingJavaScriptFromString: @"document.getElementsByTagName('table')[7].getElementsByTagName('table')[5].outerHTML;"];
        NSRange flexStartRange = [self rangeOfString:@"Current Balance: " inString:html atOccurence:1];
        NSRange claremontCashStartRange = [self rangeOfString:@"Current Balance: " inString:html atOccurence:2];
        NSRange mealsEndRange = [self rangeOfString:@"</td>\n</tr>\n</tbody></table>\n<a" inString:html atOccurence:1];
        NSRange flexEndRange = [self rangeOfString:@"</b>" inString:html atOccurence:2];
        NSRange claremontCashEndRange = [self rangeOfString:@"</b>" inString:html atOccurence:3];
        NSRange flexRange = NSMakeRange(flexStartRange.location + 17, flexEndRange.location - (flexStartRange.location + 17));
        NSRange claremontCashRange = NSMakeRange(claremontCashStartRange.location + 17, claremontCashEndRange.location - (claremontCashStartRange.location + 17));
        NSRange mealsRange = NSMakeRange(mealsEndRange.location - 2, 2);
        flexBalance = [html substringWithRange:flexRange];
        claremontCashBalance = [html substringWithRange:claremontCashRange];
        NSString *mealsBalanceTemp = [html substringWithRange:mealsRange];
        mealsBalance = [mealsBalanceTemp stringByReplacingOccurrencesOfString:@"[^0-9]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [mealsBalanceTemp length])];
        
        NSURL *websiteUrl = [NSURL URLWithString:@"https://cards.cuc.claremont.edu/login.php"];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
        [self.webView loadRequest:urlRequest];

        [self performSegueWithIdentifier:@"showTableView" sender:self];
    }
    else {
        NSString *wrongHtml = [webView stringByEvaluatingJavaScriptFromString: @"document.body.innerHTML"];
        if ([wrongHtml rangeOfString:@"Invalid login"].location != NSNotFound)
        {
            self.incorrectLabel.hidden = NO;
        }
        else
        {
            self.incorrectLabel.hidden = YES;
        }
    }
}

- (NSRange)rangeOfString:(NSString *)substring
                inString:(NSString *)string
             atOccurence:(int)occurence
{
    int currentOccurence = 0;
    NSRange rangeToSearchWithin = NSMakeRange(0, string.length);
    
    while (YES)
    {
        currentOccurence++;
        NSRange searchResult = [string rangeOfString: substring
                                             options: 0
                                               range: rangeToSearchWithin];
        
        if (searchResult.location == NSNotFound)
        {
            return searchResult;
        }
        if (currentOccurence == occurence)
        {
            return searchResult;
        }
        
        NSUInteger newLocationToStartAt = searchResult.location + searchResult.length;
        rangeToSearchWithin = NSMakeRange(newLocationToStartAt, string.length - newLocationToStartAt);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)checkButtonTapped:(UIButton*)sender {
    if([sender isSelected]){
        self.check.hidden = YES;
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:@"Forget" forKey:@"rememberState"];
        [prefs synchronize];
        [sender setSelected:NO];
    }
    else
    {
        self.check.hidden = NO;
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:@"Remember" forKey:@"rememberState"];
        [prefs synchronize];
        [sender setSelected:YES];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showTableView"]) {
        ViewController *tableViewController = segue.destinationViewController;
        tableViewController.flex = flexBalance;
        tableViewController.claremontCash = claremontCashBalance;
        tableViewController.meals = mealsBalance;
        tableViewController.flexHTML = flexTable;
        tableViewController.claremontCashHTML = claremontCashTable;
        tableViewController.mealsHTML = mealsTable;
    }
}

@end
