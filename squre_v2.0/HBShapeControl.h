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

@interface HBShapeControl : NSObject

@property(nonatomic,strong)HBBase *shape;

@property(nonatomic,strong)NSMutableArray *layerArray;

- (instancetype)initWith:(HBBase *)shape currentRow:(int)row currentCol:(int)col;

- (void)moveRight;

- (void)moveLeft;

- (void)moveDown;

- (BOOL)checkMoveDown:(HBMap *)map;

- (void)StopInMap:(HBMap *)map;

- (void)switchShape:(HBMap *)map;

- (BOOL)checkRotation:(HBMap *)map;

- (BOOL)checkRight:(HBMap *)map;

- (BOOL)checkLeft:(HBMap *)map;

@end
