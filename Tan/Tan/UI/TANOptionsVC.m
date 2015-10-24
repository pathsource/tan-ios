//
//  ViewController.m
//  Tan
//
//  Created by Vincent Zhang on 10/24/15.
//  Copyright © 2015 Vincent Zhang. All rights reserved.
//

#import "TANOptionsVC.h"
#import "TANDataCenter.h"

@interface TANOptionsVC ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation TANOptionsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[TANDataCenter dataCenter] start];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetProject:) name:TANDidGetProjectNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didGetProject:(NSNotification *)not
{
    if (not != nil) {
        self.button.backgroundColor = [UIColor greenColor];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}
@end
