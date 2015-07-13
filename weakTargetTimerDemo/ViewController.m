//
//  ViewController.m
//  weakTargetTimerDemo
//
//  Created by yuanrui on 15-3-18.
//  Copyright (c) 2015年 KudoCC. All rights reserved.
//

#import "ViewController.h"
#import "WTTimer.h"

@interface TestObj : NSObject

@property (nonatomic, strong) WTTimer *timer1;
@property (nonatomic, strong) WTTimer *timer2;

@end

@implementation TestObj

- (id)init
{
    self = [super init] ;
    if (self) {
        NSLog(@"%@ %@", self, NSStringFromSelector(_cmd)) ;
    }
    return self ;
}

- (void)dealloc
{
    NSLog(@"%@ %@", self, NSStringFromSelector(_cmd)) ;
}

- (void)timerFired:(NSTimer *)timer
{
    NSLog(@"%@, %@", timer, NSStringFromSelector(_cmd)) ;
}

- (void)timerFiredForInvocation:(id)obj
{
    NSLog(@"%@, %@", obj, NSStringFromSelector(_cmd)) ;
}

@end

@interface ViewController ()

@property (nonatomic, strong) TestObj *obj ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _obj = [[TestObj alloc] init] ;
    _obj.timer1 = [WTTimer scheduledTimerWithTimeInterval:2.0 target:_obj selector:@selector(timerFired:) userInfo:nil repeats:YES] ;
    [self performSelector:@selector(delay) withObject:nil afterDelay:5.0] ;
}

- (void)delay
{
    NSLog(@"%@ %@", self, NSStringFromSelector(_cmd)) ;
    
    self.obj = nil ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
