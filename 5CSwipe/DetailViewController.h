//
//  DetailViewController.h
//  5CSwipe
//
//  Created by Brian on 4/21/14.
//  Copyright (c) 2014 Brian Leonard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UIWebViewDelegate>

- (IBAction)backButton:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) NSString *detailHTML;
@property (nonatomic, strong) NSString *typePressed;
@end
