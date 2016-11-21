//
//  WebServices.h
//  BeaconReceiver
//
//  Created by Mahmoud Nasr on 5/24/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Info.h"


@protocol WebServicesDelegation <NSObject>
@optional

- (void) webservicesSucess :(NSArray*)result;

-(void)webservicesFail : (NSString *) error;

@end
// Protocol Definition ends here
@interface WebServices : NSObject
{
    // Delegate to respond back
    id <WebServicesDelegation> _delegate;
    
}
@property (nonatomic,strong) id delegate;


-(void)getFlights;
-(void)getTrains;
-(void)getBuses;

-(void)saveDataForOffline:(NSArray *)array withKey:(NSString *)key;
@end
