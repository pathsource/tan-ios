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
#import "TanClueVC.h"
#import "TANLocation.h"
#import <HealthKit/HealthKit.h>

@interface TanArrivalVC() <TANLocationDelegate, TANDataCenterDelegate>
{
    
    __weak IBOutlet UIButton *giveupButton;
    __weak IBOutlet UIButton *arrivalButton;
    
    __weak IBOutlet UILabel *nameLabel;
    
    __weak IBOutlet UILabel *stepsLabel;
    
    __weak IBOutlet UILabel *caloriesLabel;
    
    __weak IBOutlet UILabel *donateLabel;
    
    __weak IBOutlet UILabel *donationDesLabel;
    
    __weak IBOutlet UIImageView *stepsLogo;
    
    __weak IBOutlet UIImageView *caloriesLogo;
    
    __weak IBOutlet UIImageView *donationImage;
    
    
    __weak IBOutlet UILabel *arrivelLabel;
    
    __weak IBOutlet UILabel *giveupLabel;
}
@end

@implementation TanArrivalVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    arrivalButton.backgroundColor = [UIColor colorFromRGB:0x50af37];
    [arrivalButton setTitle:@"到达 " forState:UIControlStateNormal];
 
    
    giveupButton.backgroundColor =[UIColor colorFromRGB:0xb6b6b6];
    [giveupButton setTitle:@"放弃" forState:UIControlStateNormal];
    
    arrivelLabel.text = @"开始解答谜题";
    arrivelLabel.font = [UIFont systemFontOfSize:11];
    arrivelLabel.textColor = [UIColor whiteColor];
    
    giveupLabel.text = @"回答主页面";
    giveupLabel.font = [UIFont systemFontOfSize:11];
    giveupLabel.textColor = [UIColor whiteColor];
}



- (IBAction)arrivalButtonAction:(id)sender {
    [TANLocation share].delegate = self;
    [[TANLocation share] startGetLocation];
}

- (IBAction)giveUpButtonAction:(id)sender {
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[TanProjectListVC class]]) {
            [self.navigationController popToViewController:obj animated:YES];
        }
    }];
}

#pragma mark TANLocationDelegate
- (void)getLocation:(NSArray*)coordinates
{
    [TANDataCenter dataCenter].delegate = self;
    [[TANDataCenter dataCenter] startCheckin:@(2) withCoordinates:coordinates];
}

#pragma mark TANDataCenterDelegate
- (void)checkinResult:(BOOL)success withContent:(NSString*)content andHint:(NSString*)hint
{
    if (success) {
        [self performSegueWithIdentifier:@"goClue" sender:self];
    }
}

#pragma mark Health
- (void)requestSteps {
    if (NSClassFromString(@"HKHealthStore") && [HKHealthStore isHealthDataAvailable])
    {
        // Add your HealthKit code here
        HKHealthStore *healthStore = [[HKHealthStore alloc] init];
        
        // Read date of birth, biological sex and step count etc
        NSSet *readObjectTypes  = [NSSet setWithObjects:
                                   [HKSampleType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount],
                                   nil];
        
        // Request access
        [healthStore requestAuthorizationToShareTypes:nil
                                            readTypes:readObjectTypes
                                           completion:^(BOOL success, NSError *error) {
                                               
                                               if(success == YES)
                                               {
                                                   [self getLastStep:healthStore];
                                               }
                                               else
                                               {
                                                   // Determine if it was an error or if the
                                                   // user just canceld the authorization request
                                                   //Fit_AAPLprofileviewcontroller_m.html
                                               }
                                               
                                           }];
    }
}

- (void)getLastStep: (HKHealthStore*)healthStore {
    HKQuantityType *type = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    NSDate *today = [NSDate date];
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:[today dateByAddingTimeInterval: -86400.0] endDate:today options:HKQueryOptionNone];
    HKSampleQuery    *query = [[HKSampleQuery alloc] initWithSampleType:type
                                                              predicate:predicate
                                                                  limit:HKObjectQueryNoLimit
                                                        sortDescriptors:nil
                                                         resultsHandler:^(HKSampleQuery *query, NSArray *result, NSError *error){
                                                             
                                                             if(!error && result)
                                                             {
                                                                 double totalSteps = 0;
                                                                 
                                                                 for(HKQuantitySample *quantitySample in result)
                                                                 {
                                                                     double step = [quantitySample.quantity doubleValueForUnit:([HKUnit countUnit])];
                                                                     totalSteps = totalSteps + step;
                                                                 }
                                                                 
                                                             }
                                                         }];
    [healthStore executeQuery:query];
}

@end
