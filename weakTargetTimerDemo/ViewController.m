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

@end

@implementation TestObj

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

@property (nonatomic, strong) WTTimer *timer1 ;
@property (nonatomic, strong) WTTimer *timer2 ;

@property (nonatomic, strong) TestObj *obj ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _obj = [[TestObj alloc] init] ;
//    _timer1 = [WTTimer scheduledTimerWithTimeInterval:2.0 target:_obj selector:@selector(timerFired:) userInfo:nil repeats:YES] ;
    
    NSMethodSignature *methodSig = [_obj methodSignatureForSelector:@selector(timerFiredForInvocation:)] ;
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig] ;
    invocation.target = _obj ;
    invocation.selector = @selector(timerFiredForInvocation:) ;
    ViewController *vc = self ;
    [invocation setArgument:&vc atIndex:2] ;
    _timer2 = [WTTimer scheduledTimerWithTimeInterval:2.0 invocation:invocation repeats:YES] ;
    
    NSLog(@"timer is scheduled") ;
    
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
