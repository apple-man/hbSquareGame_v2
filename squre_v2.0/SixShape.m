//
//  SixShape.m
//  squre_v2.0
//
//  Created by hanbing on 15/1/15.
//  Copyright (c) 2015年 feinaide. All rights reserved.
//

#import "SixShape.h"

@implementation SixShape
- (void)one2Two
{
    position p1 = {0,0};
    position p2 = {0,1};
    position p3 = {1,1};
    position p4 = {2,1};
    
    position centerP = {1,1};
    
    [self setPosition:p1 pos2:p2 pos3:p3 pos4:p4 centerP:centerP];
}

- (void)two2Three
{
    position p1 = {1,0};
    position p2 = {2,0};
    position p3 = {1,1};
    position p4 = {1,2};
    
    position centerP = {1,1};
    
    [self setPosition:p1 pos2:p2 pos3:p3 pos4:p4 centerP:centerP];
}

- (void)three2Four
{
    position p1 = {0,1};
    position p2 = {1,1};
    position p3 = {2,1};
    position p4 = {2,2};
    
    position centerP = {1,1};
    
    [self setPosition:p1 pos2:p2 pos3:p3 pos4:p4 centerP:centerP];
    
}

- (void)four2One
{
    position p1 = {1,0};
    position p2 = {1,1};
    position p3 = {1,2};
    position p4 = {0,2};
    
    position centerP = {1,1};
    
    [self setPosition:p1 pos2:p2 pos3:p3 pos4:p4 centerP:centerP];
}
@end
