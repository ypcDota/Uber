//
//  FxPayPlugin.m
//  Uber
//
//  Created by hejinbo on 15/10/26.
//  Copyright © 2015年 MyCos. All rights reserved.
//

#import "FxPayPlugin.h"
#import "UPPayPlugin.h"

@implementation FxPayPlugin

+ (BOOL)startPayFx:(NSString*)tn mode:(NSString*)mode viewController:(UIViewController*)viewController delegate:(id<UPPayPluginDelegate>)delegate
{
    return [UPPayPlugin startPay:tn mode:mode viewController:viewController delegate:delegate];
}

@end
