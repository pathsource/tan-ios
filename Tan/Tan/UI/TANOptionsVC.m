//
//  ViewController.m
//  Tan
//
//  Created by Vincent Zhang on 10/24/15.
//  Copyright © 2015 Vincent Zhang. All rights reserved.
//

#import "TANOptionsVC.h"
#import "TANDataCenter.h"
#import "TANLocation.h"

@interface TANOptionsVC () <TANLocationDelegate>
@property (weak, nonatomic) IBOutlet UIButton *walkingButton;
@property (weak, nonatomic) IBOutlet UIButton *vehicleButton;
@property (weak, nonatomic) IBOutlet UIButton *cyclingButton;
@end

@implementation TANOptionsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationController.navigationBarHidden = YES;
    
    [TANLocation share].delegate = self;
    [[TANLocation share] startGetLocation];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetProject:) name:TANDidGetProjectNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didGetProject:(NSNotification *)not
{
    if (not != nil) {
        
        
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

#pragma mark TANLocationDelegate
- (void)getLocation:(NSArray*)coordinates
{
    [[TANDataCenter dataCenter] startFetchProjects:coordinates];
}

#pragma mark ====== button actions ======
- (IBAction)walkingButtonAction:(id)sender {
    [TANDataCenter dataCenter].type = TANTypeWalk;
}

- (IBAction)cyclingButtonAction:(id)sender {
    [TANDataCenter dataCenter].type = TANTypeCycling;
}

- (IBAction)vehicleButtonAction:(id)sender {
    [TANDataCenter dataCenter].type = TANTypeVehicle;
}

#pragma mark === UIViewControllerTransitioningDelegate


@end
