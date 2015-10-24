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
}
@end

@implementation TanProjectDetailVC

- (void)viewDidLoad{
    [super viewDidLoad];

    startButton.backgroundColor = [UIColor colorFromRGB:0x3dafd8];
    [startButton setTitle:@"开始" forState:UIControlStateNormal];
}

- (void)loadDetailWithID:(NSNumber *)ID
{
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:[TANDataCenter projectDetailApi:ID]]];
    [detailWebView loadRequest:request];
}

- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)startButtonAction:(id)sender {
   
}

@end
