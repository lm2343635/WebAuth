//
//  AuthTool.m
//  WebAuth
//
//  Created by 李大爷的电脑 on 12/10/2016.
//  Copyright © 2016 李大爷. All rights reserved.
//

#import "AuthTool.h"

@implementation AuthTool

+ (AFHTTPSessionManager *)httpSessionManager {
    if (DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    return [(AppDelegate *)[[UIApplication sharedApplication] delegate] httpSessionManager];
}

+ (void)refreshConnectURL:(void (^)(BOOL success))doAfter {
    if (DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    AFHTTPSessionManager *manager = [self httpSessionManager];
    [manager GET:@"http://www.cc.tsukuba.ac.jp/wp/service/notice/"
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSString *html = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             if ([html containsString:@"form method=\"get\" action=\""]) {
                 NSString *url = [[[[html componentsSeparatedByString:@"form method=\"get\" action=\""] objectAtIndex:1] componentsSeparatedByString:@"\">"] objectAtIndex:0];
                 [[NSUserDefaults standardUserDefaults] setObject:url forKey:@"url"];
                 doAfter(YES);
             } else {
                 doAfter(NO);
             }
             
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             if (DEBUG) {
                 NSLog(@"Error: %@", error.localizedDescription);
             }
         }];
}

+ (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
                 finished:(void (^)(BOOL success))doAfter {
    if (DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    AFHTTPSessionManager *manager = [self httpSessionManager];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [manager POST:[NSString stringWithFormat:@"%@cgi-bin/adeflogin.cgi", [defaults objectForKey:URL]]
       parameters:@{
                    @"name":username,
                    @"pass":password
                    }
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              doAfter([[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] == nil);
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              doAfter(NO);
          }];
}

+ (void)logout:(void (^)(BOOL success))doAfter {
    if (DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    AFHTTPSessionManager *manager = [self httpSessionManager];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [manager POST:[NSString stringWithFormat:@"%@cgi-bin/adeflogout.cgi", [defaults objectForKey:URL]]
       parameters:nil
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              doAfter(YES);
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              doAfter(NO);
          }];
}

@end
