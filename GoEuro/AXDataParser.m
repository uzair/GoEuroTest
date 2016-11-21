//
//  AXDataParser.m
//  AxiomBackEnd
//
//  Created by Ashraf Tawfeeq on 9/17/13.
//  Copyright (c) 2013 ASGATech. All rights reserved.
//

#import "AXDataParser.h"
//#import "AXAvatar.h"

@implementation AXDataParser 

+(NSDictionary *)parseDatawithString:(NSMutableData*)data{
    if (data == nil) {
        return nil;
    }
   // NSError* error = nil;
    NSLog(@"Data:  %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    NSString *url=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *response = [[NSDictionary alloc]initWithObjectsAndKeys:url,@"url",nil];
   //[response setValue:url forKey:@"tinyurl"];
    return response;
}

+ (NSArray *)parseData:(NSMutableData*)data{
    if (data == nil) {
        return nil;
    }
 
    NSError* error = nil;
  //  NSLog(@"Data:  %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    
    NSArray *jsonData = (NSArray *)[NSJSONSerialization JSONObjectWithData:data
                                           options: NSJSONReadingMutableContainers
                                             error: &error];
    if (error) {
        NSLog(@"JSON Parsing Error:  %@", error);
        return nil;
    }
    
    NSMutableArray *finalArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dict in jsonData) {
        
        Info *info = [[Info alloc] init];
        
        info.logo = [dict valueForKey:@"provider_logo"];
        info.price = [NSString stringWithFormat:@"%@",[dict valueForKey:@"price_in_euros"]];
        info.departureTime = [dict valueForKey:@"departure_time"];
        info.arrivalTime = [dict valueForKey:@"arrival_time"];
        info.stops = [NSString stringWithFormat:@"%@",[dict valueForKey:@"number_of_stops"]];
        
        [finalArray addObject:info];
        
    }
    
    
    
    
    return finalArray;
}







+ (NSMutableArray *)parseData_Array:(NSMutableData*)data{ if (data == nil) { return nil; } NSError* error = nil; NSLog(@"Data: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]); NSMutableArray *jsonData =[NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error]; if (error) { NSLog(@"JSON Parsing Error: %@", error); return nil; } return jsonData; }
@end
