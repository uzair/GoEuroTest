//
//  NewsTableViewCell.m
//  MOLProjectStructure
//
//  Created by MOL MacBook on 7/30/15.
//  Copyright (c) 2015 MOL MacBook. All rights reserved.
//

#import "CultureCenterCell.h"

@implementation CultureCenterCell

-(void)awakeFromNib{
    [super awakeFromNib];

   
}

-(void)setArrivalTime:(NSString *)arrivalTime
{
    [arrivalTimeLabel setText:arrivalTime];
}
-(void)setDepartureTime:(NSString *)departureTime
{
    [departureTimeLabel setText:departureTime];
}
-(void)setPrice:(NSString *)price
{
    [priceLabel setText:[NSString stringWithFormat:@"$ %@",price]];
}
-(void)setStops:(NSString *)stops
{
    [stopsLabel setText:[NSString stringWithFormat:@"Stops : %@",stops]];
}
-(void)setLogoImage:(NSString *)image
{
    NSString *finalStr = [image stringByReplacingOccurrencesOfString:@"{size}" withString:@"63"];
    [transportImageView setImageURL:[NSURL URLWithString:finalStr]];
    
}

@end
