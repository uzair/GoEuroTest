//
//  ViewController.h
//  GoEuro
//
//  Created by tegdev05 on 11/20/16.
//  Copyright © 2016 TEG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServices.h"
#import "GoEuro-swift.h"
#import "Info.h"

@interface ViewController : UIViewController<WebServicesDelegation>

@property (nonatomic,retain) IBOutlet UITableView *tableView;
@property (nonatomic,retain) IBOutlet NPSegmentedControl *segmentControl;

-(IBAction)selectorValueChanged:(id)sender;


@end

