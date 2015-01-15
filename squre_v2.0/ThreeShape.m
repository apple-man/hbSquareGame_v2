//
//  Three.m
//  squre_v2.0
//
//  Created by hanbing on 15/1/15.
//  Copyright (c) 2015年 feinaide. All rights reserved.
//

#import "ThreeShape.h"

@implementation ThreeShape
- (void)one2Two
{
    position p1 = {0,2};
    position p2 = {1,2};
    position p3 = {2,2};
    position p4 = {3,2};
    
    position centerP = {1,2};
    
    [self setPosition:p1 pos2:p2 pos3:p3 pos4:p4 centerP:centerP];
}

- (void)two2Three
{
    position p1 = {1,0};
    position p2 = {1,1};
    position p3 = {1,2};
    position p4 = {1,3};
    
    position centerP = {1,2};
    
    [self setPosition:p1 pos2:p2 pos3:p3 pos4:p4 centerP:centerP];
}

- (void)three2Four
{
    position p1 = {0,2};
    position p2 = {1,2};
    position p3 = {2,2};
    position p4 = {3,2};
    
    position centerP = {1,2};
    
    [self setPosition:p1 pos2:p2 pos3:p3 pos4:p4 centerP:centerP];
    
}

- (void)four2One
{
    position p1 = {1,0};
    position p2 = {1,1};
    position p3 = {1,2};
    position p4 = {1,3};
    
    position centerP = {1,2};
    
    [self setPosition:p1 pos2:p2 pos3:p3 pos4:p4 centerP:centerP];
}
@end
