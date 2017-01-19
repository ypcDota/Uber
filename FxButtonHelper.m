//
//  FxButtonHelper.m
//  FxUI
//
//  Created by Jinbo He on 12-12-25.
//  Copyright (c) 2012年 KingCloud. All rights reserved.
//

#import "FxButtonHelper.h"

@implementation FxButtonHelper

- (void)setButton:(UIButton *)btn
      normalColor:(UIColor *)nColor
    selectedColor:(UIColor *)sColor
{
    [self setSelected:NO];
    
    self.button = btn;
    self.normalColor = nColor;
    self.selectedColor = sColor;
    
    [self setSelected:YES];
}

- (void)setSelected:(BOOL)selected
{
    UIColor *color = selected?_selectedColor:_normalColor;
    UIImage *image = [UIImage imageNamed:(selected?_selectedImageName:_normalImageName)];
    
    [_button setTitleColor:color forState:UIControlStateNormal];
    [_button setTitleColor:color forState:UIControlStateHighlighted];
    
    [_button setImage:image forState:UIControlStateNormal];
    [_button setImage:image forState:UIControlStateHighlighted];
}

- (void)setSelectedEx:(BOOL)selected
{
    UIImage *image = [UIImage imageNamed:(selected?_selectedImageName:_normalImageName)];
    
    [_button setImage:image forState:UIControlStateNormal];
    [_button setImage:image forState:UIControlStateHighlighted];
}

- (void)setButtonEx:(UIButton *)btn
{
    [self setSelectedEx:NO];
    self.button = btn;
    [self setSelectedEx:YES];
}

@end
