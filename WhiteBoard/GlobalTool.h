//
//  GlobalTool.h
//  HyphenateLogFile
//
//  Created by easemob-DN0164 on 2019/2/27.
//  Copyright © 2019年 easemob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalTool : NSObject

+ (instancetype)shareGlobalTool;

- (void)registerIMUser;

- (void)loginWithUserName:(NSString *)userName;

// 判断字符串是否为中文
- (BOOL)isChinese:(NSString *)string;

@end


