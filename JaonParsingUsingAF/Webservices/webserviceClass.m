//
//  webserviceClass.m
//  People Shop
//
//  Created by Arvaan on 14/03/16.
//  Copyright © 2016 Pooja. All rights reserved.
//

#import "webserviceClass.h"
//#import "Constant.h"


@implementation webserviceClass


-(BOOL)getWebServiceCall:(NSString *)methodURL
              parameters:(nullable id)parameters
       completionHandler:(webCompletionHandler)completion
          faliureHandler:(webFailureHandler)failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:methodURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         completion(responseObject);
     }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
         
         if (data)
         {
             NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
             
             if (dict)
             {
                 //                 NSDictionary *userInfo = @{
                 //                                            NSLocalizedDescriptionKey : [dict objectForKey:@"message"],
                 //                                            };
                 //
                 //                 error = [NSError errorWithDomain:error.domain code:[[dict objectForKey:@"status"] integerValue] userInfo:userInfo];
                 
             }
             if (error.code == 504)
             {
                 NSLog(@"Log out forcefully");
                 failure (error);
             }
             else
             {
                 failure (error);
             }
         }
     }];
    
    
    return true;
}

-(BOOL)postWebserviceCall:(NSString *)methodURL
                    param:(NSMutableDictionary *)params
        completionHandler:(webCompletionHandler)completion
           faliureHandler:(webFailureHandler)failure
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];

    
    [manager POST:methodURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         completion(responseObject);
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
         if (data)
         {
             NSDictionary * dict =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
             if (dict)
             {
                 NSDictionary *userInfo = @{
                                            NSLocalizedDescriptionKey: [dict objectForKey:@"message"],
                                            };
                 
                 NSLog(@"Failure due to %@",dict);
                 
                 error = [NSError errorWithDomain:error.domain code:[[dict objectForKey:@"status"] integerValue] userInfo:userInfo];
             }
         }
         else
         {
             failure (error);
         }
     }];
    return true;
}

-(BOOL)callWebServiceUsingPostMethodWithImageDataPostURL : (NSString*)strURL  withParamiterDicrionary : (NSMutableDictionary*)paramiterDict arrayOfImages:(NSArray *)arrayImages successPostBlock:(void(^)(id responseObject))sucess failurePostBlock:(void(^)(NSError *error))fail
{
    NSError *error;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:strURL parameters:paramiterDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                    {
                                        for (int i = 0; i< arrayImages.count; i++)
                                        {
                                            NSData *data = UIImageJPEGRepresentation([arrayImages objectAtIndex:i], 0.7);
                                            
                                            [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"product_images[%d]",i] fileName:[NSString stringWithFormat:@"file%d.jpg",i ] mimeType:@"image/jpeg"];
                                        }
                                        
                                    } error:nil];
    
    NSLog(@"The error for uploading pics is %@",[error localizedDescription]);
    
    //    [request setValue:@"ios" forHTTPHeaderField:@"ostype"];
    //    [request setValue:[[constantModel sharedManager] appVersion] forHTTPHeaderField:@"version"];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
                          
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      
                      
                      
                      if (error)
                      {
                          NSLog(@"Error: %@", error);
                          fail(error);
                          
                      } else
                      {
                          NSLog(@"%@ %@", response, responseObject);
                          
                          NSError *e = nil;
                          NSDictionary *responseDict = [NSJSONSerialization
                                                        JSONObjectWithData: responseObject
                                                        options: NSJSONReadingMutableContainers
                                                        error: &e];
                          sucess(responseDict);
                      }
                  }];
    [uploadTask resume];
    return true;
}


-(BOOL)callWebServiceUsingPostMethodWithImageDataPostURL : (NSString*)strURL  withParamiterDicrionary:(NSDictionary*)paramiterDict withImageData : (NSData*)imgData successPostBlock:(void(^)(id responseObject))sucess failurePostBlock:(void(^)(NSError *error))fail
{
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:strURL parameters:paramiterDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    {
        [formData appendPartWithFileData:imgData name:@"profile_pic" fileName:@"image.jpeg" mimeType:@"image/jpeg"];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
                          
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          NSLog(@"Error: %@", error);
                          fail(error);
                      } else {
                          NSLog(@"%@ %@", response, responseObject);
                          
                          NSError *e = nil;
                          NSDictionary *responseDict = [NSJSONSerialization
                                                        JSONObjectWithData: responseObject
                                                        options: NSJSONReadingMutableContainers
                                                        error: &e];
                          sucess(responseDict);
                          
                      }
                      
                  }];
    
    [uploadTask resume];
    
    return YES;
}
@end
