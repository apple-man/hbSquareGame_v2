//
//  OneShape.m
//  squre_v2.0
//
//  Created by hanbing on 15/1/15.
//  Copyright (c) 2015年 feinaide. All rights reserved.
//

#import "OneShape.h"

#import "HBBase.h"
@implementation OneShape

- (void)one2Two
{
    position p1 = {0,1};
    position p2 = {1,1};
    position p3 = {2,1};
    position p4 = {0,2};
    
    [self setPosition:p1 pos2:p2 pos3:p3 pos4:p4];
}

- (void)two2Three
{
    position p1 = {0,0};
    position p2 = {1,0};
    position p3 = {1,1};
    position p4 = {1,2};
    
    [self setPosition:p1 pos2:p2 pos3:p3 pos4:p4];
}

- (void)three2Four
{
    position p1 = {2,0};
    position p2 = {0,1};
    position p3 = {1,1};
    position p4 = {2,1};
    
    [self setPosition:p1 pos2:p2 pos3:p3 pos4:p4];
    
}

- (void)four2One
{
    position p1 = {1,0};
    position p2 = {1,1};
    position p3 = {1,2};
    position p4 = {2,2};
    
    [self setPosition:p1 pos2:p2 pos3:p3 pos4:p4];
}
@end
