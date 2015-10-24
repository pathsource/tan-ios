//
//  QRViewController.h
//  QRWeiXinDemo
//
//  Created by lovelydd on 15/4/25.
//  Copyright (c) 2015年 lovelydd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TANQRViewControllerDelegate <NSObject>
- (void)qrResult:(NSString*)result;
@end

@interface TANQRViewController : UIViewController
@property (nonatomic, weak) id<TANQRViewControllerDelegate> delegate;

@end
