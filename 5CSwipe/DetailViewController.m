//
//  DetailViewController.m
//  5CSwipe
//
//  Created by Brian on 4/21/14.
//  Copyright (c) 2014 Brian Leonard. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () {

    NSString *loadHTML;
    NSString *loadHTML2;
    NSString *path;
    NSURL *baseURL;
    
}

@end

@implementation DetailViewController

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
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"background.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    self.webView.delegate = self;
    loadHTML = [NSString stringWithFormat:@"<html> <head> <link rel='stylesheet' type='text/css'  href='style.css'> </head> <body> %@ </body> </html>", self.detailHTML];
    loadHTML2 = [NSString stringWithFormat:@"<html> <head> <link rel='stylesheet' type='text/css'  href='style2.css'> </head> <body> %@ </body> </html>", self.detailHTML];
    path = [[NSBundle mainBundle] bundlePath];
    baseURL = [NSURL fileURLWithPath:path];
    BOOL isInPortrait = UIDeviceOrientationIsPortrait([[UIDevice currentDevice] orientation]);
    if (isInPortrait)
    {
        [self.webView loadHTMLString:loadHTML baseURL:baseURL];
    }
    else
    {
        [self.webView loadHTMLString:loadHTML2 baseURL:baseURL];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.webView stringByEvaluatingJavaScriptFromString:@"document. body.style.zoom = 0.7;"];
    [self.webView setOpaque:NO];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backButton:(UIButton *)sender {
        [[self navigationController] popViewControllerAnimated:YES];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    BOOL isInPortrait = UIDeviceOrientationIsPortrait([[UIDevice currentDevice] orientation]);
    if (isInPortrait)
    {
        //[self.webView stringByEvaluatingJavaScriptFromString:@"document. body.style.zoom = 0.7;"];
        [self.webView loadHTMLString:loadHTML baseURL:baseURL];
    }
    else {
        //[self.webView stringByEvaluatingJavaScriptFromString:@"document. body.style.zoom .2;"];
        [self.webView loadHTMLString:loadHTML2 baseURL:baseURL];
    }
}
@end
