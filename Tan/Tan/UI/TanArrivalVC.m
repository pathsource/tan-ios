//
//  TanArrivalVC.m
//  Tan
//
//  Created by Vincent Zhang on 10/24/15.
//  Copyright © 2015 Vincent Zhang. All rights reserved.
//

#import "TanArrivalVC.h"
#import "TanDefinition.h"
#import "TanProjectListVC.h"

@interface TanArrivalVC()
{
    
    __weak IBOutlet UIButton *giveupButton;
    __weak IBOutlet UIButton *arrivalButton;
}
@end

@implementation TanArrivalVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    arrivalButton.backgroundColor = [UIColor colorFromRGB:0x50af37];
    [arrivalButton setTitle:@"到达" forState:UIControlStateNormal];
    
    giveupButton.backgroundColor =[UIColor colorFromRGB:0xb6b6b6];
    [giveupButton setTitle:@"放弃" forState:UIControlStateNormal];
}

- (IBAction)arrivalButtonAction:(id)sender {
    
    
    
}

- (IBAction)giveUpButtonAction:(id)sender {
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[TanProjectListVC class]]) {
            [self.navigationController popToViewController:obj animated:YES];
        }
    }];
}

@end
