//
//  NetViewController.m
//  WebAuth
//
//  Created by 李大爷的电脑 on 12/10/2016.
//  Copyright © 2016 李大爷. All rights reserved.
//

#import "NetViewController.h"
#import "AuthTool.h"
#import "AlertTool.h"

@interface NetViewController ()

@end

@implementation NetViewController {
    AFHTTPSessionManager *manager;
    NSUserDefaults *defaults;
}

- (void)viewDidLoad {
    if (DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [super viewDidLoad];
    defaults = [NSUserDefaults standardUserDefaults];
    [AuthTool refreshConnectURL:^(BOOL success) {
        if (!success) {
            [AlertTool showAlertWithTitle:@"Tip"
                               andContent:NSLocalizedString(@"connect_tsukuba_network", @"Make sure you have accessed to the network in Tsukuba Univ.")
                         inViewController:self];
        }
    }];
    NSString *username = [defaults objectForKey:USERNAME];
    NSString *password = [defaults objectForKey:PASSWORD];
    if (![username isEqualToString:@""]) {
        _usernameTextField.text = username;
    }
    if (![password isEqualToString:@""]) {
        _passwordTextField.text = password;
    }
    [self setCloseKeyboardAccessoryForSender:_usernameTextField];
    [self setCloseKeyboardAccessoryForSender:_passwordTextField];
}

- (IBAction)login:(id)sender {
    if (DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    if ([_usernameTextField.text isEqualToString:@""] || [_passwordTextField.text isEqualToString:@""]) {
        [AlertTool showAlertWithTitle:@"Tip"
                           andContent:@"Input username and password!"
                     inViewController:self];
        return;
    }
    [defaults setObject:_usernameTextField.text forKey:USERNAME];
    [defaults setObject:_passwordTextField.text forKey:PASSWORD];

    _loginButton.enabled = NO;
    _loadingActivityIndicatorView.hidden = NO;
    [AuthTool loginWithUsername:_usernameTextField.text
                       password:_passwordTextField.text
                       finished:^(BOOL success) {
                           _loginButton.enabled = YES;
                           _loadingActivityIndicatorView.hidden = YES;
                           NSString *message = success? NSLocalizedString(@"login_success", nil): NSLocalizedString(@"login_failed", nil);
                           [AlertTool showAlertWithTitle:NSLocalizedString(@"tip_name", nil)
                                              andContent:message
                                        inViewController:self];
                       }];
}

- (IBAction)logout:(id)sender {
    if (DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [AuthTool logout:^(BOOL success) {
        NSString *message = success? NSLocalizedString(@"logout_success", nil): NSLocalizedString(@"logout_failed", nil);
        [AlertTool showAlertWithTitle:NSLocalizedString(@"tip_name", nil)
                           andContent:message
                     inViewController:self];
    }];
}

#pragma mark - Service
//Create done button for keyboard
- (void)setCloseKeyboardAccessoryForSender:(id)sender {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.window.frame.size.width, 35)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem* spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                     target:self
                                                                                     action:nil];
    UIBarButtonItem *doneButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                    target:self
                                                                                    action:@selector(editFinish)];
    doneButtonItem.tintColor = [UIColor colorWithRed:38/255.0 green:186/255.0 blue:152/255.0 alpha:1.0];
    NSArray * buttonsArray = [NSArray arrayWithObjects:spaceButtonItem, doneButtonItem, nil];
    [topView setItems:buttonsArray];
    [sender setInputAccessoryView:topView];
}

- (void)editFinish {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    for(id input in self.view.subviews){
        if([input isKindOfClass:[UITextField class]]){
            UITextField *this = input;
            if([this isFirstResponder]) {
                [this resignFirstResponder];
            }
        } else if ([input isKindOfClass:[UITextView class]]) {
            UITextView *this = input;
            if ([this isFirstResponder]) {
                [this resignFirstResponder];
            }
        }
    }
}

@end
