//
//  Timer.h
//  WebAuth
//
//  Created by 李大爷的电脑 on 20/10/2016.
//  Copyright © 2016 李大爷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Timer : NSObject

@property (nonatomic) NSInteger cycle;
@property (nonatomic) NSInteger remind;
@property (nonatomic) BOOL notification;

@end
