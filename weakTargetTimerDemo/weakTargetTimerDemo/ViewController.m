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

- (void)timerFiredForInvocation:(id)obj intValue:(int)integer
{
    NSLog(@"%@, %@, %d", obj, NSStringFromSelector(_cmd), integer) ;
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
    const NSTimeInterval interval = 2.0;
#if 0
    _obj.timer1 = [WTTimer scheduledTimerWithTimeInterval:interval target:_obj selector:@selector(timerFired:) userInfo:nil repeats:YES] ;
#else
    SEL selector = @selector(timerFiredForInvocation:intValue:);
    NSMethodSignature *methodSig = [_obj methodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
    invocation.target = _obj;
    invocation.selector = selector;
    ViewController *vc = self;
    int aIntValue = 1024;
    [invocation setArgument:&vc atIndex:2];
    [invocation setArgument:&aIntValue atIndex:3];
    _obj.timer1 = [WTTimer scheduledTimerWithTimeInterval:interval invocation:invocation repeats:YES];
#endif
    [self performSelector:@selector(delay) withObject:nil afterDelay:5.0];
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
