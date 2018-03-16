//
//  UtilityClass.m
// 
//
//  Created by Arvaan on 08/03/16.
//  Copyright © 2016 Pooja. All rights reserved.
//

#import "UtilityClass.h"

@implementation UtilityClass

+(NSString *)getCurrentSystemLanguage
{
    return [[NSLocale preferredLanguages] objectAtIndex:0];
}

+(BOOL)isLogin
{
    return [[NSUserDefaults standardUserDefaults]valueForKey:@"isLogin"];
}

+(NSString *)valueForKey:(NSString *)String
{
    return [[NSUserDefaults standardUserDefaults]valueForKey:String];
}

+(void)removeForKey:(NSString *)String
{
   [[NSUserDefaults standardUserDefaults] removeObjectForKey:String];
}

+(BOOL)validateEmailWithString:(NSString*)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

+(void)makeShakeAnimationForView:(UIView*)animationView
{
//    animationView.layer.transform = CATransform3DMakeTranslation(10.0, 0.0, 0.0);
//    [UIView animateWithDuration:0.8 delay:0.0 usingSpringWithDamping:0.2 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseOut animations:
//    {
//        animationView.layer.transform = CATransform3DIdentity;
//    }
//    completion:^(BOOL finished)
//    {
//        animationView.layer.transform = CATransform3DIdentity;
//    }];
}

+(UIFont *)setFontSFUIDisplayRegular:(float)SizeF
{
    return [UIFont fontWithName:@"SF-UI-Display-Regular" size:SizeF];
}

+(void)fadeUpErrorMsgWithLbl:(UILabel *)lbl andMsg:(NSString *)msg
{
    lbl.text = msg;
    lbl.alpha = 1.0;
    
    [UIView animateWithDuration:1.0 delay:2.0 options:0 animations:^{
        lbl.alpha = 0.0;
    }
    completion:^(BOOL finished)
    {
         lbl.text  =@"" ;
         lbl.alpha = 1.0;
    }];
}

+(id)jsonObjectFromJsonData:(NSData *)jsonData
{
    NSError *error=nil;
    id jsonObject=[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    if (error)
    {
        return nil;
    }
    else
    {
        return jsonObject;
    }
}

+(void)showAlertWithTitle:(NSString *)titleString andMessage:(NSString *)messageString
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:titleString message:messageString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - empty string

+ (BOOL )stringIsEmpty:(NSString *) aString
{
    
    if ((NSNull *) aString == [NSNull null])
    {
        return YES;
    }
    
    if (aString == nil)
    {
        return YES;
    } else if ([aString length] == 0)
    {
        return YES;
    } else {
        aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([aString length] == 0)
        {
            return YES;
        }
    }
    
    return NO;
}

+(NSString *)changeDateFormatDDMMYYYY:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *newDateString = [dateFormatter stringFromDate:date];
    return newDateString;
}

#pragma mark - AlertViewMethod

+(void)newAlertViewWithTitle:(NSString *)titleStr message:(NSString *)msgStr delegate:(id)delegate firstBtnTitle:(NSString *)firstBtnStr
               secondBtnTitle:(NSString *)secondBtnStr viewController:(UIViewController *)vc
{
    UIAlertView *newAlertView;
    if(secondBtnStr != nil)
    {
        newAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:msgStr delegate:delegate cancelButtonTitle:firstBtnStr otherButtonTitles:secondBtnStr,nil];
    }
    else
    {
        newAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:msgStr delegate:delegate cancelButtonTitle:firstBtnStr otherButtonTitles:nil];
    }
    [newAlertView show];
}

#pragma mark -  Animation

+ (void)showAnimate : (UIView *)view
{
    [UIView animateWithDuration:0.5f delay:0.f options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         view.frame = CGRectMake(0, view.superview.frame.origin.y+200, view.superview.frame.size.width, view.frame.size.height);
                     }
                     completion:^(BOOL finished)
     {
         //viewNotify.hidden=YES;
         //viewAnimation.hidden=YES;
         
     }];
}

+ (CALayer *)prefix_addUpperBorder:(UIRectEdge)edge color:(UIColor *)color thickness:(CGFloat)thickness uiview:(UIView*)view
{
    CALayer *border = [CALayer layer];
    
    switch (edge)
    {
        case UIRectEdgeTop:
            border.frame = CGRectMake(0, 0, CGRectGetWidth(view.frame), thickness);
            break;
        case UIRectEdgeBottom:
            border.frame = CGRectMake(0, CGRectGetHeight(view.frame) - thickness, CGRectGetWidth(view.frame), thickness);
            break;
        case UIRectEdgeLeft:
            border.frame = CGRectMake(0, 0, thickness, CGRectGetHeight(view.frame));
            break;
        case UIRectEdgeRight:
            border.frame = CGRectMake(CGRectGetWidth(view.frame) - thickness, 0, thickness, CGRectGetHeight(view.frame));
            break;
        default:
            break;
    }
    
    border.backgroundColor = color.CGColor;
    
    [view.layer addSublayer:border];
    
    return border;
}

+(NSString *) convertDateToString:(NSDate *)date forFormat:(NSString *)strFormate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = strFormate;
    
    return [formatter stringFromDate:date];
}

+(NSInteger) getCurrentMonth
{
    return [UtilityClass convertDateToString:[NSDate date] forFormat:@"MM"].integerValue;
}

+(NSInteger) getCurrentYear
{
    return [UtilityClass convertDateToString:[NSDate date] forFormat:@"yy"].integerValue;
}

+(void)ShowAnimation:(UIView *)view
{
    view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    [UIView animateWithDuration:0.3/1.5 animations:^{
        view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.3/2 animations:^{
//                view.transform = CGAffineTransformIdentity;
//            }];
        }];
    }];
}

+(void)runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * rotations * duration ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeat;
    
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

+ (void)removeAnimate:(UIView *)view
{
    [UIView animateWithDuration:.25 animations:^{
        view.transform = CGAffineTransformMakeScale(1.3, 1.3);
       // view.alpha = 0.0;
    } completion:^(BOOL finished)
     {
         
     }];
}

#pragma mark -
+(NSDate *)setBirthDate
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:-12];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    return newDate;
    
    dateComponents = nil;
}

#pragma mark - Convert dictionary in JSON String

+(NSString *)JSONString:(NSMutableDictionary *)dicInfo
{
    NSError *error=nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicInfo
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    
    NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    //    JSONString = [JSONString stringByReplacingOccurrencesOfString:@" " withString:@""];
    //    JSONString = [JSONString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSLog(@"JSONString %@",JSONString);
    
    return JSONString;
}

//+(BOOL)isReachable
//{
//    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
//    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
//    
//    if (networkStatus == NotReachable)
//    {
//        return false;
//    }
//    return true;
//}

+(void)setShadowToAUIView:(UIView *)view
{
    [view.layer setBorderColor:[UIColor colorWithRed:213.0/255.0f green:210.0/255.0f blue:199.0/255.0f alpha:1.0f].CGColor];
    [view.layer setBorderWidth:1.0f];
    [view.layer setCornerRadius:7.5f];
    [view.layer setShadowOffset:CGSizeMake(0, 1)];
    [view.layer setShadowColor:[[UIColor darkGrayColor] CGColor]];
    [view.layer setShadowRadius:8.0];
    [view.layer setShadowOpacity:0.2];
    [view.layer setMasksToBounds:NO];
}

#pragma mark - make texfield border red
+(void)textBorderColorRed:(UITextField *)textfield
{
    textfield.layer.borderColor = [[UIColor redColor] CGColor];
    textfield.layer.borderWidth = 1.0;
}

+(void)removeTextBorderColorRed:(UITextField *)textfield
{
    textfield.layer.borderColor = [[UIColor clearColor] CGColor];
    textfield.layer.borderWidth = 0.0;
}

+ (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize
{
    CGSize actSize = image.size;
    float scale = actSize.width/actSize.height;
    
    if (scale < 1)
    {
        newSize.height = newSize.width/scale;
    }
    else
    {
        newSize.width = newSize.height*scale;
    }
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newImage;
}

+(float)getHeightForTextView:(UITextView *)textView
{
    CGFloat fixedWidth = textView.frame.size.width;
    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];

    return newSize.height;
}

+(void)setButtonCornerRadius:(UIButton*)btn
{
    btn.layer.cornerRadius = 10.0;
    btn.layer.masksToBounds = YES;
}

+(void)setViewCornerRadiusWithBorder:(UIView*)view radius:(float)radius
{
    view.layer.borderColor = [[UIColor whiteColor]CGColor];
    view.layer.borderWidth = 1.0;
    view.layer.cornerRadius = radius;
    view.layer.masksToBounds = YES;
}

+(void)setViewCornerRadius : (UIView*)view radius : (float)radius
{
    view.layer.cornerRadius = radius;
    view.layer.masksToBounds = YES;
}
+(void)setLableCornerRadius : (UILabel*)lbl radius : (float)radius
{
    lbl.layer.cornerRadius = radius;
    lbl.layer.masksToBounds = YES;
}

+(float)getHeightForTextView:(UITextView *)textView forText:(NSString *)strText
{
    UITextView *temp =[[UITextView alloc] initWithFrame:textView.frame];
    temp.font = textView.font;
    temp.text = strText;
    
    CGFloat fixedWidth = temp.frame.size.width;
    CGSize newSize = [temp sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    
    return newSize.height;
}

+(float)getHeightForLabel:(UILabel *)labelView forText:(NSString *)strText
{
//    UILabel *temp =[[UILabel alloc] initWithFrame:labelView.frame];
//    temp.font = labelView.font;
//    temp.text = strText;
//    
//    CGFloat fixedWidth = temp.frame.size.width;
//    CGSize newSize = [temp sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
//    
//    return newSize.height;
    
    CGSize constraint = CGSizeMake(labelView.frame.size.width, 20000.0f);
    CGSize size;
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [labelView.text boundingRectWithSize:constraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:labelView.font}
                                                  context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    return size.height;
}

+(float)getWidthForLabel:(UILabel *)labelView forText:(NSString *)strText
{
    //    UILabel *temp =[[UILabel alloc] initWithFrame:labelView.frame];
    //    temp.font = labelView.font;
    //    temp.text = strText;
    //
    //    CGFloat fixedWidth = temp.frame.size.width;
    //    CGSize newSize = [temp sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    //
    //    return newSize.height;
    
    CGSize constraint = CGSizeMake(labelView.frame.size.width, 20000.0f);
    CGSize size;
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [labelView.text boundingRectWithSize:constraint
                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:@{NSFontAttributeName:labelView.font}
                                                      context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    return size.width;
}
-(void)sessionExpired
{
//    NSMutableDictionary *dictLogout = [NSMutableDictionary initUserProfileDict];
//    showHUD
//    [WebServiceCallClass logOut:dictLogout completionHandler:^(id data)
//     {
//         hideHUD
//         [self.navigationController popToRootViewControllerAnimated:YES];
//         [[NSUserDefaults standardUserDefaults] removeObjectForKey:kNsuerdefaulUserKey];
//         [[userProfile sharedProfileManager] setDataNilUserProfile];
//         
//     } failureHandler:^(NSError *error)
//     {
//         hideHUD
//         [UtilityClass showBarWithMessage:[error localizedDescription] Title:@"Error" BarType:kAlertError];
//     }];
//    
}

+(UIImage *)ViewBackground:(UIView*)view
{
    UIGraphicsBeginImageContext(view.frame.size);
    [[UIImage imageNamed:@"blur-background"] drawInRect:view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIColor *)colorWithRGBA:(NSString *)rgba
{
    float red = 0.0;
    float green = 0.0;
    float blue = 0.0;
    float alpha = 1.0;
    
    if ([rgba hasPrefix:@"#"])
    {
        NSString *hex = [rgba substringFromIndex:1];
        NSScanner *scanner = [NSScanner scannerWithString:hex];
        unsigned long long hexValue = 0;
        if ([scanner scanHexLongLong:&hexValue]) {
            switch (hex.length) {
                case 3:
                    red = ((hexValue & 0xF00) >> 8) / 15.0;
                    green = ((hexValue & 0x0F0) >> 4) / 15.0;
                    blue = (hexValue & 0x00F) / 15.0;
                    break;
                case 4:
                    red = ((hexValue & 0xF000) >> 12) / 15.0;
                    green = ((hexValue & 0x0F00) >> 8) / 15.0;
                    blue = ((hexValue & 0x00F0) >> 4) / 15.0;
                    alpha = (hexValue & 0x000F) / 15.0;
                    break;
                case 6:
                    red = ((hexValue & 0xFF0000) >> 16) / 255.0;
                    green = ((hexValue & 0x00FF00) >> 8) / 255.0;
                    blue = (hexValue & 0x0000FF) / 255.0;
                    break;
                case 8:
                    red = ((hexValue & 0xFF000000) >> 24) / 255.0;
                    green = ((hexValue & 0x00FF0000) >> 16) / 255.0;
                    blue = ((hexValue & 0x0000FF00) >> 8) / 255.0;
                    alpha = (hexValue & 0x000000FF) / 255.0;
                    break;
                default:
                    NSLog(
                          @"Invalid RGB string: '%@', number of characters after '#' should "
                          @"be " @"either 3, 4, 6 or 8",
                          rgba);
            }
        }
        else
        {
            NSLog(@"Scan hex error");
        }
    }
    else
    {
        NSLog(@"Invalid RGB string: '%@', missing '#' as prefix", rgba);
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIView *)getMainView
{
    if (SYSTEM_VERSION_LESS_THAN(@"8.0"))
    {
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        if (!window)
            window = [[UIApplication sharedApplication].windows objectAtIndex:0];
        return [window subviews].lastObject;
    }
    else
    {
        UIWindow *window =[[UIApplication sharedApplication] keyWindow];
        if (window == nil)
            window = [[[UIApplication sharedApplication] delegate] window];//#14
        return window;
    }
}

+(NSString*)getCurrentDateWithTime
{
    // Get current date time
    
    NSDate *currentDateTime = [NSDate date];
    
    // Instantiate a NSDateFormatter
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // Set the dateFormatter format
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    // or this format to show day of the week Sat,11-12-2011 23:27:09
    
    //[dateFormatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    
    // Get the date time in NSString
    
    NSString *dateInStringFormated = [dateFormatter stringFromDate:currentDateTime];
    
    return dateInStringFormated;
    ////NSLog(@"%@", dateInStringFormated);
    
    // Release the dateFormatter
    
    //[dateFormatter release];
}

+(NSString *)getDeviceID
{
    NSString *deviceId;
    NSUUID *oNSUUID = [[UIDevice currentDevice] identifierForVendor];
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        deviceId = [oNSUUID UUIDString];
    } else
    {
        deviceId = [oNSUUID UUIDString];
    }
    return deviceId;
}

@end
