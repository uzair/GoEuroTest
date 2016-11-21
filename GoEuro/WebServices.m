//
//  WebServices.m
//  BeaconReceiver
//
//  Created by Mahmoud Nasr on 5/24/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

#import "WebServices.h"
#import "AXInternetConnection.h"
#import "AXDataParser.h"


//This is staging
//#define webserviceUrl "http://172.19.2.202:8081/MCYCDWebService.asmx/"

//This is live
#define webserviceUrl "http://mcycd.gov.ae:8081/MCYCDWebService.asmx/"


@implementation WebServices
{
    
}
-(id)init {
    if ( self = [super init] ) {
    
    }
    return self;
}
 


-(void)getFlights
{
    if (![AXInternetConnection getStatus]) {
        
        [self.delegate webservicesFail:@"No Internet"];
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@",@"https://api.myjson.com/bins/w60i"];

    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:90.0];
    
    

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[[NSOperationQueue alloc] init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               if ([data length] > 0){
                                   NSArray* parsedData = [AXDataParser parseData:(NSMutableData *)data];
                                   
                                   [self saveDataForOffline:parsedData withKey:@"flights"];
                                   
                                   [self.delegate webservicesSucess :parsedData];
                               }
                               else {
                                   //connectionError
                                   
                                   
                                      [self.delegate webservicesFail:@"No Internet"];
                                   
                               }
                               
                           }];
    
}

-(void)getTrains{
    
    if (![AXInternetConnection getStatus]) {
        [self.delegate webservicesFail:@"No Internet"];
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@",@"https://api.myjson.com/bins/3zmcy"];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:90.0];
    
    
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[[NSOperationQueue alloc] init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               if ([data length] > 0){
                                   NSArray* parsedData = [AXDataParser parseData:(NSMutableData *)data];
                                   
                                        [self saveDataForOffline:parsedData withKey:@"trains"] ;
                                   
                                   [self.delegate webservicesSucess :parsedData];
                               }
                               else {
                                   //connectionError
                                   [self.delegate webservicesFail:@"No Internet"];
                                   
                               }
                               
                           }];
}
-(void)getBuses{
    
    if (![AXInternetConnection getStatus]) {
        [self.delegate webservicesFail:@"No Internet"];
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@",@"https://api.myjson.com/bins/37yzm"];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:90.0];
    
    
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[[NSOperationQueue alloc] init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               if ([data length] > 0){
                                   NSArray* parsedData = [AXDataParser parseData:(NSMutableData *)data];
                                   
                                    [self saveDataForOffline:parsedData withKey:@"buses"];
                                   
                                   [self.delegate webservicesSucess :parsedData];
                               }
                               else {
                                   //connectionError
                                   [self.delegate webservicesFail:@"No Internet"];
                                   
                               }
                               
                           }];
}

-(void)saveDataForOffline:(NSArray *)array withKey:(NSString *)key
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    [userDef setObject:data forKey:key];
    [userDef synchronize];
}


@end
