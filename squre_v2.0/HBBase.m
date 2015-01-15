//
//  HBBase.m
//  squre_v2.0
//
//  Created by hanbing on 15/1/14.
//  Copyright (c) 2015年 feinaide. All rights reserved.
//

#import "HBBase.h"


@interface HBBase()


@end

@implementation HBBase

- (instancetype)init
{
    if (self = [super init])
    {
        [self four2One];
        
        self.type = HBBaseTypeOne;
    }
    return self;
}
/**
 自我感觉设计很好的地方,充分利用了基类
 */
- (void)changeShape
{
    int col = self.centerInMap.x - self.centerP.x;
    int row = self.centerInMap.y - self.centerP.y;
    if (self.type == HBBaseTypeOne)
    {
        [self one2Two];
        
        [self countLocationOfCurrentRow:row currentCol:col];
        
        self.type = HBBaseTypeTwo;
        
    }else if(self.type == HBBaseTypeTwo)
    {
        [self two2Three];
        [self countLocationOfCurrentRow:row currentCol:col];
        self.type = HBBaseTypeThree;
        
    }else if(self.type == HBBaseTypeThree)
    {
        [self three2Four];
        [self countLocationOfCurrentRow:row currentCol:col];
        self.type = HBBaseTypeFour;
    }else
    {
        [self four2One];
        [self countLocationOfCurrentRow:row currentCol:col];
        self.type = HBBaseTypeOne;
    }
}

- (void)setPosition:(position)p1 pos2:(position)p2 pos3:(position)p3 pos4:(position)p4 centerP:(position)cp
{
    self.p1 = p1;
    self.p2 = p2;
    self.p3 = p3;
    self.p4 = p4;
    
    self.centerP = cp;
}
- (void)countLocationOfCurrentRow:(int)row currentCol:(int)col
{
    position map1 = {col+self.p1.x,row+self.p1.y};
    self.inMap1 = map1;
    position map2 = {col+self.p2.x,row+self.p2.y};
    self.inMap2 = map2;
    position map3 = {col+self.p3.x,row+self.p3.y};
    self.inMap3 = map3;
    position map4 = {col+self.p4.x,row+self.p4.y};
    self.inMap4 = map4;
    position centerP = {col+self.centerP.x,row+self.centerP.y};
    self.centerInMap = centerP;
}
- (NSString *)description
{
    NSString *temp = [NSString stringWithFormat:@"(%d,%d),(%d,%d),(%d,%d),(%d,%d)",self.p1.x,self.p1.y,self.p2.x,self.p2.y,self.p3.x,self.p3.y,self.p4.x,self.p4.y];
    return temp;
}
@end
