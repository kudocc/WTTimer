//
//  WTTimer.h
//  weakTargetTimerDemo
//
//  Created by yuanrui on 15-3-18.
//  Copyright (c) 2015年 KudoCC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Weak target timer, when the target is deallocated, the timer don't fire and invalidate itself automatically
 *  Unlike NSTimer, you should keep a strong reference to WTTimer because we invalidate the timer in its dealloc method
 */
@interface WTTimer : NSObject

+ (WTTimer *)timerWithTimeInterval:(NSTimeInterval)ti
                        invocation:(NSInvocation *)invocation
                           repeats:(BOOL)yesOrNo;
+ (WTTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti
                                 invocation:(NSInvocation *)invocation
                                    repeats:(BOOL)yesOrNo;


+ (WTTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti
                                     target:(id)aTarget
                                   selector:(SEL)aSelector
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)yesOrNo;
+ (WTTimer *)timerWithTimeInterval:(NSTimeInterval)ti
                            target:(id)aTarget
                          selector:(SEL)aSelector
                          userInfo:(id)userInfo
                           repeats:(BOOL)yesOrNo;

- (void)fire;

@property (copy) NSDate *fireDate;
@property (readonly) NSTimeInterval timeInterval;

- (void)invalidate;

@property (readonly, getter=isValid) BOOL valid;

@property (readonly, retain) id userInfo;

@end
