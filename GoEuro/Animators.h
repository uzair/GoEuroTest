//
//  Animators.h
//  MOC
//
//  Created by Mahmoud Nasr on 9/27/15.
//  Copyright © 2015 nasr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIViewController.h>
static UIViewController *vc;
@interface Animators : UIViewController

+(void)setScreenState :(UIViewController * )controller :(BOOL)state;
+(void)showMessage : (UIViewController*)con : (NSString*)message;
+(void)showMessage : (NSString*)message;
+(void)setScreenStateView :(UIView * )controller :(BOOL)state;
+(void)setScreenStateEnabledWhileLoading :(UIViewController *)controller;
@end
