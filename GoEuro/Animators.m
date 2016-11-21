//
//  Animators.m
//  MOC
//
//  Created by Mahmoud Nasr on 9/27/15.
//  Copyright © 2015 nasr. All rights reserved.
//

#import "Animators.h"
#import "SVProgressHUD.h"
#import "MBProgressHUD.h"
@implementation Animators

+(void)setScreenState :(UIViewController * )controller :(BOOL)state{
    if(state)
    {
        
        dispatch_async(dispatch_get_main_queue(), ^{
          [MBProgressHUD hideHUDForView:controller.view animated:YES];
        });
    }
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showHUDAddedTo:controller.view animated:YES];
        });
    }
    
    
    

    
}

+(void)setScreenStateEnabledWhileLoading :(UIViewController *)controller {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showHUDAddedTo:controller.view animated:YES];
    });
    
    [controller.view setUserInteractionEnabled:YES];
}


+(void)setScreenStateView :(UIView * )controller :(BOOL)state{
    if(state)
    {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:controller animated:YES];
        });
    }
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:controller animated:YES];
        });
    }
    
    
    

    
    
}
+(void)showMessage : (UIViewController*)con : (NSString*)message{
    vc = con;
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@""
                                                     message:message
                                                    delegate:self
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles: nil];
    
    
    
 //   alert.delegate = vc;
    dispatch_async(dispatch_get_main_queue(), ^{
    
        
        [alert show];    });
  
}
+ (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [vc.navigationController popViewControllerAnimated:NO];
}
+(void)showMessage : (NSString*)message{
  
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@""
                                                     message:message
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles: nil];
    
    //   alert.delegate = vc;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        [alert show];    });
    
}

@end
