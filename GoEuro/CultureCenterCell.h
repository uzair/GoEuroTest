//
//  NewsTableViewCell.h
//  MOLProjectStructure
//
//  Created by MOL MacBook on 7/30/15.
//  Copyright (c) 2015 MOL MacBook. All rights reserved.
//


#import "AsyncImageView.h"

@interface CultureCenterCell : UITableViewCell
{
    IBOutlet UILabel *arrivalTimeLabel;
    IBOutlet UILabel *departureTimeLabel;
    IBOutlet UILabel *priceLabel;
    IBOutlet UILabel *stopsLabel;
    IBOutlet AsyncImageView *transportImageView;
    
}

-(void)setArrivalTime:(NSString *)arrivalTime;
-(void)setDepartureTime:(NSString *)departureTime;
-(void)setPrice:(NSString *)price;
-(void)setStops:(NSString *)stops;
-(void)setLogoImage:(NSString *)image;

@end
