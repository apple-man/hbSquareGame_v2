//
//  ViewController.m
//  squre_v2.0
//
//  Created by hanbing on 15/1/14.
//  Copyright (c) 2015年 feinaide. All rights reserved.
//

#import "ViewController.h"
#import "OneShape.h"
#import "HBShapeControl.h"
#import "HBLayer.h"
#import "HBMap.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property(nonatomic,strong)HBMap *mainMap;

@property(nonatomic,strong)HBShapeControl *shapeC;

@property(nonatomic,strong)OneShape *s1;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}
- (void)setBegin
{
    int row = 0;
    int col = 5;
    
    _s1 = [[OneShape alloc] init];
    
    _shapeC = [[HBShapeControl alloc] initWith:_s1 currentRow:row currentCol:col];
    
    for (int i=0; i<_shapeC.layerArray.count; i++)
    {
        HBLayer *ly = _shapeC.layerArray[i];
        [self.mainView.layer addSublayer:ly];
    }

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (YES)
        {
            [NSThread sleepForTimeInterval:0.2];
            if ([_shapeC checkMoveDown:self.mainMap]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_shapeC moveDown];
                });
                HBLayer *ly = _shapeC.layerArray[0];
                NSLog(@"down----%@",NSStringFromCGRect(ly.frame));
            }else{
                [_shapeC StopInMap:self.mainMap];
                return;
            }
        }
    });
}
- (IBAction)rotation
{
    if ([_shapeC checkRotation:self.mainMap])
    {
        [_shapeC switchShape:self.mainMap];
    }
}


/**
 *随机形状
 */
- (HBBase *)randomProduceShape
{
    OneShape *s1 = [[OneShape alloc] init];
    return s1;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setBegin];
}

@end
