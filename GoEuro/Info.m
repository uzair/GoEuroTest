//
//  Info.m
//  GoEuro
//
//  Created by tegdev05 on 11/21/16.
//  Copyright © 2016 TEG. All rights reserved.
//

#import "Info.h"

@implementation Info

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        
        [self setLogo:[aDecoder decodeObjectForKey:@"provider_logo"]];
        [self setPrice:[aDecoder decodeObjectForKey:@"price_in_euros"]];
        [self setDepartureTime:[aDecoder decodeObjectForKey:@"departure_time"]];
        [self setArrivalTime:[aDecoder decodeObjectForKey:@"arrival_time"]];
        [self setStops:[aDecoder decodeObjectForKey:@"number_of_stops"]];
        
        
        }
                return self;
    
}
                            
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:_logo forKey:@"provider_logo"];
    [aCoder encodeObject:_price forKey:@"price_in_euros"];
    [aCoder encodeObject:_departureTime forKey:@"departure_time"];
    [aCoder encodeObject:_arrivalTime forKey:@"arrival_time"];
    [aCoder encodeObject:_stops forKey:@"number_of_stops"];
    
}


@end
