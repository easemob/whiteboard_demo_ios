//
//  JoinWhiteBoardRoomViewController.m
//  WhiteBoard
//
//  Created by easemob-DN0164 on 2020/3/3.
//  Copyright © 2020 easemob. All rights reserved.
//

#import "JoinWhiteBoardRoomViewController.h"
#import "LoadWhiteBoardH5ViewController.h"
#import "Masonry.h"
#import "UIViewController+HUD.h"
#import "GlobalTool.h"
#import <Hyphenate/Hyphenate.h>

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@interface JoinWhiteBoardRoomViewController () <UITextFieldDelegate>
{
    CGFloat _boardHeight;
}
@property (nonatomic, strong) UIView *backgroudView;
@property (nonatomic, strong) UIView *logoBackgroudView;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *logoTitleLabel;
@property (nonatomic, strong) UILabel *whiteBoardTtileLabel;
@property (nonatomic, strong) UITextField *roomNameTextFiled;
@property (nonatomic, strong) UITextField *roomPasswordTextFiled;
@property (nonatomic, strong) UIButton *joinRoomButton;

@property (nonatomic, strong) NSString *roomName;
@property (nonatomic, strong) NSString *roomPassword;

@end

@implementation JoinWhiteBoardRoomViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    
    
    
    [self setupSubView];
    

}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat keyboardHeight = keyboardRect.size.height;
    
    CGFloat a = [UIScreen mainScreen].bounds.size.height - 530;
    if (a >= keyboardHeight) {
        
    } else {
        [self changeBackgroundFrame:-(keyboardHeight - a + 20)];
    }
}


//当键盘退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    [self changeBackgroundFrame:0];
}

- (void)changeBackgroundFrame:(CGFloat)value
{
    CGRect frame = self.backgroudView.frame;
    frame.origin.y = value;
    self.backgroudView.frame = frame;
}

- (void)setupSubView
{
    self.backgroudView = [[UIView alloc] init];
    self.backgroudView.backgroundColor = [UIColor whiteColor];
    self.backgroudView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:self.backgroudView];
    
    self.logoBackgroudView = [[UIView alloc] init];
    [self.backgroudView addSubview:self.logoBackgroudView];
    [self.logoBackgroudView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@140);
        make.height.equalTo(@70);
        make.width.equalTo(@180);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    self.logoImageView = [[UIImageView alloc] init];
    self.logoImageView.image = [UIImage imageNamed:@"环信logo"];
    [self.logoBackgroudView addSubview:self.logoImageView];
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoBackgroudView).offset(5);
        make.left.equalTo(self.logoBackgroudView);
        make.bottom.equalTo(self.logoBackgroudView).offset(-5);
        make.width.height.equalTo(@60);
    }];

    self.logoTitleLabel = [[UILabel alloc] init];
    self.logoTitleLabel.text = @"环信";
    self.logoTitleLabel.textColor = RGBACOLOR(55.0, 148.0, 206.0, 1);
    self.logoTitleLabel.font = [UIFont systemFontOfSize:52.0];
    [self.logoBackgroudView addSubview:self.logoTitleLabel];
    [self.logoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.logoBackgroudView);
    }];
    
    self.whiteBoardTtileLabel = [[UILabel alloc] init];
    self.whiteBoardTtileLabel.text = @"互动白板";
    self.whiteBoardTtileLabel.textColor = [UIColor redColor];
    self.whiteBoardTtileLabel.font = [UIFont systemFontOfSize:20.0];
    [self.backgroudView addSubview:self.whiteBoardTtileLabel];
    [self.whiteBoardTtileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImageView.mas_bottom).offset(50);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    self.roomNameTextFiled = [[UITextField alloc] init];
    self.roomNameTextFiled.delegate = self;
    self.roomNameTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.roomNameTextFiled.tag = 1;
    self.roomNameTextFiled.layer.borderColor = [UIColor grayColor].CGColor;
    self.roomNameTextFiled.layer.borderWidth = 0.5;
    self.roomNameTextFiled.layer.cornerRadius = 5.0;
    self.roomNameTextFiled.layer.masksToBounds = YES;
    self.roomNameTextFiled.placeholder = @"房间名称";
    UIView *nameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    UIImageView *nameImage = [[UIImageView alloc] init];
    nameImage.frame = CGRectMake(0, 10, 15, 15);
    [nameLeftView addSubview:nameImage];
    self.roomNameTextFiled.leftView = nameLeftView;
    self.roomNameTextFiled.leftViewMode = UITextFieldViewModeAlways;
    self.roomNameTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.backgroudView addSubview:self.roomNameTextFiled];
    [self.roomNameTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteBoardTtileLabel.mas_bottom).offset(55);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.height.equalTo(@50);
    }];
    
    self.roomPasswordTextFiled = [[UITextField alloc] init];
    self.roomPasswordTextFiled.delegate = self;
    self.roomPasswordTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.roomPasswordTextFiled.tag = 2;
    self.roomPasswordTextFiled.returnKeyType = UIReturnKeyDone;
    self.roomPasswordTextFiled.secureTextEntry = YES;
    self.roomPasswordTextFiled.layer.borderColor = [UIColor grayColor].CGColor;
    self.roomPasswordTextFiled.layer.borderWidth = 0.5;
    self.roomPasswordTextFiled.layer.cornerRadius = 5.0;
    self.roomPasswordTextFiled.layer.masksToBounds = YES;
    self.roomPasswordTextFiled.placeholder = @"房间密码";
    UIView *passwordLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    UIImageView *passwordImage = [[UIImageView alloc] init];
    passwordImage.frame = CGRectMake(0, 10, 15, 15);
    [passwordLeftView addSubview:passwordImage];
    self.roomPasswordTextFiled.leftView = passwordLeftView;
    self.roomPasswordTextFiled.leftViewMode = UITextFieldViewModeAlways;
    self.roomPasswordTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.backgroudView addSubview:self.roomPasswordTextFiled];
    [self.roomPasswordTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.roomNameTextFiled.mas_bottom).offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.height.equalTo(@50);
    }];
    
    self.joinRoomButton = [[UIButton alloc] init];
    self.joinRoomButton.backgroundColor = RGBACOLOR(166.0, 196.0, 214.0, 1);
    [self.joinRoomButton setTitle:@"加入房间" forState:UIControlStateNormal];
    [self.joinRoomButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    [self.joinRoomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.joinRoomButton.layer.cornerRadius = 20.0;
    self.joinRoomButton.layer.masksToBounds = YES;
    [self.joinRoomButton addTarget:self action:@selector(joinRoomClick) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroudView addSubview:self.joinRoomButton];
    [self.joinRoomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.roomPasswordTextFiled.mas_bottom).offset(35);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.height.equalTo(@40);
    }];
    
}

- (void)joinRoomClick
{
    [self.roomNameTextFiled endEditing:YES];
    [self.roomPasswordTextFiled endEditing:YES];
    
    if (self.roomName.length == 0 || self.roomPassword.length == 0) {
        [self showHint:@"房间名称,密码不能为空!"];
        return ;
    }
    
    if (self.roomPassword.length != 0) {
        if ([[GlobalTool shareGlobalTool] isChinese:self.roomPassword]) {
            [self showHint:@"密码不能中文!"];
            return ;
        }
    }
    
    if (![EMClient sharedClient].isConnected) {
        [self showHint:@"当前无网络连接，请连接网络!"];
        return ;
    }
    
    NSString *username = [EMClient sharedClient].currentUsername;
    if (username.length == 0) {
        [self showHint:@"加入房间失败，请重新加入!"];
        [[GlobalTool shareGlobalTool] registerIMUser];
        return ;
    }
    
    [self showHudInView:self.view hint:@"正在加入房间..."];
    __weak typeof(self) weakself = self;
    [[EMClient sharedClient].conferenceManager joinWhiteboardRoomWithName:self.roomName username:[EMClient sharedClient].currentUsername userToken:[EMClient sharedClient].accessUserToken roomPassword:self.roomPassword completion:^(EMWhiteboard *aWhiteboard, EMError *aError) {
        if (!aError) {
            [weakself hideHud];
            LoadWhiteBoardH5ViewController *loadVC = [[LoadWhiteBoardH5ViewController alloc] init];
            loadVC.whiteBoardUrl = aWhiteboard.roomURL;
            [self.navigationController pushViewController:loadVC animated:YES];
        } else {
            if (aError.code == EMErrorCallRoomNotExist) {
                [[EMClient sharedClient].conferenceManager createWhiteboardRoomWithUsername:[EMClient sharedClient].currentUsername userToken:[EMClient sharedClient].accessUserToken roomName:self.roomName roomPassword:self.roomPassword interact:YES completion:^(EMWhiteboard *aWhiteboard, EMError *aError) {
                    [weakself hideHud];
                    if (!aError) {
                        LoadWhiteBoardH5ViewController *loadVC = [[LoadWhiteBoardH5ViewController alloc] init];
                        loadVC.whiteBoardUrl = aWhiteboard.roomURL;
                        [weakself.navigationController pushViewController:loadVC animated:YES];
                    } else {
                        [weakself showHint:aError.errorDescription];
                    }
                }];
            } else {
                [weakself hideHud];
                [weakself showHint:aError.errorDescription];
            }
        }
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self changeBackgroundFrame:0];
    [self.roomNameTextFiled endEditing:YES];
    [self.roomPasswordTextFiled endEditing:YES];
}

#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 1) {
        self.roomName = textField.text;
    } else {
        self.roomPassword = textField.text;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.returnKeyType == UIReturnKeyDone)
    {
        [textField endEditing:YES];
    }
    return YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

@end
