//
//  FxActivity.h
//  FxHejinbo
//
//  Created by hejinbo on 15/5/19.
//  Copyright (c) 2015年 MyCos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FxActivity : UIView

@property (copy) NSString *labelText;
@property (copy) NSString *detailsLabelText;

- (id)initWithView:(UIView *)view;
- (void)show:(BOOL)animated;
- (void)hide:(BOOL)animated;
- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay;

@end
