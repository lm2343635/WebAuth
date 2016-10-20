//
//  Timer.m
//  WebAuth
//
//  Created by 李大爷的电脑 on 20/10/2016.
//  Copyright © 2016 李大爷. All rights reserved.
//

#import "Timer.h"

@implementation Timer {
    NSUserDefaults *defaults;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        defaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

@synthesize cycle = _cycle;

- (void)setCycle:(NSInteger)cycle {
    _cycle = cycle;
    [defaults setInteger:_cycle forKey:NSStringFromSelector(@selector(cycle))];
}

- (NSInteger)cycle {
    if(_cycle == 0) {
        _cycle = [defaults integerForKey:NSStringFromSelector(@selector(cycle))];
    }
    return _cycle;
}

@synthesize remind = _remind;

- (void)setRemind:(NSInteger)remind {
    _remind = remind;
    [defaults setInteger:_remind forKey:NSStringFromSelector(@selector(remind))];
}

- (NSInteger)remind {
    if (_remind == 0) {
        _remind = [defaults integerForKey:NSStringFromSelector(@selector(remind))];
    }
    return _remind;
}

@synthesize notification = _notification;

- (void)setNotification:(BOOL)notification {
    [defaults setBool:notification forKey:NSStringFromSelector(@selector(notification))];
}

- (BOOL)notification {
    return [defaults boolForKey:NSStringFromSelector(@selector(notification))];
}

@end
