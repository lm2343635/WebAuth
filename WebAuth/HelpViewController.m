//
//  HelpViewController.m
//  WebAuth
//
//  Created by 李大爷的电脑 on 18/11/2016.
//  Copyright © 2016 李大爷. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

- (void)viewDidLoad {
    if (DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [super viewDidLoad];
    NSLog(@"%@", [[NSLocale currentLocale] localeIdentifier]);
    NSString *lan = [[[[NSLocale currentLocale] localeIdentifier] componentsSeparatedByString:@"_"] objectAtIndex:0];
    lan = [[lan componentsSeparatedByString:@"-"] objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"help.%@", lan];
    NSURL *url = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:fileName ofType:@"html"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}


@end
