//
//  TanProjectDetail.m
//  Tan
//
//  Created by Vincent Zhang on 10/24/15.
//  Copyright © 2015 Vincent Zhang. All rights reserved.
//

#import "TanProjectDetailVC.h"
#import "TanDefinition.h"

@interface TanProjectDetailVC()
{
    
    __weak IBOutlet UIWebView *detailWebView;
    __weak IBOutlet UIButton *startButton;
    
    __weak IBOutlet UIActivityIndicatorView *loadingIndicator;
    
}
@end

@implementation TanProjectDetailVC
{
    NSURLRequest * request;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [detailWebView loadRequest:request];
    
    startButton.backgroundColor = [UIColor colorFromRGB:0x3dafd8];
    startButton.titleLabel.textColor = [UIColor whiteColor];
    [startButton setTitle:@"开始" forState:UIControlStateNormal];
}

- (void)loadDetailWithID:(NSNumber *)ID
{
    request = [NSURLRequest requestWithURL:[NSURL URLWithString:[TANDataCenter projectDetailApi:ID]]];
    
}

- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)startButtonAction:(id)sender {
    
}

#pragma mark ====== UIWebViewDelegate ======

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [loadingIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [loadingIndicator stopAnimating];
    loadingIndicator.hidden = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    [loadingIndicator stopAnimating];
    loadingIndicator.hidden = YES;
}
@end