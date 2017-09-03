//
//  LoginVC.m
//  爱尚问
//
//  Created by Mac on 17/9/1.
//  Copyright © 2017年 杜浩. All rights reserved.
//

#import "LoginVC.h"
#import "RegisterVC.h"
#import "ForgetPasswordVC.h"
#import "ChangePassVC.h"
#import "MainVC.h"
@interface LoginVC ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField * phoneTF;//手机号码
@property(nonatomic,strong)UITextField * passwordTF;//密码
@property(nonatomic,strong)UILabel * checkLabel;//检测手机号

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载主界面
    [self loadMainView];
}
//加载主界面
-(void)loadMainView{
    //返回按钮
    self.view.backgroundColor = [UIColor whiteColor];
    //注册按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(registerBtnCallback)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    //手机号码
    float top = 30;
    float height = 40;
    float left1 = 30;
    float left2 = 55;
    {
        //背景view
        UIView * view = [UIView new];
        {
            view.frame = CGRectMake(20, top, WIDTH - 40, height);
            view.layer.masksToBounds = true;
            view.layer.borderWidth = 1;
            view.layer.borderColor = [MYCOLOR_240_240_240 CGColor];
            [self.view addSubview:view];
            view.layer.cornerRadius = height/2.0;
        }
        //图标
        {
            UIImageView * icon = [UIImageView new];
            icon.image = [UIImage imageNamed:@"phone"];
            [view addSubview:icon];
            icon.frame = CGRectMake(left1, 13, 10, 14);
        }
        //文本框
        {
            UITextField * tf = [UITextField new];
            tf.placeholder = @"手机号码";
            tf.font = [MYFONT fontLittleWithFontSize:14];
            tf.frame = CGRectMake(left2, 10, WIDTH - left2 - 40, 20);
            tf.delegate = self;
            tf.tag = 100;
            tf.keyboardType = UIKeyboardTypeNumberPad;
            [view addSubview:tf];
            self.phoneTF = tf;
        }
        //手机号码检测
        {
            UILabel * label = [UILabel new];
            self.checkLabel = label;
            label.frame = CGRectMake(30, top + 45, WIDTH - 60, 15);
            label.font = [MYFONT fontLittleWithFontSize:12];
            label.textColor = [MYTOOL RGBWithRed:255 green:101 blue:101 alpha:1];
            [self.view addSubview:label];
            label.text = @"";
        }
        
        top += height + 40;
    }
    //密码
    {
        //背景view
        UIView * view = [UIView new];
        {
            view.frame = CGRectMake(20, top, WIDTH - 40, height);
            view.layer.masksToBounds = true;
            view.layer.borderWidth = 1;
            view.layer.borderColor = [MYCOLOR_240_240_240 CGColor];
            [self.view addSubview:view];
            view.layer.cornerRadius = height/2.0;
        }
        //图标
        {
            UIImageView * icon = [UIImageView new];
            icon.image = [UIImage imageNamed:@"yzma"];
            [view addSubview:icon];
            icon.frame = CGRectMake(left1, 20-11/2.0, 14, 11);
        }
        //文本框
        {
            UITextField * tf = [UITextField new];
            tf.placeholder = @"设置登录密码";
            tf.font = [MYFONT fontLittleWithFontSize:14];
            tf.frame = CGRectMake(left2, 10, WIDTH - left2 - 40, 20);
            [view addSubview:tf];
            tf.tag = 400;
            tf.delegate = self;
            self.passwordTF = tf;
        }
        
        
        top += height + 28;
    }
    //登录按钮
    {
        UIButton * btn = [UIButton new];
        btn.frame = CGRectMake(20, top, WIDTH - 40, 40);
        btn.titleLabel.font = [MYFONT fontBigWithFontSize:20];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [btn setTitle:@"登 录" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(loginCallback) forControlEvents:UIControlEventTouchUpInside];
    }
    top += 40 + 20;
    //更改密码
    {
        UIButton * btn = [UIButton new];
        [btn addTarget:self action:@selector(changePassword) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"更改密码" forState:UIControlStateNormal];
        btn.titleLabel.font = [MYFONT fontLittleWithFontSize:12];
        [btn setTitleColor:[MYTOOL RGBWithRed:112 green:112 blue:112 alpha:1] forState:UIControlStateNormal];
        float width = 60;
        btn.frame = CGRectMake(20, top, width, 13);
        [self.view addSubview:btn];
    }
    //忘记密码
    {
        UIButton * btn = [UIButton new];
        [btn addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"忘记密码?" forState:UIControlStateNormal];
        btn.titleLabel.font = [MYFONT fontLittleWithFontSize:12];
        [btn setTitleColor:[MYTOOL RGBWithRed:112 green:112 blue:112 alpha:1] forState:UIControlStateNormal];
        float width = 60;
        btn.frame = CGRectMake(WIDTH-20-width, top, width, 13);
        [self.view addSubview:btn];
    }
    
    
}
//更改密码事件
-(void)changePassword{
    ChangePassVC * vc = [ChangePassVC new];
    vc.title = @"更改密码";
    [self.navigationController pushViewController:vc animated:true];
}
//忘记密码事件
-(void)forgetPassword{
    ForgetPasswordVC * vc = [ForgetPasswordVC new];
    vc.title = @"忘记密码";
    [self.navigationController pushViewController:vc animated:true];
}
//登录事件
-(void)loginCallback{
    //参数
    NSString * mobile = self.phoneTF.text;//手机号
    NSString * password = self.passwordTF.text;//密码
    //验证
    {
        //手机号
        {
            //正则表达式匹配11位手机号码
            BOOL isMatch = [MYTOOL isMatchPhoneNumber:mobile];
            if (!isMatch) {
                [SVProgressHUD showErrorWithStatus:@"手机号格式不正确" duration:2];
                return;
            }
        }
        //密码
        {
            if (password.length < 6) {
                [SVProgressHUD showErrorWithStatus:@"密码不能少于6位" duration:2];
                return;
            }
        }
    }
    NSString * interface = @"/user/login.app";
    NSDictionary * send = @{
                            @"user_name":mobile,
                            @"user_pass":password
                            };
    [MYTOOL netWorkingWithTitle:@"登录中……"];
    [MYNETWORKING getDataWithInterfaceName:interface andDictionary:send andSuccess:^(NSDictionary *back_dic, NSString *msg) {
        [SVProgressHUD showSuccessWithStatus:msg duration:1];
        //页面跳转
        MainVC * vc = [MainVC new];
        MY_APP_DELEGATE.window.rootViewController = vc;
        //已登录保存
        //把登录状态写进程序
        [MYTOOL setProjectPropertyWithKey:@"isLogin" andValue:@"1"];
        [MYTOOL setProjectPropertyWithKey:@"user_id" andValue:back_dic[@"user_id"]];
        MYTOOL.userInfo = back_dic;
    } andNoSuccess:^(NSDictionary *back_dic, NSString *msg) {
        [SVProgressHUD showErrorWithStatus:msg duration:2];
    } andFailure:^(NSURLSessionTask *operation, NSError *error) {
        
    }];
    
    
}
#pragma mark - UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag != 100) {
        return;
    }
    NSString * mobile = textField.text;
    //正则表达式匹配11位手机号码
    BOOL isMatch = [MYTOOL isMatchPhoneNumber:mobile];
    if (!isMatch) {
        self.checkLabel.text = @"手机格式不正确";
        self.checkLabel.textColor = [MYTOOL RGBWithRed:255 green:101 blue:101 alpha:1];
    }else{
        self.checkLabel.text = @"手机格式正确";
        self.checkLabel.textColor = MYCOLOR_40_199_0;
    }
}
//注册
-(void)registerBtnCallback{
    RegisterVC * vc = [RegisterVC new];
    vc.title = @"注册";
    [self.navigationController pushViewController:vc animated:true];
}
//返回上个界面
-(void)popUpViewController{
    [self.navigationController popViewControllerAnimated:true];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [MYTOOL hideKeyboard];
}
@end
