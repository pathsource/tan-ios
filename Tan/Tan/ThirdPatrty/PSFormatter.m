//
//  PSFormatter.m
//  bole
//
//  Created by Zhe Sheng on 8/2/14.
//  Copyright (c) 2014 Path Source. All rights reserved.
//

#import "PSFormatter.h"
#import "SDiPhoneVersion.h"
#import "PSDataBase.h"
#import "UIFont+PSFont.h"

// color related
static const NSInteger rgbOrange = 0xf1583c;
static const NSInteger rgbBlue = 0x00b7ee;
static const NSInteger rgbBlueLogo = 0x04396c;
static const NSInteger rgbBlueCrystal = 0xC9F3FE;
static const NSInteger rgbGreen = 0x2ba136;
static const NSInteger rgbTextDark = 0x333333;
static const NSInteger rgbTextMedium = 0x666666;
static const NSInteger rgbTextLight = 0x999999;
static const NSInteger rgbGreyInvalid = 0xbbbbbb;
static const NSInteger rgbLineLight = 0xdcdcdc;
static const NSInteger rgbBGDim = 0xe6e6e6;
static const NSInteger rgbBGLight = 0xf8f8f8; // filter / sort bar
static const NSInteger rgbProgressFront = 0xfc686c;
static const NSInteger rgbProgressMiddle = 0xfdc053;
static const NSInteger rgbCellInterlance = 0xebf9fe; // table list adjance cells
static const NSInteger rgbCareerAssessmentCategory1 = rgbBlue;
static const NSInteger rgbCareerAssessmentCategory2 = rgbBlue;
static const NSInteger rgbCareerAssessmentCategory3 = rgbBlue;
static const NSInteger rgbCareerAssessmentCategory4 = rgbBlue;
static const NSInteger rgbCareerAssessmentCategory5 = rgbBlue;
static const NSInteger rgbCareerAssessmentCategory6 = rgbBlue;
static const NSInteger rgbCareerAssessmentCategoryDefault = rgbBlue;
static const NSInteger rgbCareerRecommendMatchRatio1 = 0xfc0101;
static const NSInteger rgbCareerRecommendMatchRatio2 = 0xf36100;
static const NSInteger rgbCareerRecommendMatchRatio3 = 0xf39800;
static const NSInteger rgbCareerRecommendMatchRatio4 = 0x218203;
static const NSInteger rgbCareerRecommendMatchRatioDefault = 0xfc0101;
static const NSInteger rgbLifestyleAssessmentCategory1 = 0x69b8e3;
static const NSInteger rgbLifestyleAssessmentCategory2 = 0xf1583c;
static const NSInteger rgbLifestyleAssessmentCategory3 = 0xfbb678;
static const NSInteger rgbLifestyleAssessmentCategory4 = 0x394f80;
static const NSInteger rgbLifestyleAssessmentCategory5 = 0xe9a89c; // clothes
static const NSInteger rgbLifestyleAssessmentCategory6 = 0x36ab6e;
static const NSInteger rgbLifestyleAssessmentCategory7 = 0x00b7ee;
static const NSInteger rgbLifestyleAssessmentCategory8 = 0xfc8629;
static const NSInteger rgbLifestyleAssessmentCategory9 = 0x9d8ea5; // edu
static const NSInteger rgbLifestyleAssessmentCategory10 = 0xb0e02a;
static const NSInteger rgbLifestyleAssessmentCategoryDefault = 0x13b5b1;
static const NSInteger rgbSideBarBg = 0x2e3740;
static const NSInteger rgbSideBarCellTextColor = 0x868c90;
static const NSInteger rgbSideBarSearchBarColor = 0x636970;
static const NSInteger rgbVideoCatseparatorColor = 0x232a30;
static const NSInteger rgbShareBgColor = 0xe6f9ff;

// font releated
static const CGFloat fontSizeGiant = 24;
static const CGFloat fontSizeHuge = 18;
static const CGFloat fontSizeLarge = 16;
static const CGFloat fontSizeMedium = 14;
static const CGFloat fontSizeSmall = 12;


// sizes
static const CGFloat baseCellHeight = 46;
static const CGFloat baseButtonHeight = 40;
static const CGFloat deltaHeight = 8;

@implementation PSFormatter

#pragma mark -
#pragma mark ======== text ========

+ (CGFloat)heightForText:(NSString*)text withFixedWidth:(CGFloat)width withFont:(UIFont*)font
{
    // input check, the default will contain 2 lines if it is empty
    if (nil == text) text = @"";
    if (nil == font) font = [PSFormatter fontMedium];
    
    CGFloat height = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:font}
                                        context:nil].size.height;
    
    // make the size of the rect as integers
    return (CGFloat)(ceil((double)height));
}

+ (CGFloat)widthForOneLineText:(NSString*)text withFont:(UIFont*)font
{
    // input check, the default will contain 2 lines if it is empty
    if (nil == text) text = @"";
    
    CGFloat width = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:font}
                                       context:nil].size.width;
    
    // make the size of the rect as integers
    return (CGFloat)(ceil((double)width));
}

+ (NSAttributedString*)formatAttributedTitle:(NSString*)title font:(UIFont*)font ofColor:(UIColor*)color
{
    if (nil != title) {
        return [[NSAttributedString alloc] initWithString:title
                                               attributes:@{NSFontAttributeName : font,
                                                            NSForegroundColorAttributeName : color}];
    }
    
    return nil;
}

+ (NSAttributedString*)formatAttributedTitle:(NSString*)title font1:(UIFont*)font1 ofColor:(UIColor*)color1 font2:(UIFont*)font2 ofColor:(UIColor*)color2 dividedBy:(NSString*)divider includeDividerInHead:(BOOL)includeDivider;
{
    NSRange semicolumnRange = [title rangeOfString:divider];
    if (nil != divider && NSNotFound != semicolumnRange.location) {
        NSUInteger location = semicolumnRange.location;
        if (includeDivider) location += [divider length];
        
        // if there are 2 parts
        NSMutableAttributedString* str1 = [[NSMutableAttributedString alloc] initWithString:[title substringToIndex:location]
                                                                                 attributes:@{NSFontAttributeName : font1,
                                                                                              NSForegroundColorAttributeName : color1} ];
        NSMutableAttributedString* str2 = [[NSMutableAttributedString alloc] initWithString:[title substringFromIndex:location]
                                                                                 attributes:@{NSFontAttributeName : font2,
                                                                                              NSForegroundColorAttributeName : color2} ];
        // joint the 2 parts
        [str1 appendAttributedString:str2];
        return str1;
    } else {
        // if only one part
        return [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName : font1,
                                                                             NSForegroundColorAttributeName : color1}];
    }
    
    return nil;
}


#pragma mark -
#pragma mark ======== color and font ========
+ (UIColor *)colorRandom {
    //http://nshipster.com/random/
    NSInteger r = arc4random_uniform(256) % 256;
    NSInteger g = arc4random_uniform(256) % 256;
    NSInteger b = arc4random_uniform(256) % 256;
    return [self colorFromRGB:r*256*256+g*256+b];
}

+ (UIColor*) colorFromRGB:(NSInteger)RGB
{
    return [UIColor colorWithRed:((CGFloat)((RGB&0xFF0000) >> 16))/255.0
                           green:((CGFloat)((RGB&0x00FF00) >> 8))/255.0
                            blue:((CGFloat)((RGB&0x0000FF)))/255.0
                           alpha:(CGFloat)1.0];
}

+ (UIColor*) colorFromRGB:(NSInteger)RGB withAlpha:(CGFloat)alpha
{
    if (alpha < 0.0) alpha = 0.0;
    if (alpha > 1.0) alpha = 1.0;
    
    return [UIColor colorWithRed:((CGFloat)((RGB&0xFF0000) >> 16))/255.0
                           green:((CGFloat)((RGB&0x00FF00) >> 8))/255.0
                            blue:((CGFloat)((RGB&0x0000FF)))/255.0
                           alpha:(CGFloat)alpha];
}

+ (UIColor*)colorOrange
{
    return [PSFormatter colorFromRGB:rgbOrange];
}

+ (UIColor*)colorBlue
{
    return [PSFormatter colorFromRGB:rgbBlue];
}

+ (UIColor*)colorBlueLogo
{
    return [PSFormatter colorFromRGB:rgbBlueLogo];
}

+ (UIColor*)colorBlueCrystal
{
    return [PSFormatter colorFromRGB:rgbBlueCrystal];
}

+ (UIColor*)colorGreen
{
    return [PSFormatter colorFromRGB:rgbGreen];
}

+ (UIColor*)colorTextDark
{
    return [PSFormatter colorFromRGB:rgbTextDark];
}

+ (UIColor*)colorTextMedium
{
    return [PSFormatter colorFromRGB:rgbTextMedium];
}

+ (UIColor*)colorTextLight
{
    return [PSFormatter colorFromRGB:rgbTextLight];
}

+ (UIColor*)colorGreyInvalid
{
    return [PSFormatter colorFromRGB:rgbGreyInvalid];
}

+ (UIColor*)colorLineLight
{
    return [PSFormatter colorFromRGB:rgbLineLight];
}

+ (UIColor*)colorBGDim
{
    return [PSFormatter colorFromRGB:rgbBGDim];
}

+ (UIColor*)colorBGLight
{
    return [PSFormatter colorFromRGB:rgbBGLight];
}

+ (UIColor*)colorProgressFront
{
    return [PSFormatter colorFromRGB:rgbProgressFront];
}

+ (UIColor*)colorProgressMiddle
{
    return [PSFormatter colorFromRGB:rgbProgressMiddle];
}

+ (UIColor*)colorCellInterlance
{
    return [PSFormatter colorFromRGB:rgbCellInterlance];
}

// NOTE: category starts from 1
+ (UIColor*)colorCareerAssessmentCategory:(NSInteger)categoryIndex
{
    switch (categoryIndex) {
        case 1: {
            return [PSFormatter colorFromRGB:rgbCareerAssessmentCategory1];
        }
            break;
            
        case 2: {
            return [PSFormatter colorFromRGB:rgbCareerAssessmentCategory2];
        }
            break;
            
        case 3: {
            return [PSFormatter colorFromRGB:rgbCareerAssessmentCategory3];
        }
            break;
            
        case 4: {
            return [PSFormatter colorFromRGB:rgbCareerAssessmentCategory4];
        }
            break;
            
        case 5: {
            return [PSFormatter colorFromRGB:rgbCareerAssessmentCategory5];
        }
            break;
            
        case 6: {
            return [PSFormatter colorFromRGB:rgbCareerAssessmentCategory6];
        }
            break;
            
        default:
            break;
    }
    
    return [PSFormatter colorFromRGB:rgbCareerAssessmentCategoryDefault];
}

// NOTE: category starts from 0
+ (UIColor*)colorCareerRecommendMatchLevel:(NSInteger)level
{
    switch (level) {
        case 0: {
            return [PSFormatter colorFromRGB:rgbCareerRecommendMatchRatio1];
        }
            break;
            
        case 1: {
            return [PSFormatter colorFromRGB:rgbCareerRecommendMatchRatio2];
        }
            break;
            
        case 2: {
            return [PSFormatter colorFromRGB:rgbCareerRecommendMatchRatio3];
        }
            break;
            
        case 3: {
            return [PSFormatter colorFromRGB:rgbCareerRecommendMatchRatio4];
        }
            break;
            
        default:
            break;
    }

    return [PSFormatter colorFromRGB:rgbCareerRecommendMatchRatioDefault];
}


// NOTE: category starts from 1
+ (UIColor*)colorLifestyleAssessmentCategory:(NSInteger)categoryIndex
{
    switch (categoryIndex) {
        case 1: {
            return [PSFormatter colorFromRGB:rgbLifestyleAssessmentCategory1];
        }
            break;
            
        case 2: {
            return [PSFormatter colorFromRGB:rgbLifestyleAssessmentCategory2];
        }
            break;
            
        case 3: {
            return [PSFormatter colorFromRGB:rgbLifestyleAssessmentCategory3];
        }
            break;
            
        case 4: {
            return [PSFormatter colorFromRGB:rgbLifestyleAssessmentCategory4];
        }
            break;
            
        case 5: {
            return [PSFormatter colorFromRGB:rgbLifestyleAssessmentCategory5];
        }
            break;
            
        case 6: {
            return [PSFormatter colorFromRGB:rgbLifestyleAssessmentCategory6];
        }
            break;
            
        case 7: {
            return [PSFormatter colorFromRGB:rgbLifestyleAssessmentCategory7];
        }
            break;
            
        case 8: {
            return [PSFormatter colorFromRGB:rgbLifestyleAssessmentCategory8];
        }
            break;
            
        case 9: {
            return [PSFormatter colorFromRGB:rgbLifestyleAssessmentCategory9];
        }
            break;
            
        case 10: {
            return [PSFormatter colorFromRGB:rgbLifestyleAssessmentCategory10];
        }
            break;
            
        default:
            break;
    }
    
    return [PSFormatter colorFromRGB:rgbLifestyleAssessmentCategoryDefault];
}

+ (UIColor*)colorSideBarBg
{
    return [PSFormatter colorFromRGB:rgbSideBarBg];
}

+ (UIColor*)colorSideBarCellTextColor
{
    return [PSFormatter colorFromRGB:rgbSideBarCellTextColor];
}

+ (UIColor*)sideBarCellSelectedColor
{
    return [PSFormatter colorFromRGB:rgbVideoCatseparatorColor];
}

+ (UIColor*)colorSideBarSearchBarColor
{
    return [PSFormatter colorFromRGB:rgbSideBarSearchBarColor];
}

+ (UIColor*)colorbVideoCatseparator
{
    return [PSFormatter colorFromRGB:rgbVideoCatseparatorColor];
}

+ (UIColor*)colorShareBg
{
    return [PSFormatter colorFromRGB:rgbShareBgColor];
}



+ (UIColor*)colorDarker:(UIColor*)color withRatio:(CGFloat)ratio
{
    CGFloat red = 0, green = 0, blue = 0, alpha = 0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    return [UIColor colorWithRed:red*ratio green:green*ratio blue:blue*ratio alpha:alpha];
}


#pragma mark -

+ (UIFont*)fontGaint
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSizeGiant];
}

+ (UIFont*)fontHuge
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSizeHuge];
}

+ (UIFont*)fontLarge
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSizeLarge];
}

+ (UIFont*)fontMedium
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSizeMedium];
}

+ (UIFont*)fontSmall
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSizeSmall];
}

+ (UIFont*)fontHuge_adaptable
{
    if ([SDiPhoneVersion deviceSize] == iPhone35inch) {
        return [PSFormatter fontHuge];
    } else if ([SDiPhoneVersion deviceSize] == iPhone4inch) {
        return [PSFormatter fontHuge];
    } else if ([SDiPhoneVersion deviceSize] == iPhone47inch) {
        return [[PSFormatter fontHuge] largerFont];
    } else if ([SDiPhoneVersion deviceSize] == iPhone55inch) {
        return [[[PSFormatter fontHuge] largerFont] largerFont];
    }
    
    return [PSFormatter fontHuge];
}

+ (UIFont*)fontLarge_adaptable
{
    if ([SDiPhoneVersion deviceSize] == iPhone35inch) {
        return [PSFormatter fontLarge];
    } else if ([SDiPhoneVersion deviceSize] == iPhone4inch) {
        return [PSFormatter fontLarge];
    } else if ([SDiPhoneVersion deviceSize] == iPhone47inch) {
        return [[PSFormatter fontLarge] largerFont];
    } else if ([SDiPhoneVersion deviceSize] == iPhone55inch) {
        return [[[PSFormatter fontLarge] largerFont] largerFont];
    }
    
    return [PSFormatter fontLarge];
}

+ (UIFont*)fontMedium_adaptable
{
    if ([SDiPhoneVersion deviceSize] == iPhone35inch) {
        return [PSFormatter fontMedium];
    } else if ([SDiPhoneVersion deviceSize] == iPhone4inch) {
        return [PSFormatter fontMedium];
    } else if ([SDiPhoneVersion deviceSize] == iPhone47inch) {
        return [[PSFormatter fontMedium] largerFont];
    } else if ([SDiPhoneVersion deviceSize] == iPhone55inch) {
        return [[[PSFormatter fontMedium] largerFont] largerFont];
    }
    
    return [PSFormatter fontMedium];
}

+ (UIFont*)fontSmall_adaptable
{
    if ([SDiPhoneVersion deviceSize] == iPhone35inch) {
        return [PSFormatter fontSmall];
    } else if ([SDiPhoneVersion deviceSize] == iPhone4inch) {
        return [PSFormatter fontSmall];
    } else if ([SDiPhoneVersion deviceSize] == iPhone47inch) {
        return [[PSFormatter fontSmall] largerFont];
    } else if ([SDiPhoneVersion deviceSize] == iPhone55inch) {
        return [[[PSFormatter fontSmall] largerFont] largerFont];
    }
    
    return [PSFormatter fontSmall];
}



#pragma mark -

+ (CGFloat)cellHeight_adaptable
{
    if ([SDiPhoneVersion deviceSize] == iPhone35inch) {
        return baseCellHeight;
    } else if ([SDiPhoneVersion deviceSize] == iPhone4inch) {
        return baseCellHeight;
    } else if ([SDiPhoneVersion deviceSize] == iPhone47inch) {
        return baseCellHeight + deltaHeight;
    } else if ([SDiPhoneVersion deviceSize] == iPhone55inch) {
        return baseCellHeight + deltaHeight*2.0;
    }
    
    return baseCellHeight;
}

+ (CGFloat)buttonHeight_adaptable
{
    if ([SDiPhoneVersion deviceSize] == iPhone35inch) {
        return baseButtonHeight;
    } else if ([SDiPhoneVersion deviceSize] == iPhone4inch) {
        return baseButtonHeight;
    } else if ([SDiPhoneVersion deviceSize] == iPhone47inch) {
        return baseButtonHeight + deltaHeight;
    } else if ([SDiPhoneVersion deviceSize] == iPhone55inch) {
        return baseButtonHeight + deltaHeight*2.0;
    }
    
    return baseCellHeight;
}

#pragma mark -

+ (NSString*)formatInteger:(NSInteger)integer
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle]; // Here you can choose the style
    
    return [numberFormatter stringFromNumber:[NSNumber numberWithInteger:integer]];
}

+ (NSString*)formatDouble:(double)doubleNum
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle]; // Here you can choose the style
    
    return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:doubleNum]];
}

+ (NSString*)formatDouble:(double)doubleNum maximumFractionDigits:(NSUInteger)maximumFractionDigits
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle]; // Here you can choose the style
    [numberFormatter setMaximumFractionDigits:maximumFractionDigits];
    return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:doubleNum]];
}

+ (NSString*)formatDistance:(double)m
{
    if (m < 0) {
        return @"? mi";
    }
    
    // convert it to mile
    m = m / 1000.0 * 0.6214;
    NSString *formattedDistance = [PSFormatter formatDouble:m maximumFractionDigits:1];
    return [NSString stringWithFormat:@"%@ mi", formattedDistance];
}

+ (NSString*)formatArray:(NSArray*)array
{
    if (!array) return @"";
    
    return [array componentsJoinedByString:@", "];
}

+ (NSString*)formatMoneyIntegerWithDollarSign:(NSInteger)money
{
    return [NSString stringWithFormat:@"$%@", [PSFormatter formatInteger:money]];
}

+ (NSString*)formatMoneyStringWithDollarSign:(NSString*)money
{
    NSInteger moneyInteger = [PSDataBase moneyIntegerFromString:money withLimitation:0];
    return [PSFormatter formatMoneyIntegerWithDollarSign:moneyInteger];
}

+ (NSString*)formatDate:(NSDate*)date style:(NSDateFormatterStyle)style
{
    if (date && [date isKindOfClass:[NSDate class]]) {
        return [NSDateFormatter localizedStringFromDate:date dateStyle:style timeStyle:NSDateFormatterNoStyle];
    } else {
        return @"";
    }
}

+ (NSString*)formatDate:(NSDate*)date withFormat:(NSString*)dateFormat
{
    if (date && [date isKindOfClass:[NSDate class]]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:[NSDateFormatter dateFormatFromTemplate:dateFormat options:0 locale:[NSLocale currentLocale]]];
        return [dateFormatter stringFromDate:date];
    } else {
        return @"";
    }
}

@end
