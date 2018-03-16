//
//  ApplicationData.h
//  DatingApp
//
//  Created by ADMIN on 22/12/16.
//  Copyright © 2016 Prajas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
//#import "AFHTTPClient.h"
//#import "Constant.h"
#import "MBProgressHUD.h"
//#import "DBManager.h"
#import "webserviceClass.h"
//#import "UIViewController+AMSlideMenu.h"
//#import "SDWebImage/UIImageView+WebCache.h"
#import "FMDB.h"
//#import "DataSynchronization.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

typedef enum
{
    kHTTPMethod_GET,
    kHTTPMethod_POST,
    kHTTPMethod_PUT,
    kHTTPMethod_DELETE
}HTTPMethod;


#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"Kaushal  %s\n", [[NSString stringWithFormat:FORMAT,      ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...) {}
#endif


/*
 #ifndef NDEBUG
 #define NSLog(...);
 #endif
 */

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//RGB color macro with alpha
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

// Color code define
#define GREEN UIColorFromRGB(0x71A30A)
#define YELLOW UIColorFromRGB(0xF3B512)
#define BLUE UIColorFromRGB(0x128AB9)
#define BLACK UIColorFromRGB(0x252525);
#define RED UIColorFromRGB(0xC72155);
#define ORANGE UIColorFromRGB(0xF3680E);
#define SKY UIColorFromRGB(0x4E90B5);


#define LIGHTGRAY UIColorFromRGB(0x555555)

// DatabaseTableName
#define tablename [NSString stringWithFormat:@"golaw.sql"];

@interface ApplicationData : NSObject{
    
}

@property (nonatomic,retain) NSMutableDictionary * DeviceInfo;
@property (nonatomic,retain) NSString * finalOTP;
@property (nonatomic,retain) NSString * finalUniqueId;
@property (nonatomic,retain) NSMutableArray * arrayCaseList;
@property (nonatomic,retain) NSMutableArray * arrayIdList;
@property (nonatomic,retain) NSMutableArray * arrayCaseListClose;
@property (nonatomic,retain) NSMutableArray * arrayIdListClose;
@property (nonatomic,retain) NSMutableArray * arrayCaseListAll;
@property (nonatomic,retain) NSMutableArray * arrayIdListAll;
@property (nonatomic,retain) NSMutableArray * arrayWhatsNew;
@property (nonatomic,retain) NSString * whatsnewlastUpdateddate;
@property (nonatomic,retain) NSMutableDictionary *dictFTPInfo;
@property (nonatomic,assign) BOOL isLogOut;


+ (ApplicationData*)sharedInstance;

-(void) saveUserdefault :(NSString *)filename :(id)arrayObject;
-(id) getUserdefault :(NSString*) filename;

- (BOOL)validateEmailWithString:(NSString*)email;
-(BOOL)validatePhoneNumber:(NSString*)number;

- (void) applyTextfieldBorder: (UIButton *)button;
- (BOOL)connected;
-(void) showArrowImage:(BOOL)b intextField:(UITextField *)textField;
-(void)setArrowImageintextField:(UITextField *)textField;
//-(void)setNodataFoundimageFrom:(CGFloat)x andY:(CGFloat)y width:(CGFloat)width height:(CGFloat)height andBoundToView:(UIView *)view;
-(UIImageView *)setNodataFoundimageFrom:(CGFloat)x andY:(CGFloat)y width:(CGFloat)width height:(CGFloat)height andBoundToView:(UIView *)view;
+(NSDateFormatter *)getDateFormatter;
+(NSDateFormatter *)getDateTimeStampFormatter;
+(UIDatePicker *)getDatePicker:(CGRect)rect dateMode:(UIDatePickerMode)dateMode;
+(NSDateFormatter *)getTimeFormatter ;
+(NSDateFormatter *)getDateTimeFormatter;
+(NSDateFormatter *)getDateTimeFormatterForServer;
+ (void) localNotification: (NSString *)strTitle strMsg:(NSString *)strMsg fireDate:(NSDate *)fireDate isSound:(BOOL)isSound isVibrate:(BOOL)isVibrate ;
-(NSString *)userIdget;
+(BOOL)isStringNull:(NSString *)string;
+(void)getCaseListWithOutClose;
+(void)getCaseListWithClose;
+(void)getCaseListAll;
+(NSMutableDictionary *)checkDictionary:(NSMutableDictionary *)dic1;
+(void)getFTPInfoService;
-(NSString *)convertDatenextdateFormat:(NSString *)datestr;

-(NSArray *)arrOfdayViewColumnName;
-(NSArray *)arrOfHeaderVisiblity;
-(NSArray *)arrOfHeaderPosition;
-(NSArray *)arrOfHeaderWidth;
-(NSString *)convertDate:(NSDate *)date;

-(NSString *)getCurrentdate;
-(NSString *)getSynchronizationdate;
-(void)setCurrentDatedate:(NSString *)str;
-(void)setSynchronizationdate:(NSString *)str;

-(NSString *)convertDatedayViewFormat:(NSDate *)date;
- (NSDate *)dateFromString:(NSString *)date;
-(void)callWebServiceWhatsNew;
-(void)setNotificationdate:(NSString *)str;
-(void)allcateArray;
@end
