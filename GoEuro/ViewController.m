//
//  ViewController.m
//  GoEuro
//
//  Created by tegdev05 on 11/20/16.
//  Copyright © 2016 TEG. All rights reserved.
//

#import "ViewController.h"
#import "CultureCenterCell.h"
#import "Animators.h"



@interface ViewController ()
{
    NSArray *resultArray;
    WebServices *web ;

}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    
    NSArray *array = [NSArray arrayWithObjects:@"Flight",@"Train",@"Bus", nil];
    
    [self.segmentControl setItems:array];

    
     [Animators setScreenState:self : NO];
    
    web = [[WebServices alloc] init];
    web.delegate = self;
    [web getFlights];
    
   
}


#pragma mark - WebService Delegate

-(void)webservicesSucess:(NSArray *)result{
    
    
    if([result isKindOfClass:[NSNull class]])
    { [Animators setScreenState:self : YES];
        [Animators showMessage:self :@"No Data"];
        
        return;
    }
    
    resultArray = result;
    NSLog(@"%lu",(unsigned long)[resultArray count]);
    
    if (resultArray) {
        
        if([resultArray count]<1)
        {
            [Animators showMessage:self :@"No Data"];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];}
                       
                       );
        
        
        [Animators setScreenState:self : YES];
        
    }
}

-(void )webservicesFail:(NSString *)error{

    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    
    NSData * data;
    
    [Animators showMessage:self :error];
    [Animators setScreenState:self : YES];
    
    
    switch (self.segmentControl.selectedIndex) {
        case 0:{
            data = [userDef objectForKey:@"flights"];
            break;
        }
            
        case 1:{
            data = [userDef objectForKey:@"trains"];
            break;
        }
            
        case 2:{
            data = [userDef objectForKey:@"buses"];
            break;
        }
            
        default:
            break;
    }
    
            if (data) {
                resultArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                [self.tableView reloadData];
            }
  
    
}

#pragma mark - UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [resultArray count];    //count number of row from counting array hear cataGorry is An Array
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 118.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
   // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    CultureCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CultureCenterCelliPhone" owner:nil options:nil] objectAtIndex:0];
    }
    
    // Here we use the provided setImageWithURL: method to load the web image
    // Ensure you use a placeholder image otherwise cells will be initialized with no image
    
    Info *dict = [resultArray objectAtIndex:indexPath.row];
    [cell setArrivalTime:dict.arrivalTime];
    [cell setDepartureTime:dict.departureTime];
    [cell setStops:dict.stops];
    [cell setPrice:dict.price];
    [cell setLogoImage:dict.logo];
    
    return cell;
}



#pragma mark - SegmentControl Methods

-(IBAction)selectorValueChanged:(id)sender
{
    NPSegmentedControl *segment = (NPSegmentedControl *)sender;
    NSLog(@"%ld",(long)segment.selectedIndex);
    
    [Animators setScreenState:self :NO];
    
    switch (segment.selectedIndex) {
        case 0:
            [web getFlights];
            break;
            
        case 1:
            [web getTrains];
            break;
            
        case 2:
            [web getBuses];
            break;
        default:
            break;
    }
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
