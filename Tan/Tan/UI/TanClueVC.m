//
//  TanClueVC.m
//  Tan
//
//  Created by Vincent Zhang on 10/24/15.
//  Copyright © 2015 Vincent Zhang. All rights reserved.
//

#import "TanClueVC.h"
#import "TANQRViewController.h"
#import "TANDataCenter.h"

@interface TanClueVC() <TANDataCenterDelegate, TANQRViewControllerDelegate>
{
    
}
@end

@implementation TanClueVC

- (void)viewDidLoad{
    [super viewDidLoad];
    NSString *originStr = @"子龙背后";
    NSData* originData = [originStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString* encodeResult = [originData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSLog(@"encodeResult:%@",encodeResult);
}

#pragma mark IB Action

- (IBAction)scanClick:(id)sender {
    TANQRViewController *vc = [[TANQRViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark TANDataCenterDelegate

#pragma mark TANQRViewControllerDelegate
- (void)qrResult:(NSString*)result
{
    [TANDataCenter dataCenter].delegate = self;
    [[TANDataCenter dataCenter] startValidateAnswer:@(2) withAnswer:result];
}

@end
