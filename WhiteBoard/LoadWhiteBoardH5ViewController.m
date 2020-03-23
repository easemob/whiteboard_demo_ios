//
//  LoadWhiteBoardH5ViewController.m
//  WhiteBoard
//
//  Created by easemob-DN0164 on 2020/3/3.
//  Copyright © 2020 easemob. All rights reserved.
//

#import "LoadWhiteBoardH5ViewController.h"
#import <WebKit/WebKit.h>

@interface LoadWhiteBoardH5ViewController () <WKNavigationDelegate>
{
    WKWebView *_wkWebView;
}
@end

@implementation LoadWhiteBoardH5ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)setupSubviews
{
    WKWebViewConfiguration *config = [WKWebViewConfiguration new];
    config.preferences = [WKPreferences new];
    config.preferences.minimumFontSize = 10;
    config.preferences.javaScriptEnabled = YES;
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    
    _wkWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) configuration:config];
    [_wkWebView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.whiteBoardUrl]]];
    _wkWebView.navigationDelegate = self;
    [self.view addSubview:_wkWebView];
    
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    //如果是跳转一个新页面
    if (navigationAction.targetFrame == nil) {
        [_wkWebView loadRequest:navigationAction.request];
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
