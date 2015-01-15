//
//  FiveShape.m
//  squre_v2.0
//
//  Created by hanbing on 15/1/15.
//  Copyright (c) 2015年 feinaide. All rights reserved.
//

#import "FiveShape.h"

@implementation FiveShape
- (void)one2Two
{
    position p1 = {0,0};
    position p2 = {1,0};
    position p3 = {0,1};
    position p4 = {1,1};
    
    position centerP = {0,0};
    
    [self setPosition:p1 pos2:p2 pos3:p3 pos4:p4 centerP:centerP];
}

- (void)two2Three
{
    [self one2Two];
}

- (void)three2Four
{
    [self one2Two];
}

- (void)four2One
{
    [self one2Two];
}
@end
