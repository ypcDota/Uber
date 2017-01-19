//
//  FxButtonHelper.h
//  FxUI
//
//  Created by Jinbo He on 12-12-25.
//  Copyright (c) 2012年 KingCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FxButtonHelper : NSObject

@property(nonatomic, strong) UIButton   *button;
@property(nonatomic, strong) UIColor    *normalColor;
@property(nonatomic, strong) UIColor    *selectedColor;
@property(nonatomic, strong) NSString   *normalImageName;
@property(nonatomic, strong) NSString   *selectedImageName;
@property(nonatomic, strong) NSString   *lastnormalImageName;

- (void)setButton:(UIButton *)btn
      normalColor:(UIColor *)nColor
    selectedColor:(UIColor *)sColor;
- (void)setButtonEx:(UIButton *)btn;

- (void)setSelected:(BOOL)selected;

@end
