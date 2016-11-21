//
//  Info.h
//  GoEuro
//
//  Created by tegdev05 on 11/21/16.
//  Copyright © 2016 TEG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Info : NSObject <NSCoding>

@property (nonatomic,retain) NSString *logo;
@property (nonatomic,retain) NSString *price;
@property (nonatomic,retain) NSString *departureTime;
@property (nonatomic,retain) NSString *arrivalTime;
@property (nonatomic,retain) NSString *stops;

@end
