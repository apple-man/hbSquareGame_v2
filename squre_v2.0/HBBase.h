//
//  HBBase.h
//  squre_v2.0
//
//  Created by hanbing on 15/1/14.
//  Copyright (c) 2015年 feinaide. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef struct
{
    int x;
    int y;
    
}position;

typedef enum
{
    HBBaseTypeOne = 0,
    HBBaseTypeTwo,
    HBBaseTypeThree,
    HBBaseTypeFour
}HBBaseType;

@interface HBBase : NSObject

@property(nonatomic,assign) HBBaseType type;
@property(nonatomic,assign)position p1;
@property(nonatomic,assign)position p2;
@property(nonatomic,assign)position p3;
@property(nonatomic,assign)position p4;

/**
 转化后在大坐标系中的位置
 */
@property(nonatomic,assign)position inMap1;
@property(nonatomic,assign)position inMap2;
@property(nonatomic,assign)position inMap3;
@property(nonatomic,assign)position inMap4;

- (void)changeShape;

/*************子类必须实现的方法 开始*************/
- (void)one2Two;

- (void)two2Three;

- (void)three2Four;

- (void)four2One;
/*************子类必须实现的方法 结束*************/

- (void)setPosition:(position)p1 pos2:(position)p2 pos3:(position)p3 pos4:(position)p4;
@end
