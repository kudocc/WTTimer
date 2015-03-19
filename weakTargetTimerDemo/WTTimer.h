//
//  WTTimer.h
//  HelloWorld
//
//  Created by yuanrui on 15-3-18.
//  Copyright (c) 2015年 KudoCC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Weak target timer, when the target is deallocated, the timer don't fire and invalidate itself automatically
 *  Never use its - (instancetype)initWithFireDate:(NSDate *)date interval:(NSTimeInterval)seconds target:(id)target selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)repeats method
 */
@interface WTTimer : NSObject

+ (WTTimer *)timerWithTimeInterval:(NSTimeInterval)ti invocation:(NSInvocation *)invocation repeats:(BOOL)yesOrNo;
+ (WTTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti invocation:(NSInvocation *)invocation repeats:(BOOL)yesOrNo;

+ (WTTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo;
+ (WTTimer *)timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo;

- (void)fire;

@property (copy) NSDate *fireDate;
@property (readonly) NSTimeInterval timeInterval;

- (void)invalidate;

@property (readonly, getter=isValid) BOOL valid;

@property (readonly, retain) id userInfo;

@end
