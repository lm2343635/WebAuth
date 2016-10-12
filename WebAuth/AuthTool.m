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

+ (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
                 finished:(void (^)(BOOL success))doAfter {
    if (DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    AFHTTPSessionManager *manager = [self httpSessionManager];
    [manager POST:@"https://webauth01.cc.tsukuba.ac.jp:8443/cgi-bin/adeflogin.cgi"
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
    [manager POST:@"https://webauth01.cc.tsukuba.ac.jp:8443/cgi-bin/adeflogout.cgi"
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
