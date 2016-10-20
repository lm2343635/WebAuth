//
//  TimeTableViewController.h
//  WebAuth
//
//  Created by 李大爷的电脑 on 20/10/2016.
//  Copyright © 2016 李大爷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *cycleLabel;
@property (weak, nonatomic) IBOutlet UILabel *remindLabel;
@property (weak, nonatomic) IBOutlet UIStepper *cycleStepper;
@property (weak, nonatomic) IBOutlet UIStepper *remindStepper;
@property (weak, nonatomic) IBOutlet UISwitch *notificationSwitch;

- (IBAction)changeCycle:(UIStepper *)sender;
- (IBAction)changeRemind:(UIStepper *)sender;
- (IBAction)changeNotification:(UISwitch *)sender;
@end
