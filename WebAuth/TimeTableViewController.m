//
//  TimeTableViewController.m
//  WebAuth
//
//  Created by 李大爷的电脑 on 20/10/2016.
//  Copyright © 2016 李大爷. All rights reserved.
//

#import "TimeTableViewController.h"
#import "AppDelegate.h"

@interface TimeTableViewController ()

@end

@implementation TimeTableViewController {
    NSUserDefaults *defaults;
    NSDictionary *timer;
}

- (void)viewDidLoad {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [super viewDidLoad];
    defaults = [NSUserDefaults standardUserDefaults];
    timer = [defaults valueForKey:TIMER];
    
    double cycle = [[timer objectForKey:CYCLE] doubleValue];
    double remind = [[timer objectForKey:REMIND] doubleValue];
    if (timer != nil) {
        _cycleLabel.text = [NSString stringWithFormat:@"%.0f", cycle];
        _cycleStepper.value = cycle;
        _remindLabel.text = [NSString stringWithFormat:@"%.0f", remind];
        _remindStepper.value = remind;
        _notificationSwitch.on = [timer valueForKey:NOTIFICATION];
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
    [timer setValue:[NSNumber numberWithDouble:sender.value] forKey:CYCLE];
    [defaults setObject:timer forKey:TIMER];
}

- (IBAction)changeRemind:(UIStepper *)sender {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    _remindLabel.text = [NSString stringWithFormat:@"%0.f", sender.value];
    [timer setValue:[NSNumber numberWithDouble:sender.value] forKey:REMIND];
    [defaults setObject:timer forKey:TIMER];
}
@end
