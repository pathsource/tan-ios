//
//  TanProjectDetail.m
//  Tan
//
//  Created by Vincent Zhang on 10/24/15.
//  Copyright © 2015 Vincent Zhang. All rights reserved.
//

#import "TanProjectDetailVC.h"
#import "TanDefinition.h"
#import "TANDataCenter.h"

@interface TanProjectDetailVC() <TANDataCenterDelegate>
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
    
    [self loadDetailWebPage];
    
    startButton.backgroundColor = [UIColor colorFromRGB:0x3dafd8];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton setTitle:@"开始" forState:UIControlStateNormal];
}

- (void)loadDetailWebPage
{
    NSNumber *ID = [TANDataCenter dataCenter].tanProject.ID;
    request = [NSURLRequest requestWithURL:[NSURL URLWithString:[TANDataCenter projectDetailApi:ID]]];
    [detailWebView loadRequest:request];
    
}

- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)startButtonAction:(id)sender {
    [TANDataCenter dataCenter].delegate = self;
    [[TANDataCenter dataCenter] startProject:@(2)];
}

#pragma mark TANDataCenterDelegate
- (void)startResult:(BOOL)success;
{
    [self performSegueWithIdentifier:@"goArrival" sender:self];
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