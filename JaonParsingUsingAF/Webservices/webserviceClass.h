//
//  webserviceClass.h
//  People Shop
//
//  Created by Arvaan on 14/03/16.
//  Copyright © 2016 Pooja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
//#import <AFNetworking/AFNetworking.h>

typedef void (^webCompletionHandler)(id data);
typedef void (^webFailureHandler)(NSError *error);

@interface webserviceClass : NSObject

-(BOOL)getWebServiceCall:(NSString *)methodURL
              parameters:(NSMutableDictionary *)parameters
       completionHandler:(webCompletionHandler)completion
          faliureHandler:(webFailureHandler)failure;

-(BOOL)postWebserviceCall:(NSString *)methodURL
                    param:(NSMutableDictionary *)params
        completionHandler:(webCompletionHandler)completion
           faliureHandler:(webFailureHandler)failure;

-(BOOL)callWebServiceUsingPostMethodWithImageDataPostURL : (NSString*)strURL  withParamiterDicrionary : (NSDictionary*)paramiterDict withImageData : (NSData*)imgData successPostBlock:(void(^)(id responseObject))sucess failurePostBlock:(void(^)(NSError *error))fail;

-(BOOL)callWebServiceUsingPostMethodWithImageDataPostURL : (NSString*)strURL  withParamiterDicrionary : (NSMutableDictionary*)paramiterDict arrayOfImages:(NSArray *)arrayImages successPostBlock:(void(^)(id responseObject))sucess failurePostBlock:(void(^)(NSError *error))fail;

@end
