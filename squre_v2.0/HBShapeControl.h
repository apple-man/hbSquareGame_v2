//
//  HBShapeControl.h
//  squre_v2.0
//
//  Created by hanbing on 15/1/15.
//  Copyright (c) 2015年 feinaide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

#define HBStep 20

@class HBBase;
@class HBMap;

@protocol HBShapeContorlDelegate <NSObject>

- (void)shapeContorlDeleteFullRow:(int)row;

@end

@interface HBShapeControl : NSObject

@property(nonatomic,weak)id<HBShapeContorlDelegate> delegate;
/**
 记录形状
 */
@property(nonatomic,strong)HBBase *shape;
/**
 记录一个整体形状的所有小方块
 */
@property(nonatomic,strong)NSMutableArray *layerArray;

/**
 构造方法
 */
- (instancetype)initWith:(HBBase *)shape currentRow:(int)row currentCol:(int)col;

/**
 向右移动
 */
- (void)moveRight;
/**
 向左移动
 */
- (void)moveLeft;
/**
 向下移动
 */
- (void)moveDown;
/**
 检查向下移动的条件
 */
- (BOOL)checkMoveDown:(HBMap *)map;
/**
 把停止的方块加入到大的map中
 */
- (void)StopInMap:(HBMap *)map;
/**
 旋转
 */
- (void)switchShape:(HBMap *)map;
/**
 检查旋转的条件
 */
- (BOOL)checkRotation:(HBMap *)map;
/**
 检查向右移动的条件
 */
- (BOOL)checkRight:(HBMap *)map;
/**
 检查向左移动的条件
 */
- (BOOL)checkLeft:(HBMap *)map;

@end
