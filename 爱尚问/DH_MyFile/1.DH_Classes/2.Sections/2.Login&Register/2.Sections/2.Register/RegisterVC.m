//
//  RegisterVC.m
//  爱尚问
//
//  Created by Mac on 17/9/1.
//  Copyright © 2017年 杜浩. All rights reserved.
//

#import "RegisterVC.h"
#import "UserAgreementVC.h"
@interface RegisterVC ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField * phoneTF;//手机号码
@property(nonatomic,strong)UITextField * codeTF;//验证码
@property(nonatomic,strong)UITextField * nickNameTF;//昵称
@property(nonatomic,strong)UITextField * passwordTF;//密码
@property(nonatomic,strong)UITextField * passwordAgaginTF;//确认密码
@property(nonatomic,strong)UIButton * sendCodeBtn;//发送验证码按钮
@property(nonatomic,strong)UIButton * registerBtn;//注册按钮
@property(nonatomic,strong)UILabel * checkLabel;//检测手机号
@property(nonatomic,strong)UITextField * recommenderPhoneTF;//推荐人手机号码

@end

@implementation RegisterVC
{
    NSTimer * codeTimer;//验证码定时器
    int timeSpace;//时间间隔
    NSString * codeid_id;//验证码id
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
            tf.font = [MYFONT fontLittleWithFontSize:14];
            tf.frame = CGRectMake(left2, 10, WIDTH - left2 - 100 - 40, 20);
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
        top += height + 20;
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
            tf.font = [MYFONT fontLittleWithFontSize:14];
            tf.frame = CGRectMake(left2, 10, WIDTH - left2 - 40, 20);
            [view addSubview:tf];
            tf.tag = 200;
            tf.keyboardType = UIKeyboardTypeNumberPad;
            self.codeTF = tf;
        }
        top += height + 15;
    }
    //昵称
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
            icon.image = [UIImage imageNamed:@"username"];
            [view addSubview:icon];
            icon.frame = CGRectMake(left1, 12, 15, 16);
        }
        //文本框
        {
            UITextField * tf = [UITextField new];
            tf.placeholder = @"设置昵称";
            tf.font = [MYFONT fontLittleWithFontSize:14];
            tf.frame = CGRectMake(left2, 10, WIDTH - left2 - 40, 20);
            [view addSubview:tf];
            tf.tag = 300;
            self.nickNameTF = tf;
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
            tf.font = [MYFONT fontLittleWithFontSize:14];
            tf.frame = CGRectMake(left2, 10, WIDTH - left2 - 40, 20);
            [view addSubview:tf];
            tf.tag = 400;
            tf.delegate = self;
            self.passwordTF = tf;
        }
        top += height + 15;
    }
    //确定密码
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
            tf.font = [MYFONT fontLittleWithFontSize:14];
            tf.frame = CGRectMake(left2, 10, WIDTH - left2 - 40, 20);
            [view addSubview:tf];
            tf.tag = 500;
            tf.delegate = self;
            self.passwordAgaginTF = tf;
        }
        top += height +15;
    }
    //推荐人手机号码
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
            tf.placeholder = @"推荐人手机,可不填";
            tf.font = [MYFONT fontLittleWithFontSize:14];
            tf.frame = CGRectMake(left2, 10, WIDTH - left2 - 100 - 40, 20);
            tf.delegate = self;
            tf.tag = 600;
            tf.keyboardType = UIKeyboardTypeNumberPad;
            [view addSubview:tf];
            self.recommenderPhoneTF = tf;
        }
    }
    //注册控件
    {
        //底部还剩高度
        float lower_height = HEIGHT - 64 - top;
        //按钮底部top
        float btn_lower_top = top + lower_height / 2.0;
        //登录按钮
        {
            UIButton * btn = [UIButton new];
            btn.frame = CGRectMake(20, btn_lower_top - 45, WIDTH - 40, 40);
            btn.titleLabel.font = [MYFONT fontLittleWithFontSize:25];
            [btn setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
            [btn setTitle:@"注 册" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.view addSubview:btn];
            self.registerBtn = btn;
            btn.enabled = false;
            [btn addTarget:self action:@selector(registerCallback) forControlEvents:UIControlEventTouchUpInside];
        }
        //提示信息
        btn_lower_top += 10;
        {
            UILabel * label = [UILabel new];
            label.text = @"*注册即表示您同意";
            label.font = [MYFONT fontLittleWithFontSize:12];
            label.textColor = [MYTOOL RGBWithRed:112 green:112 blue:112 alpha:1];
            label.textAlignment = NSTextAlignmentRight;
            CGSize size = [MYTOOL getSizeWithLabel:label];
            label.frame = CGRectMake(0, btn_lower_top, WIDTH/2.0, size.height);
            [self.view addSubview:label];
        }
        //协议按钮
        {
            UIButton * btn = [UIButton new];
            [btn setTitleColor:[MYTOOL RGBWithRed:25 green:101 blue:225 alpha:1] forState:UIControlStateNormal];
            [btn setTitle:@"《爱尚问用户使用协议》" forState:UIControlStateNormal];
            btn.frame = CGRectMake(WIDTH/2.0, btn_lower_top+1, 140, 14);
            [self.view addSubview:btn];
            btn.titleLabel.font = [MYFONT fontLittleWithFontSize:12];
            [btn addTarget:self action:@selector(userAgreeBtnCallback) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
}
//用户协议事件
-(void)userAgreeBtnCallback{
    [MYTOOL netWorkingWithTitle:@"获取协议……"];
    NSString * interface = @"/system/getUserAgreement.app";
    [MYNETWORKING getDataWithInterfaceName:interface andDictionary:nil andSuccess:^(NSDictionary *back_dic, NSString *msg) {
        [SVProgressHUD showSuccessWithStatus:msg duration:1];
        NSString * title = back_dic[@"title"];
        NSString * url = back_dic[@"url"];
        UserAgreementVC * vc = [UserAgreementVC new];
        vc.title = title;
        vc.url = url;
        [self.navigationController pushViewController:vc animated:true];
    } andNoSuccess:^(NSDictionary *back_dic, NSString *msg) {
        [SVProgressHUD showErrorWithStatus:msg duration:2];
    } andFailure:^(NSURLSessionTask *operation, NSError *error) {
        
    }];
    
    
}
//注册事件
-(void)registerCallback{
    //参数
    NSString * phone_number = self.phoneTF.text;//手机号
    NSString * code = self.codeTF.text;//验证码
    NSString * nick_name = self.nickNameTF.text;//昵称
    NSString * password = self.passwordTF.text;//密码
    NSString * password2 = self.passwordAgaginTF.text;//确认密码
    NSString * recommender_phone_number = self.recommenderPhoneTF.text;//推荐人手机号码
    //验证
    {
        //手机号
        {
            //正则表达式匹配11位手机号码
            BOOL isMatch = [MYTOOL isMatchPhoneNumber:phone_number];
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
        //昵称
        {
            if (nick_name.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"昵称必填" duration:2];
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
                [SVProgressHUD showErrorWithStatus:@"确认密码是否相同" duration:2];
                return;
            }
        }
        //推荐人手机号码
        {
            if (!(recommender_phone_number == nil || recommender_phone_number.length == 0)) {
                //正则表达式匹配11位手机号码
                BOOL isMatch = [MYTOOL isMatchPhoneNumber:recommender_phone_number];
                if (!isMatch) {
                    [SVProgressHUD showErrorWithStatus:@"推荐人手机格式不正确" duration:2];
                    return;
                }
            }
        }
    }
    [MYTOOL netWorkingWithTitle:@"验证码校验……"];
    /**
     *  1.先认证验证码是否正确
     *  2.如果验证码正确，则继续注册
     *
     */
    NSString * interface1 = @"/message/vertifyCode.app";
    NSDictionary * send1 = @{
                            @"phone_number": phone_number,
                            @"code": code
                            };
    [MYNETWORKING getDataWithInterfaceName:interface1 andDictionary:send1 andSuccess:^(NSDictionary *back_dic, NSString *msg) {
        NSString * interface1 = @"/user/register.app";
        NSDictionary * send1 = @{
                                 @"phone_number": phone_number,
                                 @"nick_name":nick_name,
                                 @"platform":@"iOS",
                                 @"password":password
                                 };
        if (!(recommender_phone_number == nil || recommender_phone_number.length == 0)) {
            send1 = @{
                      @"phone_number": phone_number,
                      @"nick_name":nick_name,
                      @"password":password,
                      @"platform":@"iOS",
                      @"recommender":recommender_phone_number
                      };
        }
        [MYTOOL netWorkingWithTitle:@"注册中……"];
        [MYNETWORKING getDataWithInterfaceName:interface1 andDictionary:send1 andSuccess:^(NSDictionary *back_dic, NSString *msg) {
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
    NSDictionary * send = @{@"phone_number":mobile,@"type":@"0"};//type--0:注册,1:找回密码
    [MYNETWORKING getDataWithInterfaceName:interface andDictionary:send andSuccess:^(NSDictionary *back_dic, NSString *msg) {
        [SVProgressHUD showSuccessWithStatus:msg duration:1];
        //发送成功后,按钮置为不可用
        self.sendCodeBtn.enabled = false;
        timeSpace = 60;
        [self.sendCodeBtn setTitle:[NSString stringWithFormat:@"%d秒后可用",timeSpace] forState:UIControlStateDisabled];
        codeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerWorkInHere) userInfo:nil repeats:true];
        self.registerBtn.enabled = true;
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
        self.phoneTF.enabled = true;
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
#pragma mark - 键盘出现及消失通知
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    NSArray * array = @[self.passwordAgaginTF,self.passwordTF,self.recommenderPhoneTF];
    UITextField * tf = nil;
    for (UITextField * tff in array) {
        if (tff.isFirstResponder) {
            tf = tff;
            break;
        }
    }
    if (tf == nil) {
        return;
    }
    //键盘高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    //someOne相对屏幕上侧位置
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[tf convertRect: [tf bounds] toView:window];
    //文本框底部高度
    float tv_top = rect.origin.y + [tf frame].size.height;
    if (tv_top + height > HEIGHT) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame = CGRectMake(0, HEIGHT - height - tv_top + 64, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
    
}
//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    }];
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
}
-(void)viewWillDisappear:(BOOL)animated{
    [MYTOOL showTabBar];
    //删除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


@end
