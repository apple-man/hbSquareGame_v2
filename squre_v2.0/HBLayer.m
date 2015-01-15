//
//  HBLayer.m
//  squre_v2.0
//
//  Created by hanbing on 15/1/15.
//  Copyright (c) 2015年 feinaide. All rights reserved.
//

#import "HBLayer.h"



@implementation HBLayer

- (instancetype)initWithColor:(UIColor *)color
{
    if (self = [super init])
    {
//        CGRect bounds = CGRectMake(0,0,HBWidth,HBHeight);
//        self.bounds = bounds;
//        
        self.backgroundColor = color.CGColor;
    }
    return self;
}



@end
