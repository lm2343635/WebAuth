//
//  NetViewController.h
//  WebAuth
//
//  Created by 李大爷的电脑 on 12/10/2016.
//  Copyright © 2016 李大爷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>

#define USERNAME @"username"
#define PASSWORD @"password"

@interface NetViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingActivityIndicatorView;

- (IBAction)login:(id)sender;
- (IBAction)logout:(id)sender;

@end
