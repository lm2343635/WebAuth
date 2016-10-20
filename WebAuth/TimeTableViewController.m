//
//  TimeTableViewController.m
//  WebAuth
//
//  Created by 李大爷的电脑 on 20/10/2016.
//  Copyright © 2016 李大爷. All rights reserved.
//

#import "TimeTableViewController.h"
#import "AppDelegate.h"
#import "Timer.h"

@interface TimeTableViewController ()

@end

@implementation TimeTableViewController {
    Timer *timer;
}

- (void)viewDidLoad {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [super viewDidLoad];
    
    timer = [[Timer alloc] init];
    if (timer != nil) {
        _cycleLabel.text = [NSString stringWithFormat:@"%ld", timer.cycle];
        _cycleStepper.value = timer.cycle;
        _remindLabel.text = [NSString stringWithFormat:@"%ld", timer.remind];
        _remindStepper.value = timer.remind;
        _notificationSwitch.on = timer.notification;
    }
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    return 0.1;
}

#pragma mark - Action
- (IBAction)changeCycle:(UIStepper *)sender {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    _cycleLabel.text = [NSString stringWithFormat:@"%0.f", sender.value];
    timer.cycle = sender.value;
}

- (IBAction)changeRemind:(UIStepper *)sender {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    _remindLabel.text = [NSString stringWithFormat:@"%0.f", sender.value];
    timer.remind = sender.value;
}

- (IBAction)changeNotification:(UISwitch *)sender {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    timer.notification = sender.on;
}
@end
