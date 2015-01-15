//
//  UIColor+Random.m
//  squre_v2.0
//
//  Created by hanbing on 15/1/15.
//  Copyright (c) 2015年 feinaide. All rights reserved.
//

#import "UIColor+Random.h"

#define randomC arc4random_uniform(255)/256.0

@implementation UIColor (Random)

+ (UIColor *)randomColor
{
    UIColor *temp = [[UIColor alloc] initWithRed:randomC green:randomC blue:randomC alpha:1.0];
    
    return temp;
}
@end
