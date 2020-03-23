# whiteboard_demo_ios
--------
## 简介
本Demo展示了怎么使用环信SDK创建和加入白板房间

要求：1.SDK使用3.6.5版本以上的   2.手机系统版本9.0以上

手动和pod导入3.6.5版本以上SDK都支持。 SDK下载链接：http://www.easemob.com/download/im

## Demo实现逻辑
1、在启动app时，会随机注册一个账号登录，如果已登录则会跳过登录

2、根据输入的房间名称和房间密码加入白板房间，如果不存在则去创建对应的白板房间，如果存在直接加入对应的白板房间

3、创建或者加入成功后拿到返回的白板房间url跳转webview加载显示

## 相关SDK方法

/**
 * \~chinese
 * 创建白板房间
 * @param aUsername         用户名
 * @param aToken            用户的token
 * @param aRoomName         房间名
 * @param aPassword         房间的密码
 * @param aCompletionBlock  请求完成的回调
 *
 * \~english
 * create room for whiteboard
 * @param aUsername         username
 * @param aToken            user's token
 * @param aRoomName         room name for whiteboard
 * @param aPassword         password for room
 * @param aCompletionBlock  callback
 */
- (void)createWhiteboardRoomWithUsername:(NSString *)aUsername
                               userToken:(NSString *)aToken
                                roomName:(NSString *)aRoomName
                            roomPassword:(NSString *)aPassword
                              completion:(void(^)(EMWhiteboard *aWhiteboard, EMError *aError))aCompletionBlock;

/**
 * \~chinese
 * 通过白板名称加入房间
 * @param aRoomName         房间名
 * @param aUsername         用户名
 * @param aToken            用户的token
 * @param aPassword         房间的密码
 * @param aCompletionBlock  请求完成的回调
 *
 * \~english
 * join whiteboard room with name
 * @param aRoomName         room name for whiteboard
 * @param aUsername         username
 * @param aToken            user's token
 * @param aPassword         password for room
 * @param aCompletionBlock  callback
 */
- (void)joinWhiteboardRoomWithName:(NSString *)aRoomName
                          username:(NSString *)aUsername
                         userToken:(NSString *)aToken
                      roomPassword:(NSString *)aPassword
                        completion:(void(^)(EMWhiteboard *aWhiteboard, EMError *aError))aCompletionBlock;


/**
 * \~chinese
 * 销毁白板房间
 * @param aUsername         用户名
 * @param aToken            用户的token
 * @param aRoomId           房间id
 * @param aCompletionBlock  请求完成的回调
 *
 * \~english
 * create room for whiteboard
 * @param aUsername         username
 * @param aToken            user's token
 * @param aRoomId           room id for whiteboard
 * @param aCompletionBlock  callback
 */
- (void)destroyWhiteboardRoomWithUsername:(NSString *)aUsername
                                userToken:(NSString *)aToken
                                   roomId:(NSString *)aRoomId
                               completion:(void(^)(EMError *aError))aCompletionBlock;
                               

## SDK方法调用示例：

// 创建白板房间
[[EMClient sharedClient].conferenceManager createWhiteboardRoomWithUsername:@"username" userToken:[EMClient sharedClient].accessUserToken roomName:@"roomName" roomPassword:@"password" completion:^(EMWhiteboard *aWhiteboard, EMError *aError) {
    if (!aError) {
        NSLog(@"创建白板房间成功 --- ");
        NSLog(@"白板房间url --- %@", aWhiteboard.roomURL);
    } else {
        NSLog(@"创建白板房间失败 --- %@", aError.errorDescription);
    }
}];

// 加入白板房间
[[EMClient sharedClient].conferenceManager joinWhiteboardRoomWithName:@"@"roomName"" username:@"username" userToken:[EMClient sharedClient].accessUserToken roomPassword:@"password" completion:^(EMWhiteboard *aWhiteboard, EMError *aError) {
    if (!aError) {
        NSLog(@"加入白板房间成功 --- ");
        NSLog(@"白板房间url --- %@", aWhiteboard.roomURL);
    } else {
        NSLog(@"加入白板房间失败 --- %@", aError.errorDescription);
    }
}];
