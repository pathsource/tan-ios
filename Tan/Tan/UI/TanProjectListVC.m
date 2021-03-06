//
//  TanProjectListVC.m
//  Tan
//
//  Created by Vincent Zhang on 10/24/15.
//  Copyright © 2015 Vincent Zhang. All rights reserved.
//

#import "TanProjectListVC.h"
#import "ZLSwipeableView.h"
#import "TanProjectCardView.h"
#import "TanDefinition.h"
#import "TanProjectDetailVC.h"

 NSString * const cycling = @"cycling";
 NSString * const walking = @"walking";
 NSString * const vehicle = @"vehicle";

@interface TanProjectListVC ()<ZLSwipeableViewDataSource,
ZLSwipeableViewDelegate>
{
    
    __weak IBOutlet UIButton *locationButton;
    
    __weak IBOutlet UIButton *cyclingButton;
    __weak IBOutlet UIButton *walkingButton;
    __weak IBOutlet UIButton *drivingButton;
    
    
    __weak IBOutlet UIButton *mapButton;
    
    __weak IBOutlet UILabel *addressLabel;
    __weak IBOutlet UILabel *desLabel;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet ZLSwipeableView *swipeCardsView;
@property (readonly,nonatomic) NSArray *projects;
@end

@implementation TanProjectListVC
{
    NSUInteger currentIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    switch ([TANDataCenter dataCenter].type) {
        case TANTypeWalk:
            [self walkingButtonAction:walkingButton];
            break;
        case TANTypeCycling:
            [self cyclingButtonAction:cyclingButton];
            break;
        case TANTypeVehicle:
            [self drivingButtonAction:drivingButton];
            break;
            
        default:
            break;
    }
    
    self.swipeCardsView.delegate= self;
    self.swipeCardsView.dataSource = self;
    
    desLabel.textColor = [UIColor whiteColor];
    desLabel.font = [UIFont systemFontOfSize:18];
    desLabel.text = @"选择一个你想去的地方";
    
    addressLabel.textColor = [UIColor darkGrayColor];
    addressLabel.font = [UIFont systemFontOfSize:16];
    
    self.navigationController.navigationBarHidden = YES;
    
    currentIndex = self.projects.count - 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark ====== Getter ======
- (NSArray *)projects
{
    return [TANDataCenter dataCenter].projects;
}

#pragma mark - ZLSwipeableViewDelegate

- (void)swipeableView:(ZLSwipeableView *)swipeableView
         didSwipeView:(UIView *)view
          inDirection:(ZLSwipeableViewDirection)direction {
    NSLog(@"did swipe in direction: %zd", direction);
    
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
       didCancelSwipe:(UIView *)view {
    NSLog(@"did cancel swipe");
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
  didStartSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
    NSLog(@"did start swiping at location: x %f, y %f", location.x, location.y);
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
          swipingView:(UIView *)view
           atLocation:(CGPoint)location
          translation:(CGPoint)translation {
    NSLog(@"swiping at location: x %f, y %f, translation: x %f, y %f",
          location.x, location.y, translation.x, translation.y);
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
    didEndSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
    NSLog(@"did end swiping at location: x %f, y %f", location.x, location.y);
}

#pragma mark - ZLSwipeableViewDataSource

- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
    
    currentIndex ++;
    if (currentIndex == self.projects.count) {
        currentIndex = 0;
    }
    
    TanProjectCardView *cardView =
    [[[NSBundle mainBundle] loadNibNamed:@"TanProjectCardView"
                                   owner:self
                                 options:nil] objectAtIndex:0];
    cardView.frame = self.swipeCardsView.bounds;
    cardView.project = self.projects[currentIndex];
    
    addressLabel.text = [(TanProjectCardView *)swipeableView.topSwipeableView project].address;

    [cardView selectedCardHandler:^(id sender) {
        
        [TANDataCenter dataCenter].tanProject = cardView.project;
        
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TanProjectDetailVC * detailVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"TanProjectDetailVC"];
        [self.navigationController pushViewController:detailVC animated:YES];
        
    }];
    
    return cardView;
}

#pragma mark ====== ButtonAction ======
- (IBAction)locationButtonAction:(id)sender {
    
}

- (IBAction)cyclingButtonAction:(id)sender {
    [cyclingButton setImage:[TANDataCenter selectedImage:cycling] forState:UIControlStateNormal];
    [walkingButton setImage:[TANDataCenter unSelectedImage:walking] forState:UIControlStateNormal];
    [drivingButton setImage:[TANDataCenter unSelectedImage:vehicle] forState:UIControlStateNormal];
}

- (IBAction)walkingButtonAction:(id)sender {
    [walkingButton setImage:[TANDataCenter selectedImage:walking] forState:UIControlStateNormal];
    [cyclingButton setImage:[TANDataCenter unSelectedImage:cycling] forState:UIControlStateNormal];
    [drivingButton setImage:[TANDataCenter unSelectedImage:vehicle] forState:UIControlStateNormal];
}

- (IBAction)drivingButtonAction:(id)sender {
    [drivingButton setImage:[TANDataCenter selectedImage:vehicle] forState:UIControlStateNormal];
     [cyclingButton setImage:[TANDataCenter unSelectedImage:cycling] forState:UIControlStateNormal];
     [walkingButton setImage:[TANDataCenter unSelectedImage:walking] forState:UIControlStateNormal];
}

- (IBAction)mapButtonAction:(id)sender {
}



@end
