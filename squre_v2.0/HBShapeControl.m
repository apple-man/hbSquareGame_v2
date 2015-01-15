//
//  HBShapeControl.m
//  squre_v2.0
//
//  Created by hanbing on 15/1/15.
//  Copyright (c) 2015年 feinaide. All rights reserved.
//

#import "HBShapeControl.h"
#import "HBBase.h"
#import "OneShape.h"
#import "HBLayer.h"
#import "HBMap.h"
#define blockNum 4

@interface HBShapeControl()

@property(nonatomic,copy)HBBase *rotationBase;

@end
@implementation HBShapeControl

- (instancetype)init
{
    if (self = [super init])
    {
        //初始化面板
//        self.map = [[HBMap alloc] init];
    }
    return self;
}
- (instancetype)initWith:(HBBase *)shape currentRow:(int)row currentCol:(int)col
{
    if (self = [self init])
    {
        if ([shape isMemberOfClass:[OneShape class]])
        {
            [self countLocationInMap:shape currentRow:row currentCol:col];
        }
        
        self.layerArray = [[NSMutableArray alloc] initWithCapacity:blockNum];
        
        UIColor *color = [UIColor redColor];
        
        HBLayer *one = [[HBLayer alloc] initWithColor:color];
        one.frame = CGRectMake(shape.inMap1.x*HBWidth,shape.inMap1.y*HBHeight,HBWidth,HBHeight);
        [self.layerArray addObject:one];
        
        HBLayer *two = [[HBLayer alloc] initWithColor:color];
        two.frame = CGRectMake(shape.inMap2.x*HBWidth,shape.inMap2.y*HBHeight,HBWidth,HBHeight);
        [self.layerArray addObject:two];
        
        HBLayer *three = [[HBLayer alloc] initWithColor:color];
        three.frame = CGRectMake(shape.inMap3.x*HBWidth,shape.inMap3.y*HBHeight,HBWidth,HBHeight);
        [self.layerArray addObject:three];
        
        HBLayer *four = [[HBLayer alloc] initWithColor:color];
        four.frame = CGRectMake(shape.inMap4.x*HBWidth,shape.inMap4.y*HBHeight,HBWidth,HBHeight);
        [self.layerArray addObject:four];
        
        self.shape = shape;
    }
    
    return self;
}
- (void)countLocationInMap:(HBBase *)shape currentRow:(int)row currentCol:(int)col
{
    position map1 = {col+shape.p1.x,row+shape.p1.y};
    shape.inMap1 = map1;
    position map2 = {col+shape.p2.x,row+shape.p2.y};
    shape.inMap2 = map2;
    position map3 = {col+shape.p3.x,row+shape.p3.y};
    shape.inMap3 = map3;
    position map4 = {col+shape.p4.x,row+shape.p4.y};
    shape.inMap4 = map4;
    position centerP = {col+shape.centerP.x,row+shape.centerP.y};
    shape.centerInMap = centerP;
}


- (void)moveRight
{
    //检查条件
}

- (void)moveLeft
{
    //检查条件

}

- (void)updateFrame
{
    HBLayer *ly1 = self.layerArray[0];
    ly1.frame = CGRectMake(self.shape.inMap1.x*HBWidth,self.shape.inMap1.y*HBHeight,HBWidth,HBHeight);
    HBLayer *ly2 = self.layerArray[1];
    ly2.frame = CGRectMake(self.shape.inMap2.x*HBWidth,self.shape.inMap2.y*HBHeight,HBWidth,HBHeight);
    HBLayer *ly3 = self.layerArray[2];
    ly3.frame = CGRectMake(self.shape.inMap3.x*HBWidth,self.shape.inMap3.y*HBHeight,HBWidth,HBHeight);
    HBLayer *ly4 = self.layerArray[3];
    ly4.frame = CGRectMake(self.shape.inMap4.x*HBWidth,self.shape.inMap4.y*HBHeight,HBWidth,HBHeight);
}

/**向下移动 begin**/
- (void)moveDown
{
    //检查条件
    position map1 = {self.shape.inMap1.x,self.shape.inMap1.y+1};
    self.shape.inMap1 = map1;
    position map2 = {self.shape.inMap2.x,self.shape.inMap2.y+1};
    self.shape.inMap2 = map2;
    position map3 = {self.shape.inMap3.x,self.shape.inMap3.y+1};
    self.shape.inMap3 = map3;
    position map4 = {self.shape.inMap4.x,self.shape.inMap4.y+1};
    self.shape.inMap4 = map4;
    position centerP = {self.shape.centerInMap.x,self.shape.centerInMap.y+1};
    self.shape.centerInMap = centerP;
    [self updateFrame];
}

- (BOOL)checkMoveDown:(HBMap *)map
{
    BOOL f1 = [self testDown:map pos:self.shape.inMap1];
    BOOL f2 = [self testDown:map pos:self.shape.inMap2];
    BOOL f3 = [self testDown:map pos:self.shape.inMap3];
    BOOL f4 = [self testDown:map pos:self.shape.inMap4];
    if (f1&&f2&&f3&&f4)
    {
        return YES;
    }
    return NO;
}

- (BOOL)testDown:(HBMap *)map pos:(position)p
{
    int row = p.y + 1;
    int col = p.x;
    
    if (row>21)
    {
        return NO;
    }
    NSNumber *flag = map.rowArray[row][col];
    if (flag.intValue==1)
    {
        return NO;
    }
    return YES;
}
- (void)StopInMap:(HBMap *)map
{
    [self addInMap:map pos:self.shape.inMap1];
    [self addInMap:map pos:self.shape.inMap2];
    [self addInMap:map pos:self.shape.inMap3];
    [self addInMap:map pos:self.shape.inMap4];
}
- (void)addInMap:(HBMap *)map pos:(position)p
{
    int row = p.y;
    int col = p.x;
    map.rowArray[row][col] = @1;
    
}
/**向下移动 stop**/

/**要重新计算inMap的坐标 根据原来的坐标值计算出来**/
- (void)switchShape:(HBMap *)map
{
    [self.shape changeShape];
    [self updateFrame];
}
- (BOOL)checkRotation:(HBMap *)map
{
    //根据rotatioinBase检查条件，如果不对的话不影响原来的值
    _rotationBase = self.shape;
    BOOL f1 = [self checkSwitch:map pos:_rotationBase.inMap1 mapIndex:1];
    BOOL f2 = [self checkSwitch:map pos:_rotationBase.inMap2 mapIndex:2];
    BOOL f3 = [self checkSwitch:map pos:_rotationBase.inMap3 mapIndex:3];
    BOOL f4 = [self checkSwitch:map pos:_rotationBase.inMap4 mapIndex:4];
    if (f1&&f2&&f3&&f4)
    {
        return YES;
    }
    return NO;
}
- (BOOL)checkSwitch:(HBMap *)map pos:(position)pInMap mapIndex:(int)index
{
    
    int col = pInMap.x;
    int row = pInMap.y;
    
    [_rotationBase changeShape];
    
    //再检查现在的值
    if (index==1)
    {
        col = _rotationBase.inMap1.x;
        row = _rotationBase.inMap1.y;
    }else if(index==2)
    {
        col = _rotationBase.inMap2.x;
        row = _rotationBase.inMap2.y;
    }else if(index==3)
    {
        col = _rotationBase.inMap3.x;
        row = _rotationBase.inMap3.y;
    }
    else
    {
        col = _rotationBase.inMap4.x;
        row = _rotationBase.inMap4.y;
    }
    
    if (col<0||col>15)
    {
        return NO;
    }
    if (row>21)
    {
        return NO;
    }
    
    NSNumber *flag = map.rowArray[row][col];
    
    if (flag.intValue==1)
    {
        return NO;
    }
        return YES;
}

- (BOOL)checkmove
{
    
    return YES;
}

@end
