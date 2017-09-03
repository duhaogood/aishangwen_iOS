//
//  ForgetPasswordVC.m
//  爱尚问
//
//  Created by Mac on 17/9/1.
//  Copyright © 2017年 杜浩. All rights reserved.
//

#import "ForgetPasswordVC.h"

@interface ForgetPasswordVC ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField * phoneTF;//手机号码
@property(nonatomic,strong)UITextField * codeTF;//验证码
@property(nonatomic,strong)UITextField * passwordTF;//密码
@property(nonatomic,strong)UITextField * passwordAgaginTF;//确认密码
@property(nonatomic,strong)UIButton * sendCodeBtn;//发送验证码按钮
@property(nonatomic,strong)UIButton * setPassBtn;//重设密码按钮
@property(nonatomic,strong)UILabel * checkLabel;//检测手机号

@end

@implementation ForgetPasswordVC
{
    NSTimer * codeTimer;//验证码定时器
    int timeSpace;//时间间隔
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //加载主界面
    [self loadMainView];
}
//加载主界面
-(void)loadMainView{
    //返回按钮
    self.view.backgroundColor = [UIColor whiteColor];
    //返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStyleDone target:self action:@selector(popUpViewController)];
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
            tf.font = [UIFont systemFontOfSize:14];
            tf.frame = CGRectMake(left2, 10, WIDTH/3.0, 20);
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
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = [MYTOOL RGBWithRed:255 green:101 blue:101 alpha:1];
            [self.view addSubview:label];
            label.text = @"";
        }
        //发送验证码按钮
        {
            UIButton * btn = [UIButton new];
            btn.frame = CGRectMake(WIDTH-40-100, 0, 100, 40);
            [btn setBackgroundImage:[UIImage imageNamed:@"yzmbtn_blue_bj"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"yzmbtn_bj"] forState:UIControlStateDisabled];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setTitleColor:MYCOLOR_181_181_181 forState:UIControlStateDisabled];
            [btn setTitle:@"发送验证码" forState:UIControlStateNormal];
            btn.titleLabel.font = [MYFONT fontLittleWithFontSize:14];
            [btn addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
            self.sendCodeBtn = btn;
            [view addSubview:btn];
        }
        
        top += height + 25;
    }
    //数字验证码
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
            icon.image = [UIImage imageNamed:@"pwd"];
            [view addSubview:icon];
            icon.frame = CGRectMake(left1, 13, 10, 14);
        }
        //文本框
        {
            UITextField * tf = [UITextField new];
            tf.placeholder = @"请输入6位数字验证码";
            tf.font = [UIFont systemFontOfSize:14];
            tf.frame = CGRectMake(left2, 10, WIDTH/2.0, 20);
            [view addSubview:tf];
            tf.tag = 200;
            tf.keyboardType = UIKeyboardTypeNumberPad;
            self.codeTF = tf;
        }
        top += height + 15;
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
            tf.font = [UIFont systemFontOfSize:14];
            tf.frame = CGRectMake(left2, 10, WIDTH/2.0, 20);
            [view addSubview:tf];
            tf.tag = 400;
            tf.delegate = self;
            self.passwordTF = tf;
        }
        
        
        top += height + 15;
    }
    //确认密码
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
            tf.placeholder = @"确认登录密码";
            tf.font = [UIFont systemFontOfSize:14];
            tf.frame = CGRectMake(left2, 10, WIDTH/2.0, 20);
            [view addSubview:tf];
            tf.tag = 500;
            tf.delegate = self;
            self.passwordAgaginTF = tf;
        }
        
        
        top += height;
    }
    //密码找回
    {
        UIButton * btn = [UIButton new];
        float btn_top = (HEIGHT-64)/2.0;
        if (btn_top - top < 20) {
            btn_top = top + 20;
        }
        btn.frame = CGRectMake(20, btn_top, WIDTH - 40, 40);
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [btn setTitle:@"密码找回" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        self.setPassBtn = btn;
        btn.titleLabel.font = [MYFONT fontBigWithFontSize:20];
        [btn addTarget:self action:@selector(findBackPasswordCallback) forControlEvents:UIControlEventTouchUpInside];
    }
}


//找回密码
-(void)findBackPasswordCallback{
    [SVProgressHUD showSuccessWithStatus:@"找回成功" duration:1];
    NSString * mobile = self.phoneTF.text;//手机号
    NSString * code = self.codeTF.text;//验证码
    NSString * password = self.passwordTF.text;//密码
    NSString * password2 = self.passwordAgaginTF.text;//确认密码
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
        //验证码
        {
            if (code.length != 6) {
                [SVProgressHUD showErrorWithStatus:@"验证码长度不正确" duration:2];
                return;
            }
        }
        //密码
        {
            if (password.length < 6) {
                [SVProgressHUD showErrorWithStatus:@"密码不能少于6位" duration:2];
                return;
            }
            if (![password isEqualToString:password2]) {
                [SVProgressHUD showErrorWithStatus:@"两次密码不同" duration:2];
                return;
            }
        }
        
    }
    [MYTOOL netWorkingWithTitle:@"找回密码……"];
    /*
     *  1.检验验证码
     *  2.重设密码
     */
    NSString * interface1 = @"/message/vertifyCode.app";
    NSDictionary * send1 = @{
                             @"phone_number":mobile,
                             @"code":code
                             };
    [MYNETWORKING getDataWithInterfaceName:interface1 andDictionary:send1 andSuccess:^(NSDictionary *back_dic, NSString *msg) {
        [MYTOOL netWorkingWithTitle:@"找回密码……"];
        NSString * interface2 = @"/user/forgetPassword.app";
        NSDictionary * send2 = @{
                                 @"phone_number":mobile,
                                 @"user_pass":password
                                 };
        [MYNETWORKING getDataWithInterfaceName:interface2 andDictionary:send2 andSuccess:^(NSDictionary *back_dic, NSString *msg) {
            MYPOPSUCCESS;
            [self popUpViewController];
        } andNoSuccess:^(NSDictionary *back_dic, NSString *msg) {
            MYPOPERROR;
        } andFailure:^(NSURLSessionTask *operation, NSError *error) {
            
        }];
        
    } andNoSuccess:^(NSDictionary *back_dic, NSString *msg) {
        MYPOPERROR;
    } andFailure:^(NSURLSessionTask *operation, NSError *error) {
        
    }];
}
//发送验证码事件
-(void)sendCode:(UIButton *)btn{
    NSString * mobile = self.phoneTF.text;
    //正则表达式匹配11位手机号码
    BOOL isMatch = [MYTOOL isMatchPhoneNumber:mobile];
    if (!isMatch) {
        self.checkLabel.text = @"手机格式不正确";
        [SVProgressHUD showErrorWithStatus:@"手机格式不正确" duration:2];
        return;
    }
    [MYTOOL netWorkingWithTitle:@"短信发送中……"];
    //发送手机号码
    NSString * interface = @"/message/sendMessage.app";
    NSDictionary * send = @{@"phone_number":mobile,@"type":@"1"};//type--0:注册,1:找回密码
    [MYNETWORKING getDataWithInterfaceName:interface andDictionary:send andSuccess:^(NSDictionary *back_dic, NSString *msg) {
        [SVProgressHUD showSuccessWithStatus:msg duration:1];
        //发送成功后,按钮置为不可用
        self.sendCodeBtn.enabled = false;
        timeSpace = 60;
        [self.sendCodeBtn setTitle:[NSString stringWithFormat:@"%d秒后可用",timeSpace] forState:UIControlStateDisabled];
        codeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerWorkInHere) userInfo:nil repeats:true];
        self.setPassBtn.enabled = true;
        self.phoneTF.enabled = false;
    } andNoSuccess:^(NSDictionary *back_dic, NSString *msg) {
        [SVProgressHUD showErrorWithStatus:msg duration:2];
    } andFailure:^(NSURLSessionTask *operation, NSError *error) {
        
    }];
    
}
//定时器任务
-(void)timerWorkInHere{
    timeSpace --;
    if (timeSpace <= 0) {//按钮置为可用
        [codeTimer invalidate];
        codeTimer = nil;
        self.sendCodeBtn.enabled = true;
        return;
    }
    [self.sendCodeBtn setTitle:[NSString stringWithFormat:@"%d秒后可用",timeSpace] forState:UIControlStateDisabled];
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
//返回上个界面
-(void)popUpViewController{
    [self.navigationController popViewControllerAnimated:true];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [MYTOOL hideKeyboard];
}
-(void)viewWillAppear:(BOOL)animated{
    [MYTOOL hiddenTabBar];
}
-(void)viewWillDisappear:(BOOL)animated{
    [MYTOOL showTabBar];
}
@end
