//
//  AboutMeViewController.m
//  iWords
//
//  Created by 张丁豪 on 2017/4/13.
//  Copyright © 2017年 zhangdinghao. All rights reserved.
//

#import "AboutMeViewController.h"

@interface AboutMeViewController ()

@end

@implementation AboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = DHLocalizedString(@"关于我");
    [self getData];
}

- (void)getData{
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    webView.backgroundColor = [UIColor whiteColor];
    webView.opaque = NO;
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"aboutMe.html" ofType:nil];
    NSString *htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                   encoding:NSUTF8StringEncoding
                                                      error:nil];
    [webView loadHTMLString:htmlCont baseURL:baseURL];
    [self.view addSubview:webView];
}

@end
