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

@interface ViewController ()<HBShapeContorlDelegate>

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property(nonatomic,strong)HBMap *mainMap;

@property(nonatomic,strong)HBShapeControl *shapeC;

@property(nonatomic,strong)NSOperationQueue *optQueue;

@property(nonatomic,copy) HBLayer *layTemp;

@property (weak, nonatomic) IBOutlet UILabel *score;
@property(nonatomic,assign) int scoreN;
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
    _scoreN = 0;
    [self.optQueue addOperationWithBlock:^{
        @synchronized(self)
        {
            NSLog(@"----start game----");
            while (YES)
            {
                if (self.optQueue.isSuspended)
                {
                    return;
                }
                _shapeC = nil;
                HBBase *base = [self randomProduceShape];
//                HBBase *base = [[ThreeShape alloc] init];//测试数据
                int row = 0;
                int col = arc4random_uniform(11);
                
                _shapeC = [[HBShapeControl alloc] initWith:base currentRow:row currentCol:col];
                
                _shapeC.delegate = self;
                
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
//    type = 2;
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
- (void)shapeContorlDeleteFullRow:(int)row
{
    NSArray *sonLayers = self.mainView.layer.sublayers;
    //删除这一行的数据 重新置0，并移除layer
    NSMutableArray *temp = self.mainMap.rowArray[row];
    
    CGFloat locY = row*20;
    for (int i=0; i<temp.count; i++)
    {
        for (int j=0;j<sonLayers.count; j++)
        {
            CALayer *ly = sonLayers[j];
            if (ly.frame.origin.y == locY)
            {
                [ly removeFromSuperlayer];
            }
        }
    }
    for (int i=0; i<temp.count; i++)
    {
        temp[i] = @0;
    }
    /**
     问题，消除一行后下移不了，sublayers属性是copy
     */
    NSMutableArray *tempLayer = [NSMutableArray array];
    for (int i=(int)sonLayers.count-1; i>=0; i--)
    {
        HBLayer *ly = sonLayers[i];
        //在他上方的方块才往下移动一格
        if (ly.frame.origin.y<locY)
        {
            _layTemp = ly;
            [self setMapValue:@0 layer:ly];
            CGFloat tempY = ly.frame.origin.y + 20;
            CGRect tempF = CGRectMake(ly.frame.origin.x,tempY,20,20);
            _layTemp.frame = tempF;
            
            [ly removeFromSuperlayer];
            
            [tempLayer addObject:_layTemp];
        }
    }
    
    for (int i=0; i<tempLayer.count; i++)
    {
        HBLayer *ly = tempLayer[i];
        [self setMapValue:@1 layer:ly];
        [self.mainView.layer addSublayer:ly];
    }
    _scoreN += 100;
    
    _score.text = [NSString stringWithFormat:@"分数:%d",_scoreN];
}
/**
 根据layer设置总坐标系的值
 */
- (void)setMapValue:(NSNumber *)number layer:(HBLayer *)ly
{
    int row = ly.frame.origin.y/20;
    int col = ly.frame.origin.x/20;
    self.mainMap.rowArray[row][col] = number;
}
- (void)dealloc
{
    NSLog(@"viewController我去了！");
}
@end
