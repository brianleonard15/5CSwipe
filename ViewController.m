//
//  ViewController.m
//  5CSwipe
//
//  Created by Brian on 4/16/14.
//  Copyright (c) 2014 Brian Leonard. All rights reserved.
//

#import "ViewController.h"

#define FONT_CANDICE(s) [UIFont fontWithName:@"Candice" size:s]

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"background.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
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
    
    self.flexButton.alpha = .7;
    self.claremontCashButton.alpha = .7;
    self.mealsButton.alpha = .7;
    
    self.flexLabel.text = self.flex;
    self.claremontCashLabel.text = self.claremontCash;
    self.mealsLabel.text = self.meals;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)logoutButton:(UIButton *)sender {
     [[self navigationController] popViewControllerAnimated:YES];
}
- (IBAction)flexButtonPressed:(UIButton *)sender {
}

- (IBAction)claremontCashButtonPressed:(UIButton *)sender {
}

- (IBAction)mealsButtonPressed:(UIButton *)sender {
}
@end
