//
//  AppDelegate.m
//  WebAuth
//
//  Created by 李大爷 on 15/9/28.
//  Copyright © 2015年 李大爷. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworking/AFHTTPRequestOperationManager.h"

#define DEBUG 0

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self createItem];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    if([shortcutItem.type isEqualToString:@"login"]) {
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        NSString *username=[defaults objectForKey:@"username"];
        NSString *password=[defaults objectForKey:@"password"];
        [manager POST:@"https://webauth01.cc.tsukuba.ac.jp:8443/cgi-bin/adeflogin.cgi"
           parameters:@{
                        @"name":username,
                        @"pass":password
                        }
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSString *message;
                  if(operation.responseString==nil) {
                      message=@"Login Success";
                  } else  {
                      message=@"Login Failed, check your username and password! Make sure you have saved your config.";
                  }
                  [self showMessage:message];
                  
              }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  if(DEBUG) {
                      NSLog(@"Error: %@", error);
                  }
              }];
    } else if ([shortcutItem.type isEqualToString:@"logout"]) {
        [manager POST:@"https://webauth01.cc.tsukuba.ac.jp:8443/cgi-bin/adeflogout.cgi"
           parameters:nil
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  [self showMessage:@"Logout"];
              }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  if(DEBUG) {
                      NSLog(@"Error: %@", error);
                  }
              }];
    }
}

-(void) createItem {
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

- (void)showMessage: (NSString *)message {
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Tip"
                                                  message:message
                                                 delegate:nil
                                        cancelButtonTitle:@"OK"
                                        otherButtonTitles: nil];
    [alert show];
    
}

@end
