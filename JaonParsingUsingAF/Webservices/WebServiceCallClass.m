//
//  WebServiceCallClass.m
//  People Shop
//
//  Created by Arvaan on 15/03/16.
//  Copyright © 2016 Pooja. All rights reserved.
//

#import "WebServiceCallClass.h"

@implementation WebServiceCallClass

static webserviceClass *webService;

+(void) initializeWebServiceCallClass
{
    webService = [[webserviceClass alloc] init];
}

#pragma mark- GetCategotryData

+(BOOL)fetchCategoryData: (NSMutableDictionary *)dicInfo
       completionHandler:(webCompletionHandler)completion
          failureHandler:(webFailureHandler)failure
{
    NSString *strURL = @"http://www.tele50.com/fr/json/fetch.php";
    [WebServiceCallClass initializeWebServiceCallClass];
    
    return [webService getWebServiceCall:strURL parameters:nil completionHandler:completion faliureHandler:failure];
}

+(BOOL)getVideoList: (NSMutableDictionary *)dicInfo
       completionHandler:(webCompletionHandler)completion
          failureHandler:(webFailureHandler)failure
{
    NSString *strURL = @"http://www.tele50.com/fr/json/videosjson.php";
    [WebServiceCallClass initializeWebServiceCallClass];
    
    return [webService getWebServiceCall:strURL parameters:nil completionHandler:completion faliureHandler:failure];
}

// http://cdnhd.oraolive.com:8081/tele50webtv/playlist.m3u8 - Service not Working
// http://usa6.fastcast4u.com:5018/flux

//#pragma mark - SearchViewController
//
//+(BOOL)searchButtonClick:(NSMutableDictionary *)dicInfo
//              completionHandler:(webCompletionHandler)completion
//                 failureHandler:(webFailureHandler)failure
//{
//    NSString *baseurl = baseURL;
//    
//    NSString *strURL = [NSString stringWithFormat:@"%@SearchItems",baseurl];
//    [WebServiceCallClass initializeWebServiceCallClass];
//    
//    return [webService postWebserviceCall:strURL param:dicInfo completionHandler:completion faliureHandler:completion];
//}
@end
