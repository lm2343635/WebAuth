//
//  AuthTool.h
//  WebAuth
//
//  Created by 李大爷的电脑 on 12/10/2016.
//  Copyright © 2016 李大爷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface AuthTool : NSObject

+ (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
                 finished:(void (^)(BOOL success))downloadProgress;

+ (void)logout:(void (^)(BOOL success))doAfter;

@end
