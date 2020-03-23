//
//  AppDelegate.m
//  WhiteBoard
//
//  Created by easemob-DN0164 on 2020/3/3.
//  Copyright © 2020 easemob. All rights reserved.
//

#import "AppDelegate.h"
#import <Hyphenate/Hyphenate.h>
#import "JoinWhiteBoardRoomViewController.h"
#import "GlobalTool.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    JoinWhiteBoardRoomViewController *joinVC = [[JoinWhiteBoardRoomViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:joinVC];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    EMOptions *options = [EMOptions optionsWithAppkey:@"easemob-demo#chatdemoui"];
    options.enableConsoleLog = YES;
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    if (![EMClient sharedClient].isLoggedIn) {
        [[GlobalTool shareGlobalTool] registerIMUser];
    }
    
    return YES;
}

@end
