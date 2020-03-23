//
//  GlobalTool.m
//  HyphenateLogFile
//
//  Created by easemob-DN0164 on 2019/2/27.
//  Copyright © 2019年 easemob. All rights reserved.
//

#import "GlobalTool.h"
#import <Hyphenate/Hyphenate.h>
#import "SVProgressHUD.h"

typedef NS_ENUM(NSUInteger, ShowType) {
    ShowTypeSuccess = 1,
    ShowTypeFail = 2,
    ShowTypeNotExist = 3
};
@interface GlobalTool ()

@property (nonatomic, strong) NSString *userName;

@end

static GlobalTool *tool = nil;
@implementation GlobalTool

+ (instancetype)shareGlobalTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[GlobalTool alloc] init];
    });
    return tool;
}

- (void)registerIMUser
{
    NSString *newUserName = [self getRandomUserName];
    NSLog(@"随机的用户id --- %@", newUserName);
    self.userName = newUserName;
    __weak typeof(self) weakSelf = self;
    [[EMClient sharedClient] registerWithUsername:newUserName password:@"123456" completion:^(NSString *aUsername, EMError *aError) {
        if (!aError) {
            NSLog(@"注册成功 --- %@", aUsername);
            [weakSelf loginWithUserName:aUsername];
        } else {
            NSLog(@"注册失败 --- %@", aError.errorDescription);
            switch (aError.code) {
                case 2:
                    [weakSelf svProgressHUD:@"当前无网络连接，请连接网络!" time:3.0 type:ShowTypeFail];
                    break;
                case 203:
                    [weakSelf loginWithUserName:newUserName];
                    break;
                case 300:
                    [weakSelf svProgressHUD:@"网络异常，请切换网络重试!" time:2.0 type:ShowTypeFail];
                    break;
                case 301:
                    [weakSelf svProgressHUD:@"网络异常，请切换网络重试!" time:2.0 type:ShowTypeFail];
                    break;
                case 302:
                    [weakSelf svProgressHUD:@"网络异常，请切换网络重试!" time:2.0 type:ShowTypeFail];
                    break;
                case 303:
                    [weakSelf svProgressHUD:@"网络异常，请切换网络重试!" time:2.0 type:ShowTypeFail];
                    break;
                default:
                    break;
            }
            
        }
    }];
}

- (void)loginWithUserName:(NSString *)userName
{
    __weak typeof(self) weakSelf = self;
    [[EMClient sharedClient] loginWithUsername:userName password:@"123456" completion:^(NSString *aUsername, EMError *aError) {
        if (!aError) {
            [[EMClient sharedClient].options setIsAutoLogin:YES];
        } else {
            switch (aError.code) {
                case 2:
                    [weakSelf svProgressHUD:@"当前无网络连接，请连接网络!" time:3.0 type:ShowTypeFail];
                    break;
                case 300:
                    [weakSelf svProgressHUD:@"网络异常，请切换网络重试!" time:2.0 type:ShowTypeFail];
                    break;
                case 301:
                    [weakSelf svProgressHUD:@"网络异常，请切换网络重试!" time:2.0 type:ShowTypeFail];
                    break;
                case 302:
                    [weakSelf svProgressHUD:@"网络异常，请切换网络重试!" time:2.0 type:ShowTypeFail];
                    break;
                case 303:
                    [weakSelf svProgressHUD:@"网络异常，请切换网络重试!" time:2.0 type:ShowTypeFail];
                    break;
                default:
                    break;
            }
        }
    }];
}

- (NSString *)getRandomUserName
{
    NSString *username = nil;
    UIDevice *device = [UIDevice currentDevice];//创建设备对象
    NSString *deviceUID = [[NSString alloc] initWithString:[[device identifierForVendor] UUIDString]];
    if ([deviceUID length] == 0) {
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        if (uuid)
        {
            deviceUID = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuid);
            CFRelease(uuid);
        }
    }
    username = [deviceUID stringByReplacingOccurrencesOfString:@"-" withString:@""];
    username = [username stringByAppendingString:[NSString stringWithFormat:@"%u",arc4random()%100000]];
    return username;
}

- (BOOL)isChinese:(NSString *)string
{
    for(int i=0; i< [string length];i++){
        int a = [string characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}

// 提示框
- (void)svProgressHUD:(NSString *)text time:(NSTimeInterval)delay type:(int)type
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (type == ShowTypeSuccess) {
            [SVProgressHUD showSuccessWithStatus:text];
        } else if(type == ShowTypeFail) {
            [SVProgressHUD showErrorWithStatus:text];
        } else if (type == ShowTypeNotExist) {
            [SVProgressHUD showInfoWithStatus:text];
        }
        [SVProgressHUD dismissWithDelay:delay];
    });
}

@end
