//
//  ViewController.m
//  squre_v2.0
//
//  Created by hanbing on 15/1/14.
//  Copyright (c) 2015年 feinaide. All rights reserved.
//

#import "ViewController.h"
#import "OneShape.h"
@interface ViewController ()
@property(nonatomic,strong) OneShape *one;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _one = [[OneShape alloc] init];
}


- (void)testChangeShape
{
    [_one changeShape];
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self testChangeShape];
    
    NSLog(@"----%@",_one);
}

@end
