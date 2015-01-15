//
//  ViewController.m
//  squre_v2.0
//
//  Created by hanbing on 15/1/14.
//  Copyright (c) 2015年 feinaide. All rights reserved.
//

#import "ViewController.h"
#import "OneShape.h"
#import "TwoShape.h"
#import "ThreeShape.h"
#import "FourShape.h"
#import "FiveShape.h"
#import "SixShape.h"
#import "SevenShape.h"
#import "HBShapeControl.h"
#import "HBLayer.h"
#import "HBMap.h"

typedef enum
{
    shapeTypeOne = 0,
    shapeTypeTwo,
    shapeTypeThree,
    shapeTypeFour,
    shapeTypeFive,
    shapeTypeSix,
    shapeTypeSeven
}shapeType;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property(nonatomic,strong)HBMap *mainMap;

@property(nonatomic,strong)HBShapeControl *shapeC;

@property(nonatomic,strong)NSOperationQueue *optQueue;

@end

@implementation ViewController

- (HBMap *)mainMap
{
    if (_mainMap==nil)
    {
        _mainMap = [[HBMap alloc] init];
    }
    return _mainMap;
}
- (NSOperationQueue *)optQueue
{
    if (_optQueue == nil)
    {
        _optQueue = [[NSOperationQueue alloc] init];
    }
    return _optQueue;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setBegin];
}
- (void)setBegin
{
    [self.optQueue addOperationWithBlock:^{
        @synchronized(self)
        {
            while (YES)
            {
                NSLog(@"test");
                if (self.optQueue.isSuspended)
                {
                    return;
                }
                _shapeC = nil;
                NSLog(@"----start game----");
                HBBase *base = [self randomProduceShape];
                int row = 0;
                int col = arc4random_uniform(11);
                
                _shapeC = [[HBShapeControl alloc] initWith:base currentRow:row currentCol:col];
                
                for (int i=0; i<_shapeC.layerArray.count; i++)
                {
                    HBLayer *ly = _shapeC.layerArray[i];
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [self.mainView.layer addSublayer:ly];
                    }];
                }
                while (YES)
                {
                    [NSThread sleepForTimeInterval:0.3];
                    if ([_shapeC checkMoveDown:self.mainMap]) {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            [_shapeC moveDown];
                        }];
//                        HBLayer *ly = _shapeC.layerArray[0];
//                        NSLog(@"down----%@---%p---%p",NSStringFromCGRect(ly.frame),_shapeC,_shapeC.shape);
                    }else{
                        [_shapeC StopInMap:self.mainMap];
                        break;
                    }
                }
            }
        }
        
    }];
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        while (YES)
//        {
//            [NSThread sleepForTimeInterval:0.4];
//            if ([_shapeC checkMoveDown:self.mainMap]) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [_shapeC moveDown];
//                });
//                HBLayer *ly = _shapeC.layerArray[0];
//                NSLog(@"down----%@",NSStringFromCGRect(ly.frame));
//            }else{
//                [_shapeC StopInMap:self.mainMap];
//                return;
//            }
//        }
//    });
}
- (IBAction)rotation
{
    if ([_shapeC checkRotation:self.mainMap])
    {
        [_shapeC switchShape:self.mainMap];
    }
}
- (IBAction)moveLeft
{
    if ([_shapeC checkLeft:self.mainMap])
    {
        [_shapeC moveLeft];
    }
}

- (IBAction)moveRight
{
    if ([_shapeC checkRight:self.mainMap])
    {
        [_shapeC moveRight];
    }
}
- (IBAction)startGame
{
    NSLog(@"start--btn---%lu",self.optQueue.operationCount);
    self.optQueue.suspended = YES;
    [self setBegin];
}

- (IBAction)suspendGame
{
    NSLog(@"暂停---%d",self.optQueue.isSuspended);
    
    self.optQueue.suspended = YES;
    
}

/**
 *随机形状
 */
- (HBBase *)randomProduceShape
{
    HBBase *temp;
    int type = arc4random_uniform(7);
    
    if (type==shapeTypeOne)
    {
        temp = [[OneShape alloc] init];
    }else if(type==shapeTypeTwo){
        temp = [[TwoShape alloc] init];
    }else if(type==shapeTypeThree){
        temp = [[ThreeShape alloc] init];
    }else if(type==shapeTypeFour){
        temp = [[FourShape alloc] init];
    }else if(type==shapeTypeFive){
        temp = [[FiveShape alloc] init];
    }else if(type==shapeTypeSix){
        temp = [[SixShape alloc] init];
    }else{
        temp = [[SevenShape alloc] init];
    }
    return temp;
}

@end
