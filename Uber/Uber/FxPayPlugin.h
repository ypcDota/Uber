//
//  FxPayPlugin.h
//  Uber
//
//  Created by hejinbo on 15/10/26.
//  Copyright © 2015年 MyCos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UPPayPluginDelegate.h"

@interface FxPayPlugin : NSObject

+ (BOOL)startPayFx:(NSString*)tn mode:(NSString*)mode viewController:(UIViewController*)viewController delegate:(id<UPPayPluginDelegate>)delegate;

@end
