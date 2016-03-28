//
//  BaiDuViewController.m
//  Teacher'sComing
//
//  Created by 杨海凌 on 15/12/8.
//  Copyright © 2015年 YHL. All rights reserved.
//

#import "BaiDuViewController.h"

@interface BaiDuViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation BaiDuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"百度";
    self.webView.delegate = self;
    //在webView中显示百度
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    //加载网页失败
    NSLog(@"加载网页失败");
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
}
@end
