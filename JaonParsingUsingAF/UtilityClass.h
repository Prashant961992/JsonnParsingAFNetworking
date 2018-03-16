//
//  UtilityClass.h
//  People Shop
//
//  Created by Arvaan on 08/03/16.
//  Copyright © 2016 Pooja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
//#import <Reachability/Reachability.h>
//#import "Reachability.h"


#define IS_IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
#define SYSTEM_VERSION_EQUAL_TO(v)                                             \
([[[UIDevice currentDevice] systemVersion] compare:v                         \
options:NSNumericSearch] ==       \
NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)                                         \
([[[UIDevice currentDevice] systemVersion] compare:v                         \
options:NSNumericSearch] ==       \
NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)                             \
([[[UIDevice currentDevice] systemVersion] compare:v                         \
options:NSNumericSearch] !=       \
NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                                            \
([[[UIDevice currentDevice] systemVersion] compare:v                         \
options:NSNumericSearch] ==       \
NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)                                \
([[[UIDevice currentDevice] systemVersion] compare:v                         \
options:NSNumericSearch] !=       \
NSOrderedDescending)

@interface UtilityClass : NSObject

+(NSString *)getCurrentSystemLanguage;

+(BOOL)isLogin;
+(NSString *)valueForKey:(NSString *)String;
+(void)removeForKey:(NSString *)String;

+(void)ShowAnimation:(UIView *)view;

+(BOOL)validateEmailWithString:(NSString*)checkString;

+(void)makeShakeAnimationForView:(UIView*)animationView;

+(id)jsonObjectFromJsonData:(NSData*)jsonData;

+(void)showAlertWithTitle:(NSString*)titleString andMessage:(NSString*)messageString;
+(NSString *)changeDateFormatDDMMYYYY:(NSDate *)date;

+ (BOOL )stringIsEmpty:(NSString *)aString;

+(void)newAlertViewWithTitle:(NSString *)titleStr message:(NSString *)msgStr delegate:(id)delegate firstBtnTitle:(NSString *)firstBtnStr
               secondBtnTitle:(NSString *)secondBtnStr viewController:(UIViewController *)vc;

+(void)fadeUpErrorMsgWithLbl:(UILabel *)lbl andMsg:(NSString *)msg;

+(NSString *)JSONString : (NSMutableDictionary *)dicInfo;

+ (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;

+(NSInteger) getCurrentYear;

+(NSInteger) getCurrentMonth;

+ (CALayer *)prefix_addUpperBorder:(UIRectEdge)edge color:(UIColor *)color thickness:(CGFloat)thickness uiview:(UIView*)view;

+(NSDate *)setBirthDate;

+(BOOL)isReachable;

+(void)removeTextBorderColorRed:(UITextField *)textfield;
+(void)textBorderColorRed:(UITextField *)textfield;
+ (void)showAnimate : (UIView *)view;
+ (void)removeAnimate : (UIView *)view;

+(void)setViewCornerRadius : (UIView*)view radius : (float)radius;

+(void)setLableCornerRadius : (UILabel*)lbl radius : (float)radius;

+(void)setButtonCornerRadius : (UIButton*)btn;

+(void)setViewCornerRadiusWithBorder : (UIView*)view radius : (float)radius;

+(void)runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;

+(void)setShadowToAUIView:(UIView *)view;

+(float) getHeightForTextView:(UITextView *)textView;

+(float) getHeightForTextView:(UITextView *)textView forText:(NSString *)strText;

+(float) getHeightForLabel:(UILabel *)labelView forText:(NSString *)strText;

+(float)getWidthForLabel:(UILabel *)labelView forText:(NSString *)strText;

+(UIImage *)ViewBackground:(UIView*)view;

+ (UIColor *)colorWithRGBA:(NSString *)rgba;

+ (UIView *)getMainView;

// For Font
+(UIFont *)setFontSFUIDisplayRegular:(float)SizeF;

+(NSString*)getCurrentDateWithTime;
+(NSString *)getDeviceID;
@end
