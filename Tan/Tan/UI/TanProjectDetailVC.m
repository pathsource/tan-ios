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
}
@end

@implementation TanProjectDetailVC

- (void)loadDetailWithID:(NSNumber *)ID
{
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:[TANDataCenter projectDetailApi:ID]]];
    [detailWebView loadRequest:request];
}
@end
