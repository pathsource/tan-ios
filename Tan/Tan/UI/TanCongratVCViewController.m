//
//  TanCongratVCViewController.m
//  Tan
//
//  Created by ChenNathan on 15/10/25.
//  Copyright © 2015年 Vincent Zhang. All rights reserved.
//

#import "TanCongratVCViewController.h"
#import "TanDefinition.h"
#import "TANDataCenter.h"

@interface TanCongratVCViewController ()
{
    __weak IBOutlet UIActivityIndicatorView *loadingIndicator;
        NSURLRequest * requestUrl;
}
@end

@implementation TanCongratVCViewController

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLayoutSubviews
{
    [self loadDetailWebPage];
}

#pragma mark

- (void)loadDetailWebPage
{
    NSNumber *ID = [TANDataCenter dataCenter].tanProject.ID;
    requestUrl = [NSURLRequest requestWithURL:[NSURL URLWithString:[TANDataCenter projectCongratApi:ID]]];
    [self.webView loadRequest:requestUrl];
}

#pragma mark ====== UIWebViewDelegate ======
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([request.URL.absoluteString hasSuffix:@"recommend"]) {
        [self openShareActivityViewWith:@"我参与了1024 Hackathon，探索黑客心灵之旅。" sender:self];
        return false;
    }
    if ([request.URL.absoluteString hasSuffix:@"frontpage"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        return false;
    }
    return YES;
}
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

#pragma mark -
#pragma mark ======== Share ========

-(void)openShareActivityViewWith:(NSString *)message sender:(id)sender
{
    //Create an activity view controller with the url container as its activity item. APLCustomURLContainer conforms to the UIActivityItemSource protocol.
    NSArray* arrayItems = @[message];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:arrayItems applicationActivities:nil];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        //iPhone, present activity view controller as is
        [self presentViewController:activityViewController animated:YES completion:nil];
    } else {
        UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:activityViewController];
        [popup presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
    
    activityViewController.completionWithItemsHandler = ^(NSString* activityType, BOOL completed, NSArray* returnedItems, NSError* activityError) {
        if (completed) {
            NSLog(@"The selected activity was %@", activityType);
        }
    };
}

@end
