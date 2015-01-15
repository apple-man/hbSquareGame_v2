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

- (void)changeShape
{
    if (self.type == HBBaseTypeOne)
    {
        [self one2Two];
        
        self.type = HBBaseTypeTwo;
        
    }else if(self.type == HBBaseTypeTwo)
    {
        [self two2Three];
        
        self.type = HBBaseTypeThree;
        
    }else if(self.type == HBBaseTypeThree)
    {
        [self three2Four];
        
        self.type = HBBaseTypeFour;
    }else
    {
        [self four2One];
        
        self.type = HBBaseTypeOne;
    }
}

- (void)setPosition:(position)p1 pos2:(position)p2 pos3:(position)p3 pos4:(position)p4
{
    self.p1 = p1;
    self.p2 = p2;
    self.p3 = p3;
    self.p4 = p4;
}

- (NSString *)description
{
    NSString *temp = [NSString stringWithFormat:@"(%d,%d),(%d,%d),(%d,%d),(%d,%d)",self.p1.x,self.p1.y,self.p2.x,self.p2.y,self.p3.x,self.p3.y,self.p4.x,self.p4.y];
    return temp;
}
@end
