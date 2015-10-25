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
#import "TanProjectListVC.h"

@interface TANOptionsVC () <TANLocationDelegate>

@property (weak, nonatomic) IBOutlet UIButton *walkingButton;
@property (weak, nonatomic) IBOutlet UIButton *vehicleButton;
@property (weak, nonatomic) IBOutlet UIButton *cyclingButton;

@property (weak, nonatomic) IBOutlet UILabel *sloganLabel;

@end

@implementation TANOptionsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationController.navigationBarHidden = YES;
    
    self.sloganLabel.alpha = 0.0;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [UIView animateKeyframesWithDuration:1.5 delay:2.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        self.sloganLabel.alpha = 1.0;
    } completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didGetProject:(NSNotification *)not
{
    if (not != nil) {
        [self performSegueWithIdentifier:@"goProjectList" sender:self];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

#pragma mark TANLocationDelegate
- (void)getLocation:(NSArray*)coordinates
{
    NSString * typeName = nil;
    switch ([TANDataCenter dataCenter].type) {
        case TANTypeVehicle:
            typeName = @"driving";
            break;
        case TANTypeCycling:
            typeName = @"bicycle";
            break;
        case TANTypeWalk:
            typeName = @"walking";
            break;
            
        default:
            break;
    }
    [[TANDataCenter dataCenter] startFetchProjects:coordinates type:typeName];
}

#pragma mark ====== button actions ======
- (IBAction)walkingButtonAction:(id)sender {
    [self getProjectList:TANTypeWalk];
    
    [self.walkingButton setBackgroundImage:[TANDataCenter selectedImage:walking] forState:UIControlStateNormal];
}

- (IBAction)cyclingButtonAction:(id)sender {
    [self getProjectList:TANTypeCycling];
    
    [self.cyclingButton setBackgroundImage:[TANDataCenter selectedImage:cycling] forState:UIControlStateNormal];
}

- (IBAction)vehicleButtonAction:(id)sender {
    [self getProjectList:TANTypeVehicle];
    
    [self.vehicleButton setBackgroundImage:[TANDataCenter selectedImage:vehicle] forState:UIControlStateNormal];
}

- (void)getProjectList:(TANType)type
{
    [TANLocation share].delegate = self;
    [TANDataCenter dataCenter].type = type;
    [[TANLocation share] startGetLocation];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetProject:) name:TANDidGetProjectNotification object:nil];
}
#pragma mark === UIViewControllerTransitioningDelegate


@end
