//
//  jsViewController.m
//  imagePickerViewProject
//
//  Created by Lc、 on 16/5/23.
//  Copyright © 2016年 Lc、. All rights reserved.
//

#import "jsViewController.h"

#import <JavaScriptCore/JavaScriptCore.h>


@interface jsViewController ()<UIWebViewDelegate>

@end

@implementation jsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView * view = [[UIWebView alloc]initWithFrame:self.view.frame];
    view.dataDetectorTypes = UIDataDetectorTypeAll;
    [self.view addSubview:view];
    
    view.delegate = self;
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"JSBridgeTest" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    
    [view loadRequest:request];
    //home brew  atom Nuclide
    // Do any additional setup after loading the view.
}


-(void)pushNewVC
{
    NSLog(@"pushVC");

}


-(void)getParam1:(NSString*)str1 withParam2:(NSString*)str2
{
    NSLog(@"收到html传过来的参数：str1=%@,str2=%@",str1,str2);
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlString = [[request URL] absoluteString];
    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"urlString=%@",urlString);
    NSArray *urlComps = [urlString componentsSeparatedByString:@"://"];
    
    if([urlComps count] && [[urlComps objectAtIndex:0] isEqualToString:@"objc"])
    {
        
        NSArray *arrFucnameAndParameter = [(NSString*)[urlComps objectAtIndex:1] componentsSeparatedByString:@":/"];
        NSString *funcStr = [arrFucnameAndParameter objectAtIndex:0];
        
        if (1 == [arrFucnameAndParameter count])
        {
            // 没有参数
            if([funcStr isEqualToString:@"doFunc1"])
            {
                
                /*调用本地函数1*/
                NSLog(@"doFunc1");
                
            }
        }
        else
        {
            //有参数的
            if([funcStr isEqualToString:@"getParam1:withParam2:"])
            {
                [self getParam1:[arrFucnameAndParameter objectAtIndex:1] withParam2:[arrFucnameAndParameter objectAtIndex:2]];
            }
        }
        return NO;
    }
    return TRUE;
}


@end
