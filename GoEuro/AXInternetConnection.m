//
//  AXInternetConnection.m
//  AxiomMSelfCare
//
//  Created by Ashraf Tawfeeq on 10/27/13.
//  Copyright (c) 2013 Mohamed Sayed. All rights reserved.
//

#import "AXInternetConnection.h"
#import "Reachability.h"
//#import "Constants.h"

@implementation AXInternetConnection

+ (BOOL)getStatus{
    Reachability *reach = [Reachability reachabilityWithHostName:@"google.com"];
	NetworkStatus status = [reach currentReachabilityStatus];
	// if connection is reachable then return set the return flag to True
    if (status != NotReachable) {
        NSLog(@"Connected");
		return YES;
	} else {
        
//        SHOW_OK_ALERT(@"WARNING", @"No internet connection")
        NSLog(@"Not Connected");
		return NO;
	}

}

@end
