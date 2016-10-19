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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:URL] == nil) {
        [defaults setObject:@"https://webauth01.cc.tsukuba.ac.jp:8443/" forKey:URL];
    }
    if ([defaults objectForKey:TIMER] == nil) {
        [defaults setObject:@{
                              CYCLE: @24,
                              REMIND: @30,
                              NOTIFICATION: @YES
                              }
                     forKey:TIMER];
    }
    
    //Register local notification
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        [application registerUserNotificationSettings:settings];
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
                               NSString *message = success? NSLocalizedString(@"login_success", nil): NSLocalizedString(@"login_failed", nil);
                               [AlertTool showAlertWithTitle:NSLocalizedString(@"tip_name", nil)
                                                  andContent:message
                                            inViewController:self.window.rootViewController];
                           }];
    } else if ([shortcutItem.type isEqualToString:@"logout"]) {
        [AuthTool logout:^(BOOL success) {
            NSString *message = success? NSLocalizedString(@"logout_success", nil): NSLocalizedString(@"logout_failed", nil);
            [AlertTool showAlertWithTitle:NSLocalizedString(@"tip_name", nil)
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
                                                                                      localizedTitle:NSLocalizedString(@"login_name", nil)
                                                                                   localizedSubtitle:NSLocalizedString(@"login_tip", nil)
                                                                                                icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeConfirmation]
                                                                                            userInfo:nil];
    UIMutableApplicationShortcutItem *item2 = [[UIMutableApplicationShortcutItem alloc] initWithType:@"logout"
                                                                                      localizedTitle:NSLocalizedString(@"logout_name", nil)
                                                                                   localizedSubtitle:NSLocalizedString(@"logout_tip", nil)
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
