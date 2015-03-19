//
//  WTTimer.m
//  HelloWorld
//
//  Created by yuanrui on 15-3-18.
//  Copyright (c) 2015年 KudoCC. All rights reserved.
//

#import "WTTimer.h"

@class TimerDelegateObject ;
@protocol WTTimerDelegate <NSObject>

- (void)wtTimerFired:(TimerDelegateObject *)obj ;

@end

@interface TimerDelegateObject : NSObject

@property (nonatomic, weak) id<WTTimerDelegate> delegate ;

- (void)timerFired:(NSTimer *)timer ;

@end

@implementation TimerDelegateObject

- (void)dealloc
{
    NSLog(@"%@ %@", self, NSStringFromSelector(_cmd)) ;
}

- (void)timerFired:(NSTimer *)timer
{
    [_delegate wtTimerFired:self] ;
}

@end

@interface WTTimer () <WTTimerDelegate>

@property (nonatomic, strong) NSTimer *timer ;

// target and selector
@property (nonatomic, weak) id wtTarget ;
@property (nonatomic) SEL selector ;

// for NSInvocation
@property (nonatomic, strong) NSInvocation *invocation ;

@end

@implementation WTTimer

- (instancetype)initWithFireDate:(NSDate *)date
                        interval:(NSTimeInterval)seconds
                          target:(id)target
                        selector:(SEL)aSelector
                        userInfo:(id)userInfo
                         repeats:(BOOL)repeats
{
    self = [super init] ;
    if (self) {
        _timer = [[NSTimer alloc] initWithFireDate:date interval:seconds target:target selector:aSelector userInfo:userInfo repeats:repeats] ;
    }
    return self ;
}

#pragma mark - Create with NSInvocation

+ (WTTimer *)timerWithTimeInterval:(NSTimeInterval)ti invocation:(NSInvocation *)invocation repeats:(BOOL)yesOrNo
{
    TimerDelegateObject *obj = [[TimerDelegateObject alloc] init] ;
    
    NSDate *dateFire = [NSDate dateWithTimeIntervalSinceNow:ti] ;
    WTTimer *timer = [[WTTimer alloc] initWithFireDate:dateFire
                                              interval:ti
                                                target:obj
                                              selector:@selector(timerFired:)
                                              userInfo:nil
                                               repeats:yesOrNo] ;
    obj.delegate = timer ;
    
    // config WTTimer
    timer.wtTarget = invocation.target ;
    // Because [invocation retainArguments] will retain its target, so set its target to nil and keep it in wtTarget
    invocation.target = nil ;
    [invocation retainArguments] ;
    timer.invocation = invocation ;
    return timer ;
}

+ (WTTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti invocation:(NSInvocation *)invocation repeats:(BOOL)yesOrNo
{
    WTTimer *timer = [WTTimer timerWithTimeInterval:ti invocation:invocation repeats:yesOrNo] ;
    if (timer) {
        [[NSRunLoop currentRunLoop] addTimer:timer.timer forMode:NSDefaultRunLoopMode] ;
    }
    return timer ;
}

#pragma mark - Create with target and selector

+ (WTTimer *)timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo
{
    TimerDelegateObject *obj = [[TimerDelegateObject alloc] init] ;
    
    NSDate *dateFire = [NSDate dateWithTimeIntervalSinceNow:ti] ;
    WTTimer *timer = [[WTTimer alloc] initWithFireDate:dateFire
                                              interval:ti
                                                target:obj
                                              selector:@selector(timerFired:)
                                              userInfo:userInfo
                                               repeats:yesOrNo] ;
    obj.delegate = timer ;
    // config WTTimer
    timer.selector = aSelector ;
    timer.wtTarget = aTarget ;
    return timer ;
}

+ (WTTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo
{
    WTTimer *timer = [self timerWithTimeInterval:ti
                                          target:aTarget
                                        selector:aSelector
                                        userInfo:userInfo
                                         repeats:yesOrNo] ;
    if (timer) {
        [[NSRunLoop currentRunLoop] addTimer:timer.timer forMode:NSDefaultRunLoopMode] ;
    }
    return timer ;
}

#pragma mark - common function

- (void)wtTimerFired:(TimerDelegateObject *)obj
{
    if (_wtTarget) {
        if (_invocation) {
            [_invocation invokeWithTarget:_wtTarget] ;
        } else {
            [_wtTarget performSelector:_selector withObject:self] ;
        }
    } else {
        // the target is deallocated, the timer should be invalidated
        [self.timer invalidate] ;
        NSLog(@"the target is deallocated, the timer is invalidated") ;
    }
}

#pragma mark - override NSTimer

- (NSDate *)fireDate
{
    return [_timer fireDate] ;
}

- (void)setFireDate:(NSDate *)fireDate
{
    _timer.fireDate = fireDate ;
}

- (NSTimeInterval)timeInterval
{
    return [_timer timeInterval] ;
}

- (void)fire
{
    return [_timer fire] ;
}

- (void)invalidate
{
    [_timer invalidate] ;
}

- (BOOL)isValid
{
    return [_timer isValid] ;
}

- (id)userInfo
{
    return _timer.userInfo ;
}

@end