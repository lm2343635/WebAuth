//
//  ViewController.h
//  WebAuth
//
//  Created by 李大爷 on 15/9/28.
//  Copyright © 2015年 李大爷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

- (IBAction)saveConfig:(id)sender;

- (IBAction)login:(id)sender;

- (IBAction)logout:(id)sender;

@end

