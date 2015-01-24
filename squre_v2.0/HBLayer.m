//
//  HBLayer.m
//  squre_v2.0
//
//  Created by hanbing on 15/1/15.
//  Copyright (c) 2015年 feinaide. All rights reserved.
//

#import "HBLayer.h"
#import "UIColor+Random.h"


@implementation HBLayer

- (instancetype)initWithColor:(UIColor *)color
{
    if (self = [super init])
    {
        self.backgroundColor = color.CGColor;
        self.borderWidth = 1.5;
        self.borderColor = [UIColor randomColor].CGColor;
    }
    return self;
}

@end
