//
//  HBMap.m
//  squre_v2.0
//
//  Created by hanbing on 15/1/15.
//  Copyright (c) 2015年 feinaide. All rights reserved.
//

#import "HBMap.h"

#define maxCol 15
#define maxRow 22


@implementation HBMap


- (instancetype)init
{
    if (self = [super init])
    {
        for (int i=0; i<maxRow; i++)
        {
            NSMutableArray *col = [[NSMutableArray alloc] initWithCapacity:maxCol];
            for (int j=0; j<maxCol; j++)
            {
                NSNumber *num = @0;
                
                [col addObject:num];
            }
            [self.rowArray addObject:col];
        }
    }
    return self;
}

- (NSMutableArray *)rowArray
{
    if (_rowArray==nil)
    {
        _rowArray = [[NSMutableArray alloc] initWithCapacity:maxRow];
    }
    return _rowArray;
}


@end
