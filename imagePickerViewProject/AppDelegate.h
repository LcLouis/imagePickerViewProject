//
//  AppDelegate.h
//  imagePickerViewProject
//
//  Created by Lc、 on 16/3/19.
//  Copyright © 2016年 Lc、. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (copy) void (^backgroundSessionCompletionHandler)();

@end

