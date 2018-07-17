//
//  ApplicationData.m
//  DatingApp
//
//  Created by ADMIN on 22/12/16.
//  Copyright © 2016 Prajas. All rights reserved.
//

#import "ApplicationData.h"
//#import "DayView.h"
//#import "AddCaseView.h"
//#import "EditCaseView.h"
//#import "ReopenCaseView.h"
//#import "ReplaceJudgeView.h"
//#import "CloseCaseView.h"
//#import "DeleteCaseView.h"
//#import "CaseHistoryView.h"
//#import "HighlightCaseView.h"
//#import "FeesViewController.h"
//#import "MonthlyPaymentView.h"
//#import "SortFilterView.h"
//#import "ReminderListView.h"
//#import "BackupRestorView.h"
//#import "ShareCaseView.h"
//#import "CeritifiedDocView.h"
//#import "TodoViewController.h"
//#import "SettingsViewController.h"
//#import "ELegalserviceView.h"
//#import "MoreViewController.h"

//#import "ProfileViewController.h"
#import "FMDatabase.h"

static ApplicationData *applicationData = nil;

@implementation ApplicationData
@synthesize DeviceInfo;

- (id)init {
    if(self = [super init])
    {
        self.DeviceInfo = [NSMutableDictionary dictionary];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        self.arrayIdList = [[NSMutableArray alloc] init];
        self.arrayCaseList = [[NSMutableArray alloc] init];
        self.arrayIdListAll = [[NSMutableArray alloc] init];
        self.arrayCaseListAll = [[NSMutableArray alloc] init];
        self.arrayIdListClose = [[NSMutableArray alloc] init];
        self.arrayCaseListClose = [[NSMutableArray alloc] init];
        self.dictFTPInfo = [[NSMutableDictionary alloc] init];
        self.arrayWhatsNew = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)initialize{
}
+(NSInteger )DMLOperationwithDic:(NSString *)query withParameter:(NSMutableDictionary *)object{
    FMDatabase *db = [FMDatabase databaseWithPath:TABLENAME];
    [db open];
    NSInteger lastID = 0;
    if ([db open]) {
        if (object == nil) {
            BOOL val=[db executeUpdate:query];
            if (val) {
                lastID = [db lastInsertRowId];
            }
        } else {
            BOOL val=  [db executeUpdate:query withParameterDictionary:object];
            if (val) {
                lastID = [db lastInsertRowId];
            }
        }
    }else{
        NSLog(@"Failed to open database!!!!!");
    }
    [db close];
    return lastID;
}
+(void)updateQuerywithoutObject:(NSString *)query{
    FMDatabase *db = [FMDatabase databaseWithPath:TABLENAME];
    [db open];
    if ([db open]) {
        [db executeUpdate:query];
    }else{
        NSLog(@"Failed to open database!!!!!");
    }
    [db close];
}
+(BOOL )deleteQuery:(NSString *)query{
    BOOL val;
    FMDatabase *db = [FMDatabase databaseWithPath:TABLENAME];
    [db open];
    if ([db open]) {
        val = true;
        [db executeUpdate:query];
    }else{
        val = false;
        NSLog(@"Failed to open database!!!!!");
    }
    [db close];
    return val;
}
+(NSMutableArray *)ExecuteQuery:(NSString *)query withParameter:(NSArray *)object{
    FMDatabase *db = [FMDatabase databaseWithPath:TABLENAME];
    FMResultSet *resultSet ;
    NSMutableArray *arrData = [[NSMutableArray alloc] init];
    [db open];
    if ([db open]) {
        if (object == nil) {
            resultSet =  [db executeQuery:query];
            while ([resultSet next]) {
                [arrData addObject:[resultSet resultDictionary]];
                //                NSLog(@"%@", [[resultSet resultDict] description]);
            }
        } else {
            resultSet =  [db executeQuery:query withArgumentsInArray:object];
            while ([resultSet next]) {
                [arrData addObject:[resultSet resultDict]];
            }
        }
    }else{
        NSLog(@"Failed to open database!!!!!");
    }
    [db close];
    return arrData;
}
+ (ApplicationData*)sharedInstance{
    if (applicationData == nil){
        applicationData = [[super allocWithZone:NULL] init];
        [applicationData initialize];
    }
    return applicationData;
}
+ (id)allocWithZone:(NSZone *)zone{
    return [self sharedInstance];
}
- (id)copyWithZone:(NSZone *)zone{
    return self;
}
- (BOOL)connected{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}
#pragma mark User Default save
-(void)saveUserdefault :(NSString *)filename :(id)arrayObject{
    //    NSLog(@"Save SaSl%@ = %@",filename,arrayObject);
    NSArray *temparray = (NSArray *)arrayObject;
    NSString *documentsDir = [NSSearchPathForDirectoriesInDomains
                              (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
    NSString *dogFilePath = [documentsDir stringByAppendingPathComponent:filename];
    //NSLog(@"dogFilePath = %@",dogFilePath);
    [NSKeyedArchiver archiveRootObject:temparray toFile:dogFilePath];
}
-(id) getUserdefault:(NSString*)filename{
    NSString *documentsDir = [NSSearchPathForDirectoriesInDomains
                              (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
    NSString *dogFilePath = [documentsDir stringByAppendingPathComponent:filename];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:dogFilePath];
}
#pragma mark Email Validation
- (BOOL)validateEmailWithString:(NSString*)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark Phone Validation

-(BOOL)validatePhoneNumber:(NSString*)number {
    NSError *error;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypePhoneNumber
                                                               error:&error];
    NSUInteger numberOfMatches = [detector numberOfMatchesInString:number
                                                           options:0
                                                             range:NSMakeRange(0, [number length])];
    if(numberOfMatches>0)
        return YES;
    return NO;
}

- (void)applyTextfieldBorder:(UIButton *)button{
    button.layer.borderColor = YELLOW.CGColor;
    button.layer.borderWidth = 1;
}

// code For No Data Found

-(UIImageView *)setNodataFoundimageFrom:(CGFloat)x andY:(CGFloat)y width:(CGFloat)width height:(CGFloat)height andBoundToView:(UIView *)view{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y,width,height)];
    imageView.backgroundColor = [UIColor redColor];
    // imageView.contentMode = UIViewContentModeCenter;
    //[imageView bounds];
    /// imageView.image = [UIImage imageNamed:@"bg123.png"];
    return imageView;
    // [view addSubview:imageView];
}
+(UIDatePicker *)getDatePicker:(CGRect)rect {
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0,  CGRectGetWidth(rect), 216)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    NSDate * date = [NSDate date];
    datePicker.date = date;
    return datePicker;
}
+(UIDatePicker *)getDatePicker:(CGRect)rect dateMode:(UIDatePickerMode)dateMode{
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0,  CGRectGetWidth(rect), 216)];
    datePicker.datePickerMode = dateMode;
    NSDate * date = [NSDate date];
    datePicker.date = date;
    return datePicker;
}
+(NSDateFormatter *)getDateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd-MM-yyyy";
    return dateFormatter;
}
+(NSDateFormatter *)getDateTimeStampFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMdd000000";
    return dateFormatter;
}
+(NSDateFormatter *)getTimeFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"hh:mm a";
    return dateFormatter;
}
+(NSDateFormatter *)getDateTimeFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd-MM-yyyy hh:mm a";
    return dateFormatter;
}
+(NSDateFormatter *)getDateTimeFormatterForServer {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd-MM-yyyy HH:mm";
    return dateFormatter;
}
+ (void) localNotification: (NSString *)strTitle strMsg:(NSString *)strMsg fireDate:(NSDate *)fireDate isSound:(BOOL)isSound isVibrate:(BOOL)isVibrate{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.alertBody =strMsg;
    localNotification.alertTitle = strTitle;
    if (isSound) {
        localNotification.soundName = UILocalNotificationDefaultSoundName;
    } else {
        localNotification.soundName = @"glass.aiff";
    }

    NSDictionary *userInfo = @{ @"isVibrate": @(isVibrate),@"CategoryIdentifier" : strTitle  };
    localNotification.userInfo = userInfo;
    localNotification.fireDate = fireDate;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}
-(NSString *)userIdget{
    NSString *strUserID = [[NSUserDefaults standardUserDefaults] valueForKey:@"USER_ID"];
    if (strUserID.length > 0) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"USER_ID"];
    }
    else{
        return @"";
    }
}

+(BOOL)isStringNull:(NSString *)string{
    if(string==(id) [NSNull null] || [string length]==0 || [string isEqualToString:@""] || [string isEqualToString:@"<null>"] || [string isEqualToString:@"(null)"]){
        return YES;
    }
    return NO;
}

#pragma mark - Check Null Value
+(NSMutableDictionary *)checkDictionary:(NSMutableDictionary *)dic1{
    NSArray *Arr = [dic1 allKeys];
    NSMutableDictionary *dic= [dic1 mutableCopy];
    for (int i = 0; i<Arr.count; i++){
        //|| [[dic valueForKey:[Arr objectAtIndex:i]] isEqualToString:@"<null>"] || [[dic valueForKey:[Arr objectAtIndex:i]] isEqualToString:@"nil"]
        if ([[dic valueForKey:[Arr objectAtIndex:i]] isKindOfClass:[NSNull class]] ){
            [dic setObject:@"" forKey:[Arr objectAtIndex:i]];
        }
        else if ([[dic valueForKey:[Arr objectAtIndex:i]] isKindOfClass:[NSDictionary class]]){
            NSMutableDictionary *dict = [[dic valueForKey:[Arr objectAtIndex:i]] mutableCopy];
            [dic setObject:dict forKey:[Arr objectAtIndex:i]];
            dic = [self checkDictionary:dict];
        }
        else if ([[dic valueForKey:[Arr objectAtIndex:i]] isKindOfClass:[NSMutableArray class]]){
            NSMutableArray *Arr12 = [dic valueForKey:[Arr objectAtIndex:i]];
            for (int j = 0; j<Arr12.count; j++)
            {
                if ([[Arr12 objectAtIndex:j] isKindOfClass:[NSDictionary class]]){
                    NSDictionary *dict123 = [Arr12 objectAtIndex:j];
                    NSMutableDictionary *dict = [dict123 mutableCopy];
                    [Arr12 replaceObjectAtIndex:j withObject:dict];
                    dic = [self checkDictionary:dict];
                }
            }
        }
    }
    return dic;
}

#pragma mark - Service Call

//+(void)getFTPInfoService {
//    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//    NSString *url = [NSString stringWithFormat:@"%@%@%@/%@/iOS", BaseURL,Account,GetDeviceInfoAPI,appVersion];
//
//    NSURL *URL = [NSURL URLWithString:url];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
//    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
//    [manager GET:URL.absoluteString parameters:nil progress:nil  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if([responseObject[@"ResponseCode"] intValue] == 2)
//        {
//            [ApplicationData sharedInstance].dictFTPInfo = responseObject[@"ResponseData"][@"Data"][0];
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"Error: %@", error);
//    }];
//}

-(NSArray *)arrOfdayViewColumnName{
    return [[NSArray alloc]initWithObjects:@"JudgeName OR Court No",@"Next Date",@"Title of Case",@"Stage Today",@"Next Stage",@"Previous Date",@"Evidence/Notes",@"Export To PDF",@"Case No / Year",@"Case Type",@"Session div / City",@"Client",nil];
}

#pragma mark - Service Call

-(NSArray *)arrOfHeaderVisiblity{
    return [[NSArray alloc]initWithObjects:@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",nil];
}

-(NSArray *)arrOfHeaderPosition{
    return [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",nil];
}

-(NSArray *)arrOfHeaderWidth{
    return [[NSArray alloc]initWithObjects:@"90",@"140",@"140",@"140",@"140",@"140",@"140",@"140",@"140",@"140",@"140",@"140",nil];
}

-(NSString *)convertDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [dateFormatter stringFromDate:date];
    // NSString *code = [state substringFromIndex: [[date1 ] length] - 2];
    
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"-"];
    stringFromDate = [[stringFromDate componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
    stringFromDate = [NSString stringWithFormat:@"%@000000",stringFromDate];
    
    return stringFromDate;
}

-(void) showArrowImage:(BOOL)b intextField:(UITextField *)textField{
    if (b == YES) {
        // set the DownPicker arrow to the right (you can replace it with any 32x24 px transparent image: changing size might give different results)
        textField.rightViewMode = UITextFieldViewModeAlways;
    }
    else {
        textField.rightViewMode = UITextFieldViewModeNever;
    }
}

-(void)setArrowImageintextField:(UITextField *)textField{
    textField.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"downArrow.png"]];
    textField.rightView.contentMode = UIViewContentModeScaleAspectFit;
    textField.rightView.clipsToBounds = YES;
    
    [(UIImageView*)textField.rightView setImage:[UIImage imageNamed:@"downArrow.png"]];
    textField.rightViewMode = UITextFieldViewModeAlways;
}

-(NSString *)getCurrentdate{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"CurrentDate"];
}
-(NSString *)getSynchronizationdate{
   return [[NSUserDefaults standardUserDefaults] valueForKey:@"SynchronizDate"];
}

-(void)setCurrentDatedate:(NSString *)str{
    [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"CurrentDate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)setSynchronizationdate:(NSString *)str{
    [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"SynchronizDate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//+(NSMutableDictionary *)convertintoaphostropeDictionary:(NSMutableDictionary *)dic1{
//    NSArray *Arr = [dic1 allKeys];
//    NSMutableDictionary *dic= [dic1 mutableCopy];
//    for (int i = 0; i<Arr.count; i++){
//        if ([[dic valueForKey:[Arr objectAtIndex:i]] isKindOfClass:[NSNull class]] ){
//            [dic setObject:@"" forKey:[Arr objectAtIndex:i]];
//        }
//        else if ([[dic valueForKey:[Arr objectAtIndex:i]] isKindOfClass:[NSDictionary class]]){
//            NSMutableDictionary *dict = [[dic valueForKey:[Arr objectAtIndex:i]] mutableCopy];
//            [dic setObject:dict forKey:[Arr objectAtIndex:i]];
//            dic = [self checkDictionary:dict];
//        }
//        else if ([[dic valueForKey:[Arr objectAtIndex:i]] isKindOfClass:[NSMutableArray class]])
//        {
//            NSMutableArray *Arr12 = [dic valueForKey:[Arr objectAtIndex:i]];
//            for (int j = 0; j<Arr12.count; j++)
//            {
//                if ([[Arr12 objectAtIndex:j] isKindOfClass:[NSDictionary class]])
//                {
//                    NSDictionary *dict123 = [Arr12 objectAtIndex:j];
//                    NSMutableDictionary *dict = [dict123 mutableCopy];
//                    [Arr12 replaceObjectAtIndex:j withObject:dict];
//                    dic = [self checkDictionary:dict];
//                }
//            }
//        }
//    }
//    return dic;
//}

-(NSString *)convertDatedayViewFormat:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [dateFormatter stringFromDate:date];
    // NSString *code = [state substringFromIndex: [[date1 ] length] - 2];
    
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"-"];
    stringFromDate = [[stringFromDate componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
    stringFromDate = [NSString stringWithFormat:@"%@000000",stringFromDate];
    
    return stringFromDate;
}
- (NSDate *)dateFromString:(NSString *)date
{
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter){
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    }
    // NSLog(@"Date: %@ Formatted: %@",date,[dateFormatter dateFromString:date]);
    return [dateFormatter dateFromString:date];
}
-(NSString *)convertDatenextdateFormat:(NSString *)datestr{
    static NSDateFormatter *dateFormatter1;
    if (!dateFormatter1)
    {
        dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
        [dateFormatter1 setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        [dateFormatter1 setDateFormat:@"dd-MM-yyyy"];
    }
    NSDate *date = [dateFormatter1 dateFromString:datestr];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [dateFormatter stringFromDate:date];
    // NSString *code = [state substringFromIndex: [[date1 ] length] - 2];
    
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"-"];
    stringFromDate = [[stringFromDate componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
    stringFromDate = [NSString stringWithFormat:@"%@000000",stringFromDate];
    
    return stringFromDate;
}

//-(void)callWebServiceWhatsNew{
//    /*
//     http://209.126.235.28:1116/Services/Notifications.svc/json/IosWhatsNew
//     {
//     "LastDate":"24-07-2017 16:15"
//     }
//     dd-MM-yyyy HH:mm
//     */
//
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
//    if ([ApplicationData isStringNull:[self getNotificatiodate]]) {
//        [dic setObject:@"" forKey:@"LastDate"];
//    }
//    else{
//         [dic setObject:[self getNotificatiodate] forKey:@"LastDate"];
//    }
//
//    NSString *url = [NSString stringWithFormat:@"%@%@%@", BaseURL,Notifications,@"IosWhatsNew"];
//    [webserviceClass postWebserviceCall:url param:dic completionHandler:^(id data){
//        if ([[data valueForKey:@"ResponseCode"] integerValue]==1){
//           // NSLog(@"notification Response : %@",data);
//            self.arrayWhatsNew = [[NSMutableArray alloc]init];
//            self.whatsnewlastUpdateddate = data[@"ResponseData"][@"Data"][0][@"CurrentDate"];
//            self.arrayWhatsNew = data[@"ResponseData"][@"Data"][0][@"NotificationList"];
//            DBManager *dbManager = [ApplicationData sharedInstance].getdatabase;
//            NSString *query = [NSString stringWithFormat:@"insert into Notification (NotificationId,Title,Description,SentDate,IsRead) values (:NotificationId,:Title,:Description,:SentDate,'1')"];
//
//            for (int i=0; i<self.arrayWhatsNew.count; i++) {
//                NSMutableDictionary *object = [[NSMutableDictionary alloc]init];
//                [object setObject:[[ApplicationData sharedInstance] arrayWhatsNew][i][@"NotificationTypeID"] forKey:@"NotificationId"];
//                [object setObject:[[ApplicationData sharedInstance] arrayWhatsNew][i][@"Title"] forKey:@"Title"];
//                [object setObject:[[ApplicationData sharedInstance] arrayWhatsNew][i][@"Description"] forKey:@"Description"];
//                [object setObject:[[ApplicationData sharedInstance] arrayWhatsNew][i][@"NotificationDate"] forKey:@"SentDate"];
//                //[object setObject:@"1" forKey:@"IsRead"];
//
//                [dbManager DMLOperation:query withParameter:object.mutableCopy];
//            }
//
//            if ([ApplicationData isStringNull:[[NSUserDefaults standardUserDefaults] valueForKey:@"notibadge"]]) {
//                [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"notibadge"];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//            }else{
//                NSArray *arrCount = [dbManager allColumeAndRowGet:[NSString stringWithFormat:@"SELECT * FROM Notification WHERE IsRead='1'"]];
//                [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%lu",(unsigned long)arrCount.count] forKey:@"notibadge"];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//            }
//            [[ApplicationData sharedInstance] setNotificationdate:[[ApplicationData sharedInstance]whatsnewlastUpdateddate]];
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"firebadge" object:self userInfo:nil];
//        }
//        else{
//            signupAlert(nil, data[@"ResponseMsg"]);
//        }
//    } faliureHandler:^(NSError *error){
//        NSLog(@"Error: %@", error.localizedDescription);
//    }];
//}

-(void)allcateArray{
    self.arrayWhatsNew = [[NSMutableArray alloc]init];
}
-(NSString *)getNotificatiodate{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"Notificationdate"];
}
-(void)setNotificationdate:(NSString *)str{
    [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"Notificationdate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
