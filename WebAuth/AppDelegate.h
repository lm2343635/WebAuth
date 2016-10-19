//
//  AppDelegate.h
//  WebAuth
//
//  Created by 李大爷 on 15/9/28.
//  Copyright © 2015年 李大爷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>

#define URL @"url"
#define TIMER @"timer"
#define CYCLE @"cycle"
#define REMIND @"remind"
#define NOTIFICATION @"notification"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) AFHTTPSessionManager *httpSessionManager;

@end

