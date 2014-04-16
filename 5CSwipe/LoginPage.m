//
//  LoginPage.m
//  Claremont Card
//
//  Created by Brian on 4/15/14.
//  Copyright (c) 2014 Brian Leonard. All rights reserved.
//

#import "LoginPage.h"
#import "ViewController.h"

@interface LoginPage () {
    
int numberFinishes;
NSString *flexBalance;
NSString *claremontCashBalance;
NSString *mealsBalance;
    
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
    numberFinishes = 0;
    self.idInput.delegate = self;
    self.passwordInput.delegate = self;
    self.webView.hidden = YES;
    self.webView.delegate = self;
    NSURL *websiteUrl = [NSURL URLWithString:@"https://cards.cuc.claremont.edu"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    [self.webView loadRequest:urlRequest];


    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)buttonPress:(id)sender
{
    NSString *javascript = [NSString stringWithFormat: @"document.getElementById('quickloginphrase').value='%@';" "document.getElementById('quickpassword').value='%@';" "document.getElementsByTagName('input')[4].click();", self.idInput.text, self.passwordInput.text];
    //[self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('quickloginphrase').value='40155049';" "document.getElementById('quickpassword').value='47238d7d';" "document.getElementsByTagName('input')[4].click();"];
    [self.webView stringByEvaluatingJavaScriptFromString:javascript];
    
}

-(void) webViewDidFinishLoad:(UIWebView *)webView
{
    //NSString *javaScript = @"function myFunction(){return 1+1;}";
    //[webView stringByEvaluatingJavaScriptFromString:javaScript];
    
    //Has fully loaded, do whatever you want here
    ++ numberFinishes;
    if (numberFinishes > 3) {
        NSString *html = [webView stringByEvaluatingJavaScriptFromString: @"document.body.innerHTML"];
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
        NSLog(@"Flex: %@, Claremont Cash: %@, Meals: %@", flexBalance, claremontCashBalance, mealsBalance);
        [self performSegueWithIdentifier:@"showTableView" sender:self];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showTableView"]) {
        ViewController *tableViewController = segue.destinationViewController;
        tableViewController.flex = flexBalance;
        tableViewController.claremontCash = claremontCashBalance;
        tableViewController.meals = mealsBalance;
    }
}


@end
