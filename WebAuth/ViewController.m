//
//  ViewController.m
//  WebAuth
//
//  Created by 李大爷 on 15/9/28.
//  Copyright © 2015年 李大爷. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "AFNetworking.h"

#define DEBUG 1

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(DEBUG)
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *username=[defaults objectForKey:@"username"];
    NSString *password=[defaults objectForKey:@"password"];
    if(![username isEqualToString:@""])
        self.usernameTextField.text=username;
    if(![password isEqualToString:@""])
        self.passwordTextField.text=password;
    if(![username isEqualToString:@""]&&![password isEqualToString:@""])
        self.loginButton.enabled=YES;
}


- (IBAction)saveConfig:(id)sender {
    if(DEBUG)
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    NSString *username=self.usernameTextField.text;
    NSString *password=self.passwordTextField.text;
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:username forKey:@"username"];
    [defaults setObject:password forKey:@"password"];
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self showMessage:@"Your username and password have been saved."];
    if(![username isEqualToString:@""]&&![password isEqualToString:@""])
        self.loginButton.enabled=YES;
    else
        self.loginButton.enabled=NO;
}

- (IBAction)login:(id)sender {
    if(DEBUG)
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    self.loginButton.enabled=NO;
    [self login];
}

- (IBAction)logout:(id)sender {
    if(DEBUG)
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    self.logoutButton.enabled=NO;
    [self logout];
}

- (void)showMessage: (NSString *)message {
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Tip"
                                                  message:message
                                                 delegate:nil
                                        cancelButtonTitle:@"OK"
                                        otherButtonTitles: nil];
    [alert show];

}

- (void)login {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *username=[defaults objectForKey:@"username"];
    NSString *password=[defaults objectForKey:@"password"];
    [manager POST:@"https://webauth01.cc.tsukuba.ac.jp:8443/cgi-bin/adeflogin.cgi"
       parameters:@{
                    @"name":username,
                    @"pass":password
                    }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              self.loginButton.enabled=YES;
              NSString *message;
              if(operation.responseString==nil) {
                  message=@"Login Success";
              } else  {
                  message=@"Login Failed, check your username and password! Make sure you have saved your config.";
              }
              [self showMessage:message];
              
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              self.loginButton.enabled=YES;
              if(DEBUG) {
                  NSLog(@"Error: %@", error);
              }
          }];
}

- (void)logout {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:@"https://webauth01.cc.tsukuba.ac.jp:8443/cgi-bin/adeflogout.cgi"
       parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              self.logoutButton.enabled=YES;
              [self showMessage:@"Logout"];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              self.logoutButton.enabled=YES;
              if(DEBUG) {
                  NSLog(@"Error: %@", error);
              }
          }];
}
@end
