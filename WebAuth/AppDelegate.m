//
//  AppDelegate.m
//  WebAuth
//
//  Created by 李大爷 on 15/9/28.
//  Copyright © 2015年 李大爷. All rights reserved.
//

#import "AppDelegate.h"
#import "AuthTool.h"
#import "AlertTool.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    //Support 3D Touch
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
        [self createItem];
    }
    
    //Init AFHTTPSessionManager.
    [self httpSessionManager];
    
    return YES;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }

    if([shortcutItem.type isEqualToString:@"login"]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *username = [defaults objectForKey:@"username"];
        NSString *password = [defaults objectForKey:@"password"];
        if ([username isEqualToString:@""] || [password isEqualToString:@""]) {
            return;
        }
        [AuthTool loginWithUsername:username
                           password:password
                           finished:^(BOOL success) {
                               NSString *message = success? @"Login Success!": @"Login Failed, check your username and password and make sure you have connected to network in Tsukuba Univ.";
                               [AlertTool showAlertWithTitle:@"Tip"
                                                  andContent:message
                                            inViewController:self.window.rootViewController];
                           }];
    } else if ([shortcutItem.type isEqualToString:@"logout"]) {
        [AuthTool logout:^(BOOL success) {
            NSString *message = success? @"Logout Success!": @"Logout Failed, make sure you have connected to network in Tsukuba Univ.";
            [AlertTool showAlertWithTitle:@"Tip"
                               andContent:message
                         inViewController:self.window.rootViewController];
        }];
    }
}

-(void)createItem {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    UIMutableApplicationShortcutItem *item1 = [[UIMutableApplicationShortcutItem alloc] initWithType:@"login"
                                                                                      localizedTitle:@"Login"
                                                                                   localizedSubtitle:@"Click to login"
                                                                                                icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeConfirmation]
                                                                                            userInfo:nil];
    UIMutableApplicationShortcutItem *item2 = [[UIMutableApplicationShortcutItem alloc] initWithType:@"logout"
                                                                                      localizedTitle:@"Logout"
                                                                                   localizedSubtitle:@"Click to logout"
                                                                                                icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeProhibit]
                                                                                            userInfo:nil];
    NSArray *addArr = @[item2, item1];
    [UIApplication sharedApplication].shortcutItems = addArr;
}

#pragma mark - AFNetworking
@synthesize httpSessionManager = _httpSessionManager;

- (AFHTTPSessionManager *)httpSessionManager {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    if(_httpSessionManager != nil) {
        return _httpSessionManager;
    }
    _httpSessionManager = [AFHTTPSessionManager manager];
    _httpSessionManager.responseSerializer = [[AFCompoundResponseSerializer alloc] init];
    return _httpSessionManager;
}

@end
