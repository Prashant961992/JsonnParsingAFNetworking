//
//  WebServiceCallClass.h
//  People Shop
//
//  Created by Arvaan on 15/03/16.
//  Copyright © 2016 Pooja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "webserviceClass.h"
//#import "Constant.h"


@interface WebServiceCallClass : NSObject

+(void) initializeWebServiceCallClass;

#pragma mark- GetCategotryData

+(BOOL)fetchCategoryData: (NSMutableDictionary *)dicInfo
       completionHandler:(webCompletionHandler)completion
          failureHandler:(webFailureHandler)failure;

+(BOOL)getVideoList: (NSMutableDictionary *)dicInfo
  completionHandler:(webCompletionHandler)completion
     failureHandler:(webFailureHandler)failure;

@end

