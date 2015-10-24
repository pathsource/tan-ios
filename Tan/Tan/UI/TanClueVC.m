//
//  TanClueVC.m
//  Tan
//
//  Created by Vincent Zhang on 10/24/15.
//  Copyright © 2015 Vincent Zhang. All rights reserved.
//

#import "TanClueVC.h"
#import "TANQRViewController.h"
#import "TanDefinition.h"
#import "TANDataCenter.h"

@interface TanClueVC() <TANDataCenterDelegate, TANQRViewControllerDelegate>
{
    
}
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *scanBtn;

@end

@implementation TanClueVC

- (void)viewDidLoad{
    [super viewDidLoad];
    
    _bgView.layer.cornerRadius = 5.0;
    _scanBtn.clipsToBounds = YES;
    
    _bgImageView.maskView = [[UIView alloc] initWithFrame:_bgImageView.bounds];
    _bgImageView.maskView.backgroundColor = [[UIColor colorFromRGB:0x3e3e3e] colorWithAlphaComponent:0.6];
    
    [_bgImageView sd_setImageWithURL:[NSURL URLWithString:[TANDataCenter dataCenter].tanProject.image]];
}

#pragma mark IB Action

- (IBAction)scanClick:(id)sender {
    TANQRViewController *vc = [[TANQRViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark TANDataCenterDelegate
- (void)validateResult:(BOOL)success
{
    [self performSegueWithIdentifier:@"goCongrat" sender:self];
}

#pragma mark TANQRViewControllerDelegate
- (void)qrResult:(NSString*)result
{
    [TANDataCenter dataCenter].delegate = self;
    [[TANDataCenter dataCenter] startValidateAnswer:@(2) withAnswer:result];
}

@end
