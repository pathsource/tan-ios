//
//  PSFormatter.h
//  bole
//
//  Created by Zhe Sheng on 8/2/14.
//  Copyright (c) 2014 Path Source. All rights reserved.
//
// no instace, all class methods

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface PSFormatter : NSObject

// colors
+ (UIColor *)colorRandom;

+ (UIColor*)colorFromRGB:(NSInteger)RGB;/**< never use it outside of PSFormatter.m without permission (forbid abuse usage) */
+ (UIColor*)colorFromRGB:(NSInteger)RGB withAlpha:(CGFloat)alpha;/**< never use it outside of PSFormatter.m without permission (forbid abuse usage) */

+ (UIColor*)colorOrange;
+ (UIColor*)colorBlue;
+ (UIColor*)colorBlueCrystal;
+ (UIColor*)colorBlueLogo;
+ (UIColor*)colorGreen;
+ (UIColor*)colorTextDark;
+ (UIColor*)colorTextMedium;
+ (UIColor*)colorTextLight;
+ (UIColor*)colorGreyInvalid;
+ (UIColor*)colorLineLight;
+ (UIColor*)colorBGDim;
+ (UIColor*)colorBGLight;
+ (UIColor*)colorProgressFront;
+ (UIColor*)colorProgressMiddle;
+ (UIColor*)colorCellInterlance;
+ (UIColor*)colorCareerAssessmentCategory:(NSInteger)categoryIndex;
+ (UIColor*)colorCareerRecommendMatchLevel:(NSInteger)level;
+ (UIColor*)colorLifestyleAssessmentCategory:(NSInteger)categoryIndex;
+ (UIColor*)colorSideBarBg;
+ (UIColor*)colorSideBarCellTextColor;
+ (UIColor*)sideBarCellSelectedColor;
+ (UIColor*)colorSideBarSearchBarColor;
+ (UIColor*)colorbVideoCatseparator;
+ (UIColor*)colorShareBg;
+ (UIColor*)colorDarker:(UIColor*)color withRatio:(CGFloat)ratio;

// fonts
+ (UIFont*)fontGaint;
+ (UIFont*)fontHuge;
+ (UIFont*)fontLarge;
+ (UIFont*)fontMedium;
+ (UIFont*)fontSmall;
+ (UIFont*)fontHuge_adaptable;
+ (UIFont*)fontLarge_adaptable;
+ (UIFont*)fontMedium_adaptable;
+ (UIFont*)fontSmall_adaptable;

// size
+ (CGFloat)heightForText:(NSString*)text withFixedWidth:(CGFloat)width withFont:(UIFont*)font;
+ (CGFloat)widthForOneLineText:(NSString*)text withFont:(UIFont*)font;
+ (CGFloat)cellHeight_adaptable;
+ (CGFloat)buttonHeight_adaptable;

// string format
+ (NSAttributedString*)formatAttributedTitle:(NSString*)title font:(UIFont*)font ofColor:(UIColor*)color;
+ (NSAttributedString*)formatAttributedTitle:(NSString*)title font1:(UIFont*)font1 ofColor:(UIColor*)color1 font2:(UIFont*)font2 ofColor:(UIColor*)color2 dividedBy:(NSString*)divider includeDividerInHead:(BOOL)includeDivider;
+ (NSString*)formatInteger:(NSInteger)integer;
+ (NSString*)formatDouble:(double)doubleNum;
+ (NSString*)formatDouble:(double)doubleNum maximumFractionDigits:(NSUInteger)maximumFractionDigits;
+ (NSString*)formatDistance:(double)m;
+ (NSString*)formatArray:(NSArray*)array;
+ (NSString*)formatMoneyIntegerWithDollarSign:(NSInteger)money;
+ (NSString*)formatMoneyStringWithDollarSign:(NSString*)money;
+ (NSString*)formatDate:(NSDate*)date style:(NSDateFormatterStyle)style;
+ (NSString*)formatDate:(NSDate*)date withFormat:(NSString*)dateFormat; // dateFormat: e.g @"MMMd", @"hh:mm a"


@end
